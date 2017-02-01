//
//  Timer.swift
//  AlphabetOrder
//
//  Created by Satvik Borra on 12/19/16.
//  Copyright © 2016 vborra. All rights reserved.
//

import UIKit

class SquareTimer: UIView, CAAnimationDelegate{

    
//    var layer: CALayer?
    static let null = SquareTimer(frame: CGRect.zero, lineWidth: 0)
    
    var done = {}
    
    var animation: CABasicAnimation!
    var animationViewPosition: CAAnimation!
    var progressLayer: CAShapeLayer = CAShapeLayer()
 
    var countdownLabel: UILabel!
    var counter: Int = 3
    var counterTimer: Timer!
    
    init(frame: CGRect, lineWidth: CGFloat){
        super.init(frame: frame)
        
        countdownLabel = UILabel(frame: frame)
        countdownLabel.isUserInteractionEnabled = false
        countdownLabel.text = ""
        countdownLabel.textAlignment = .center
        countdownLabel.textColor = UIColor.white
        countdownLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 8))
        countdownLabel.adjustsFontSizeToFitWidth = true
        
        
        let newLineWidth = lineWidth*2
        

        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)).cgPath
        progressLayer = CAShapeLayer()
        progressLayer.fillColor = UIColor.clear.cgColor
        
        progressLayer.lineWidth = newLineWidth
        progressLayer.strokeStart = 0
        progressLayer.path = path
        progressLayer.strokeEnd = 0
        progressLayer.opacity = 0
        
        progressLayer.shadowRadius = Neon.shadowRadius
        progressLayer.shadowOpacity = Neon.shadowOpacity
        progressLayer.shadowOffset = Neon.shadowOffset
        progressLayer.masksToBounds = Neon.masksToBounds
        
        self.layer.addSublayer(progressLayer)
        
        self.addSubview(countdownLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeColor(col: UIColor){
        progressLayer.strokeColor = col.cgColor
        progressLayer.shadowColor = col.cgColor
    }
    
    func start(time: CGFloat){
        animation = CABasicAnimation(keyPath: "strokeEnd")
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
        animationViewPosition = progressLayer.animation(forKey: "timer")?.copy() as! CAAnimation!
        
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    func resume(delay: CGFloat = 3){
        if(animationViewPosition != nil){
            progressLayer.add(animationViewPosition, forKey: "timer")
            animationViewPosition = nil
        }
        
        counter = Int(delay)
        
        self.bringSubview(toFront: countdownLabel)
        countdownLabel.isUserInteractionEnabled = true

        counterTimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay*1000)), execute: {
            // Put your code which should be executed with a delay here
            let pausedTime = self.layer.timeOffset
            self.layer.speed = 1.0
            self.layer.timeOffset = 0.0
            self.layer.beginTime = 0.0
            let timeSincePause = self.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            self.layer.beginTime = timeSincePause
            self.countdownLabel.isUserInteractionEnabled = false
            GameController.sharedInstance.gamePaused = false
        })
    }
    
    func updateCounter() {
        //you code, this is an example
        if counter > 0 {
            print("\(counter) seconds to the end of the world")
            countdownLabel.text = "\(counter)"
            counter -= 1
        }else{
            counter = 3
            countdownLabel.text = ""
            counterTimer.invalidate()
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Timer finish \(flag)")
        if(flag){
            timerFinished()
        }
    }
    
    func timerFinished(){
        done()
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
