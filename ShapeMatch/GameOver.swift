//
//  GameOver.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class GameOver : UIView{
    
    let transitionTime : CGFloat = 0.5
    
    var homeButton : Square;
    var replayButton : Square;
    var shareButton : Square;
    
    
    var gameOverLabel : Label!;
    
    var score : Int = 0
    
    override init(frame: CGRect) {
        let buttonsY : CGFloat = 0.7
        let buttonWidth : CGFloat = 0.26;
        let buttonHeight : CGFloat = 0.15;
        let sidePadding : CGFloat = 0.1;
        
        let titleLabelSize = CGSize(width: 0.8, height: 0.15)// Screen.getScreenSize(x: 0.8, y: 0.3)
        gameOverLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Game Over", _outPos: /*Screen.getScreenPos(x: 0.1, y: -0.3)*/Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.075), debugFrame: true)
        gameOverLabel.changeTextColor(color: .red)
        gameOverLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 10))
        gameOverLabel.adjustsFontSizeToFitWidth = true;
        
        
        homeButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos : Screen.getScreenPos(x: sidePadding+(buttonWidth/2), y: buttonsY));
        homeButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .GameOver, to: .MainMenu);
        }
        
        replayButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos : Screen.getScreenPos(x: sidePadding+(1*buttonWidth)+buttonWidth/2, y: buttonsY));
        replayButton.tap = {
//            print("To Game")
            GameController.sharedInstance.switchFromTo(from: .GameOver, to: .Game);
        }
        
        shareButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos : Screen.getScreenPos(x: sidePadding+(2*buttonWidth)+buttonWidth/2, y: buttonsY));
        shareButton.tap = {
            print("Show gamecenter")
            //            GameController.sharedInstance.switchFromTo(from: .MainMenu, to: .Game);
        }
        
        super.init(frame: frame);
        
        self.addSubview(homeButton);
        self.addSubview(replayButton);
        self.addSubview(shareButton);
        self.addSubview(gameOverLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        homeButton.animateIn(time: transitionTime)
        replayButton.animateIn(time: transitionTime)
        shareButton.animateIn(time: transitionTime)
        gameOverLabel.animateIn(time: transitionTime)
    }
    
    func animateOut(){
        homeButton.animateOut(time: transitionTime);
        replayButton.animateOut(time: transitionTime);
        shareButton.animateOut(time: transitionTime);
        gameOverLabel.animateOut(time: transitionTime)
    }
}
