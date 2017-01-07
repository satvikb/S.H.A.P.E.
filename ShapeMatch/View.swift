//
//  View.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/25/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class View : UIView{
    
    let outPos : CGPoint
    let inPos : CGPoint

    init(frame : CGRect, _outPos : CGPoint, _inPos : CGPoint){
        outPos = _outPos
        inPos = _inPos
        
        let newFrame = CGRect(origin: outPos, size: frame.size)
        super.init(frame: newFrame)
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
