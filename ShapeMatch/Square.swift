//
//  Square.swift
//  AlphabetOrder
//
//  Created by Satvik Borra on 12/18/16.
//  Copyright © 2016 vborra. All rights reserved.
//

import UIKit

class Square: UIView{
    static let null = Square(frame: CGRect.zero, color: UIColor.clear)
    
    var id: Int = -1
    
    var tap = {}
    var outPos: CGPoint
    var inPos: CGPoint
    
    var label: UILabel
    var imageView: UIImageView
    
    init(frame: CGRect, color: UIColor, _outPos: CGPoint = CGPoint.zero, _inPos: CGPoint = CGPoint.zero, text: String = "", center: Bool = false) {
        outPos = _outPos
        inPos = _inPos

        label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        label.text = text
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 5))
        label.textColor = UIColor.white
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.isUserInteractionEnabled = true
        
        let newFrame = CGRect(origin: CGPoint.outOfScreen, size: frame.size)
        
        super.init(frame: newFrame)
        
        if(center){
            self.frame.origin = getCenterPos(pos: outPos)
        }else{
            self.frame.origin = outPos
        }
        
//        layer.shadowColor = color.cgColor
//        layer.shadowRadius = 15
//        layer.shadowOpacity = 0.9
//        layer.shadowOffset = CGSize.zero
//        layer.masksToBounds = false
        
        self.backgroundColor = color
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        
        
        self.addSubview(label)
        self.addSubview(imageView)
        self.addGestureRecognizer(tapRec)

    }
    
    func setImage(image: UIImage){
        imageView.image = image
    }
    
    func getCenterPos(pos: CGPoint) -> CGPoint{
        return CGPoint(x: pos.x-(frame.size.width/2), y: pos.y-(frame.size.height/2))
    }
    
    func tapped(){
        self.tap()
    }
    
    func changeColor(color: UIColor){
        //TODO: Animate
        self.backgroundColor = color
//        layer.shadowColor = color.cgColor
    }
    
    func animateIn(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.frame.origin = self.getCenterPos(pos: self.inPos)
        })
    }
    
    func animateOut(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.frame.origin = self.getCenterPos(pos: self.outPos)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
