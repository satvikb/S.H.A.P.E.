//
//  Settings.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/22/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class Settings: UIView{
    
    let transitionTime: CGFloat = 0.5
    
    var titleLabel: Label = Label.Null
    
    var settingsButton: Square
    var playButton: Square
    var leaderboardButton: Square
    
    override init(frame: CGRect) {
        let buttonsY: CGFloat = 0.7
        let buttonWidth: CGFloat = 0.26
        let buttonHeight: CGFloat = 0.15
        let sidePadding: CGFloat = 0.1
        
        let startOutPos: CGPoint = Screen.getScreenPos(x: 0.5-(buttonWidth/2), y: 1+buttonHeight)
        
        let titleLabelSize = CGSize(width: 0.8, height: 0.3)// Screen.getScreenSize(x: 0.8, y: 0.3)
        titleLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Settings", _outPos: /*Screen.getScreenPos(x: 0.1, y: -0.3)*/Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.1))
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 10))
        
        settingsButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: startOutPos, _inPos: Screen.getScreenPos(x: sidePadding+(buttonWidth/2), y: buttonsY))
        settingsButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .MainMenu, to: .Settings)
        }
        
        playButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: startOutPos, _inPos: Screen.getScreenPos(x: sidePadding+(1*buttonWidth)+buttonWidth/2, y: buttonsY))
        playButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .MainMenu, to: .Game)
        }
        
        leaderboardButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: startOutPos, _inPos: Screen.getScreenPos(x: sidePadding+(2*buttonWidth)+buttonWidth/2, y: buttonsY))
        leaderboardButton.tap = {
            print("Show gamecenter")
            
        }
        
        super.init(frame: frame)
        
        self.addSubview(settingsButton)
        self.addSubview(playButton)
        self.addSubview(leaderboardButton)
        self.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        playButton.animateIn(time: transitionTime)
        settingsButton.animateIn(time: transitionTime)
        leaderboardButton.animateIn(time: transitionTime)
        titleLabel.animateIn(time: transitionTime)
    }
    
    func animateOut(){
        playButton.animateOut(time: transitionTime)
        settingsButton.animateOut(time: transitionTime)
        leaderboardButton.animateOut(time: transitionTime)
        titleLabel.animateOut(time: transitionTime)
    }
}
