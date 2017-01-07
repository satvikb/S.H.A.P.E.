//
//  MovingShape.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 5/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class GestureView : UIView{
    
    var numTouches = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numTouches += touches.count
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        numTouches -= touches.count
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        numTouches -= touches.count
    }
}

class MovingShape: UIView, UIGestureRecognizerDelegate {

    //RADIANS
    var radians: CGFloat = 0
    
    var size: CGSize = CGSize.zero
    var startSize: CGSize = CGSize.zero
    
    fileprivate var color: UIColor! = UIColor.blue
    
    var gestureView: GestureView!
    
    var tapGR: UITapGestureRecognizer!
    var panGR: UIPanGestureRecognizer!
    
    
    var numTouches : Int = 0
    
    
    private var maxFrameSize : CGSize = CGSize(width: Screen.screenSize.width/2, height: Screen.screenSize.height/2)
    
    init(position: CGPoint, size: CGSize, gestureViewSize: CGSize = UIScreen.main.bounds.size, gestureViewPos: CGPoint = CGPoint.zero){
        super.init(frame: CGRect(x: position.x, y: position.y, width: size.width, height: size.height))
        
        self.size = size
        self.startSize = size
        
        setColor(Functions.randomColor())
        
        gestureView = GestureView(frame: CGRect(x: gestureViewPos.x, y: gestureViewPos.y, width: gestureViewSize.width, height: gestureViewSize.height))
        
        layer.shadowRadius = Neon.shadowRadius
        layer.shadowOpacity = Neon.shadowOpacity
        layer.shadowOffset = Neon.shadowOffset
        layer.masksToBounds = Neon.masksToBounds
        
        self.isUserInteractionEnabled = false
        self.gestureView.isMultipleTouchEnabled = true
        
        calculateMaxScale()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(_ col: UIColor){
        color = col
        self.backgroundColor = color
        layer.shadowColor = col.cgColor
    }
    
    func setupGestureRecognizers(){
        tapGR = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        tapGR.delegate = self
        gestureView.addGestureRecognizer(tapGR)
        
        panGR = UIPanGestureRecognizer(target: self, action: #selector(self.didPan(_:)))
        panGR.delegate = self
        gestureView.addGestureRecognizer(panGR)
        
        let rotationGR = UIRotationGestureRecognizer(target: self, action: #selector(self.didRotate(_:)))
        rotationGR.delegate = self
        gestureView.addGestureRecognizer(rotationGR)
        
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(self.didPinch(_:)))
        pinchGR.delegate = self
        gestureView.addGestureRecognizer(pinchGR)
    }
    
    var maxScale : CGFloat = 1
    var minScale : CGFloat = 0.3
    
    func calculateMaxScale(){
        let maxActualSideLength = max(Screen.screenSize.width/2, Screen.screenSize.height/2)
        let longerSide = max(self.startSize.width, self.startSize.height)
        maxScale = maxActualSideLength/longerSide
        print("Max Scale: \(maxScale)")
        
    }
    
    func didTap(_ tapGR: UITapGestureRecognizer){
        
    }
    
    func didPan(_ panGR: UIPanGestureRecognizer) {
        //TODO: Instead of setting the pan gesture for min and max touches, use a if here, so then we can pause the game if the user does not have two touches on screen
        self.superview!.bringSubview(toFront: self)
        
        var translation = panGR.translation(in: self)
        
        translation = translation.applying(self.transform)
        
        self.center.x += translation.x
        self.center.y += translation.y
        
        panGR.setTranslation(CGPoint.zero, in: self)
        
        gestureHappened()
    }
    
    func didPinch(_ pinchGR: UIPinchGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        
        let transformSize = __CGSizeApplyAffineTransform(self.startSize, self.transform)
        
        let scaleX = abs(transformSize.width/startSize.width)//abs(self.transform.a)
        let scaleY = abs(transformSize.height/startSize.height)//abs(self.transform.d)
        
        let maxScale = max(scaleX, scaleY)
        
        print("Scale: \(maxScale) \(scaleX) \(scaleY) \(transformSize) \(self.frame.size) \(self.startSize)")
        if(maxScale < maxScale && maxScale > minScale){
            let scale = pinchGR.scale
            print("GR Scale: \(scale)")
            self.transform = self.transform.scaledBy(x: scale, y: scale)
            pinchGR.scale = 1.0
        }else if(maxScale > maxScale){
            let scale = pinchGR.scale
            print("Larger")
            if(scale <= 1){
                self.transform = self.transform.scaledBy(x: scale, y: scale)
                pinchGR.scale = 1.0
            }
        }else if(maxScale < minScale){
            let scale = pinchGR.scale
            print("Smaller")
            if(scale >= 1){
                self.transform = self.transform.scaledBy(x: scale, y: scale)
                pinchGR.scale = 1.0
            }
        }
        
//        else if(self.transform.a >= maxScale){
//            let radians: CGFloat = atan2( (self.transform.b), (self.transform.a))
//            
//            self.transform = CGAffineTransform(scaleX: maxScale/1.01, y: maxScale/1.01)
////            self.transform = self.transform.rotated(by: radians)
//        }else if(self.transform.a <= minScale){
//            let radians: CGFloat = atan2( (self.transform.b), (self.transform.a))
//            
//            self.transform = CGAffineTransform(scaleX: minScale*1.01, y: minScale*1.01)
////            self.transform = self.transform.rotated(by: radians)
//        }

        gestureHappened()
    }
    
    func didRotate(_ rotationGR: UIRotationGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        
        let rotation = rotationGR.rotation
        print("Rotate \(rotation)")
        self.transform = self.transform.rotated(by: rotation)
        rotationGR.rotation = 0.0
        let radians: CGFloat = atan2( (self.transform.b), (self.transform.a))
        
        self.radians = radians
        gestureHappened()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        recievedTouch()
        return true
    }
    
    func gestureHappened(){
        anyGestureHappened()
    }
    
    var recievedTouch = {}
    var anyGestureHappened = {}
    
    func animateOut(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.center = CGPoint(x: self.center.x, y: Screen.getScreenPos(x: 0, y: 2).y)
        })
    }
  
}

