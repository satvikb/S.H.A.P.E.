//
//  Timer.swift
//  AlphabetOrder
//
//  Created by Satvik Borra on 12/19/16.
//  Copyright © 2016 vborra. All rights reserved.
//

import UIKit

class SquareTimer : UIView, CAAnimationDelegate{

    static let null = SquareTimer(frame: CGRect.zero, lineWidth: 0);
    
    var done = {}
    
    var progressLayer : CAShapeLayer = CAShapeLayer()
 
    init(frame : CGRect, lineWidth : CGFloat){
        super.init(frame: frame);
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)).cgPath
        progressLayer = CAShapeLayer()
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.red.cgColor
        
        progressLayer.lineWidth = lineWidth;
        progressLayer.strokeStart = 0
        progressLayer.path = path
        progressLayer.strokeEnd = 0
        progressLayer.opacity = 0
        
        progressLayer.shadowRadius = 15
        progressLayer.shadowOpacity = 0.9
        progressLayer.shadowOffset = CGSize.zero
        progressLayer.masksToBounds = false
        
        self.layer.addSublayer(progressLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func start(time : CGFloat){
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(1.0)
        animation.toValue = CGFloat(0.0)
        animation.duration = CFTimeInterval(time)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = kCAFillModeBackwards
        progressLayer.add(animation, forKey: "timer")
    }
    
    func reset(time : CGFloat){
        progressLayer.removeAnimation(forKey: "timer")
        start(time: time)
    }
    
    func removeTimer(){
        progressLayer.removeAnimation(forKey: "timer")
    }
    
    func pause(){
        progressLayer.speed = 0
    }
    
    func resume(){
        progressLayer.speed = 1
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if(flag){
        timerFinished()
        }
    }
    
    func timerFinished(){
        self.done()
    }
    
    func getCenterPos(pos : CGPoint) -> CGPoint{
        return CGPoint(x: pos.x-(frame.size.width/2), y: pos.y-(frame.size.height/2));
    }
    
    func animateIn(time : CGFloat){
//        UIView.animate(withDuration: TimeInterval(time), animations: {
//            self.frame.origin = self.getCenterPos(pos: self.inPos);
//        })
        
//        let fadeIn = CABasicAnimation(keyPath: "opacity")
//        fadeIn.fromValue = 0
//        fadeIn.toValue = 1
//        fadeIn.duration = CFTimeInterval(time);
//        fadeIn.isRemovedOnCompletion = false
//        fadeIn.fillMode = kCAFillModeForwards
//        progressLayer.add(fadeIn, forKey: "fadeIn")
        
        progressLayer.opacity = 1
    }
    
    func animateOut(time : CGFloat){
//        UIView.animate(withDuration: TimeInterval(time), animations: {
//            self.frame.origin = self.getCenterPos(pos: self.outPos);
//        })
        
//        let fadeOut = CABasicAnimation(keyPath: "opacity")
//        fadeOut.fromValue = 1
//        fadeOut.toValue = 0
//        fadeOut.duration = CFTimeInterval(time);
//        fadeOut.isRemovedOnCompletion = false
//        fadeOut.fillMode = kCAFillModeForwards
//        progressLayer.add(fadeOut, forKey: "fadeOut")
        
        progressLayer.opacity = 0
    }
}
