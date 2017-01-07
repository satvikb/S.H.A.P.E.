//
//  Label.swift
//  AlphabetOrder
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 vborra. All rights reserved.
//

import UIKit

class Label: UILabel{
    
    static let Null = Label(frame: CGRect.zero, text: "")
    
    var outPos: CGPoint!
    var inPos: CGPoint!
    
    var neon: Bool = true
    
    init(frame: CGRect, text: String, _outPos: CGPoint = CGPoint.zero, _inPos: CGPoint = CGPoint.zero, textColor: UIColor = UIColor.white, debugFrame: Bool = false, _neon: Bool = true){
        outPos = _outPos
        inPos = _inPos
        neon = _neon
        
        let newFrame = CGRect(origin: outPos, size: frame.size)
        super.init(frame: newFrame)
        
        if(debugFrame){
            self.layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 5
        }
        
        adjustsFontSizeToFitWidth = true
        
        if(neon){
            layer.shadowRadius = Neon.shadowRadius
            layer.shadowOpacity = Neon.shadowOpacity
            layer.shadowOffset = Neon.shadowOffset
            layer.masksToBounds = Neon.masksToBounds
        }
        changeTextColor(color: textColor)
        self.text = text
    }
    
    func changeTextColor(color: UIColor){
        textColor = color
        
        if(neon){
            layer.shadowColor = color.cgColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.frame.origin = self.inPos
        })
    }
    
    func animateOut(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.frame.origin = self.outPos
        })
    }
    
}
