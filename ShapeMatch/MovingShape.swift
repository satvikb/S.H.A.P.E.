//
//  MovingShape.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 5/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class MovingShape: UIView, UIGestureRecognizerDelegate {

    //RADIANS
    var radians: CGFloat = 0
    
    var size: CGSize = CGSize.zero
    var startSize: CGSize = CGSize.zero
    
    fileprivate var color: UIColor! = UIColor.blue
    
    var gestureView: UIView!
    
    var panGR: UIPanGestureRecognizer!
    
    init(position: CGPoint, size: CGSize, gestureViewSize: CGSize = UIScreen.main.bounds.size, gestureViewPos: CGPoint = CGPoint.zero){
        super.init(frame: CGRect(x: position.x, y: position.y, width: size.width, height: size.height))
        
        self.size = size
        self.startSize = size
        
        setColor(Functions.randomColor())
        
        gestureView = UIView(frame: CGRect(x: gestureViewPos.x, y: gestureViewPos.y, width: gestureViewSize.width, height: gestureViewSize.height))
        
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
        
        self.isUserInteractionEnabled = false
        self.gestureView.isMultipleTouchEnabled = true
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
        panGR = UIPanGestureRecognizer(target: self, action: #selector(self.didPan(_:)))
        panGR.delegate = self
        
        gestureView.addGestureRecognizer(panGR)
        
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(self.didPinch(_:)))
        pinchGR.delegate = self
        gestureView.addGestureRecognizer(pinchGR)
        
        let rotationGR = UIRotationGestureRecognizer(target: self, action: #selector(self.didRotate(_:)))
        rotationGR.delegate = self
        gestureView.addGestureRecognizer(rotationGR)
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
        
        let scale = pinchGR.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        pinchGR.scale = 1.0
        
        gestureHappened()
    }
    
    func didRotate(_ rotationGR: UIRotationGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        
        let rotation = rotationGR.rotation
        self.transform = self.transform.rotated(by: rotation)
        rotationGR.rotation = 0.0
        
        let radians: CGFloat = atan2( (self.transform.b), (self.transform.a))
        
        self.radians = radians
        gestureHappened()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureHappened(){
        anyGestureHappened()
    }
    
    var anyGestureHappened = {}
    
    func animateOut(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.center = CGPoint(x: self.center.x, y: Screen.getScreenPos(x: 0, y: 2).y)
        })
    }
  
}

