//
//  SettingButton.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class SettingButton: UIView {
    
    static let activatedImage: UIImage = #imageLiteral(resourceName: "Check.png")
    
    var inPos: CGPoint
    var outPos: CGPoint
    
    var activated: Bool = false
    var imageView: UIImageView
    
    var tap = {}

    init(frame: CGRect, _inPos: CGPoint, _outPos: CGPoint, _activated: Bool = false, frameColor: UIColor = UIColor.white){
        inPos = _inPos
        outPos = _outPos
        activated = _activated
        
        imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        imageView.isUserInteractionEnabled = true
        
        
        imageView.tintColor = UIColor.red
        
        if(activated == true){
            imageView.image = SettingButton.activatedImage
        }else{
            imageView.image = nil
        }

        let newFrame: CGRect = CGRect(origin: _outPos, size: frame.size)
        super.init(frame: newFrame)
        
        layer.borderWidth = 2
        layer.borderColor = frameColor.cgColor
        
        let tapRec = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        addGestureRecognizer(tapRec)
        
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tapped(){
        activated = !activated
        
        if(activated == true){
            imageView.image = SettingButton.activatedImage
        }else{
            imageView.image = nil
        }
        
        self.tap()
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
