//
//  Timer.swift
//  AlphabetOrder
//
//  Created by Satvik Borra on 12/19/16.
//  Copyright © 2016 vborra. All rights reserved.
//

import UIKit

class SquareTimer: UIView, CAAnimationDelegate{

    static let null = SquareTimer(frame: CGRect.zero, lineWidth: 0)
    
    var done = {}
    
    var progressLayer: CAShapeLayer = CAShapeLayer()
 
    init(frame: CGRect, lineWidth: CGFloat){
        super.init(frame: frame)
        
        let newLineWidth = lineWidth*2
        
        let path = UIBezierPath(rect: CGRect(x: lineWidth/2, y: lineWidth, width: frame.size.width-lineWidth, height: frame.size.height-lineWidth*2)).cgPath
        progressLayer = CAShapeLayer()
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.red.cgColor
        
        progressLayer.lineWidth = newLineWidth
        progressLayer.strokeStart = 0
        progressLayer.path = path
        progressLayer.strokeEnd = 0
        progressLayer.opacity = 0
        
        progressLayer.shadowRadius = Neon.shadowRadius
        progressLayer.shadowOpacity = Neon.shadowOpacity
        progressLayer.shadowOffset = Neon.shadowOffset
        progressLayer.masksToBounds = Neon.masksToBounds
        
        pause()
        
        self.layer.addSublayer(progressLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor(col: UIColor){
        progressLayer.strokeColor = col.cgColor
        progressLayer.shadowColor = col.cgColor
    }
    
    func start(time: CGFloat){
        
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
    
    func reset(time: CGFloat){
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
    
    func getCenterPos(pos: CGPoint) -> CGPoint{
        return CGPoint(x: pos.x-(frame.size.width/2), y: pos.y-(frame.size.height/2))
    }
    
    func animateIn(time: CGFloat){
        progressLayer.opacity = 1
    }
    
    func animateOut(time: CGFloat){
        progressLayer.opacity = 0
    }
}
