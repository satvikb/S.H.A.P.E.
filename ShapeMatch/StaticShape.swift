//
//  StaticShape.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 5/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class StaticShape : UIView {
    
    //RADIANS
    var radians : CGFloat = 0
    
    var size : CGSize = CGSize.zero
    var pos : CGPoint = CGPoint.zero
    
    var startSize : CGSize = CGSize.zero
    
    var col : UIColor! = UIColor.blue
    
    init(position : CGPoint, size : CGSize){
        super.init(frame: CGRect(x: position.x, y: position.y, width: size.width, height: size.height))
        
        self.pos = position
        self.size = size
        self.startSize = size;
        
        setColor(Functions.randomColor())
        setRotation(Functions.randomRadian())
        
        self.layer.borderWidth = 3
        
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize.zero
        layer.masksToBounds = false
        
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(_ coler : UIColor){
        col = coler
        self.backgroundColor = UIColor.clear//color
        self.layer.borderColor = col.cgColor;
        layer.shadowColor = coler.cgColor
    }
    
    func setRotation(_ radians : CGFloat){
        self.radians = radians
        self.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
    }
    
    func animateOut(time : CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.center = CGPoint(x: self.center.x, y: Screen.getScreenPos(x: 0, y: 2).y)
        })
    }
}
