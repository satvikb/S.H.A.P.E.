//
//  MultiplayerGameOver.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class MultiplayerGameOver: UIView{
    
    let transitionTime: CGFloat = 0.5
    
    var homeButton: Square
    var replayButton: Square
    
    var gameOverLabel: Label!
    
    var upScoreLabel: Label!
    var upScorePlayerLabel: Label!

    var downScoreLabel: Label!
    var downScorePlayerLabel: Label!

    var horizontalLine : UIView!
    var horizontalLineOutPos : CGPoint = Screen.getScreenPos(x: -0.6, y: 0.5)
    var horizontalLineInPos : CGPoint = Screen.getScreenPos(x: 0.5, y: 0.5)

    var upScore: Int = 0
    var downScore : Int = 0
    
    override init(frame: CGRect) {
        let buttonsY: CGFloat = 0.85
        let buttonWidth: CGFloat = 0.266666666666
        let buttonHeight: CGFloat = 0.15
        let sidePadding: CGFloat = 0.24
        
        let titleLabelSize = CGSize(width: 0.2, height: 0.44)// Screen.getScreenSize(x: 0.8, y: 0.3)
        let newTitleSizeOriginal = Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)
        let newTitleSize = CGSize(width: newTitleSizeOriginal.height, height: newTitleSizeOriginal.width)

        let scoreLabelSize = CGSize(width: 0.6, height: 0.15)// Screen.getScreenSize(x: 0.8, y: 0.3)

        
        let playerInfoLabelSize = CGSize(width: 0.6, height: 0.065)// Screen.getScreenSize(x: 0.8, y: 0.3)

        
        gameOverLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: newTitleSize), text: "Game Over", _outPos: Screen.getScreenPos(x: 1+(titleLabelSize.width), y: Screen.screenSize.height-newTitleSize.height), _inPos: Screen.getScreenPos(x: 0.8, y: 0.285))
        gameOverLabel.changeTextColor(color: .red)
        gameOverLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 8))
        gameOverLabel.adjustsFontSizeToFitWidth = true
        gameOverLabel.textAlignment = .center
        gameOverLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))

        upScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: scoreLabelSize.width, y: scoreLabelSize.height)), text: "\(upScore)", _outPos: Screen.getScreenPos(x: 0.5-(scoreLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.2, y: 0.285))
        upScoreLabel.changeTextColor(color: .white)
        upScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 6))
        upScoreLabel.adjustsFontSizeToFitWidth = true
        upScoreLabel.textAlignment = .center
        upScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        
        upScorePlayerLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: playerInfoLabelSize.width, y: playerInfoLabelSize.height)), text: "Your Score", _outPos: Screen.getScreenPos(x: 0.5-(playerInfoLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.2, y: 0.43))
        upScorePlayerLabel.changeTextColor(color: .white)
        upScorePlayerLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 3))
        upScorePlayerLabel.adjustsFontSizeToFitWidth = true
        upScorePlayerLabel.textAlignment = .center
        upScorePlayerLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))

        
        
        downScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: scoreLabelSize.width, y: scoreLabelSize.height)), text: "\(downScore)", _outPos: Screen.getScreenPos(x: 0.5-(scoreLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.2, y: 0.575))
        downScoreLabel.changeTextColor(color: .white)
        downScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 6))
        downScoreLabel.adjustsFontSizeToFitWidth = true

        downScoreLabel.textAlignment = .center
        
        downScorePlayerLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: playerInfoLabelSize.width, y: playerInfoLabelSize.height)), text: "Your Score", _outPos: Screen.getScreenPos(x: 0.5-(playerInfoLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.2, y: 0.51))
        downScorePlayerLabel.changeTextColor(color: .white)
        downScorePlayerLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 3))
        downScorePlayerLabel.adjustsFontSizeToFitWidth = true
        downScorePlayerLabel.textAlignment = .center
        
        
        homeButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: Screen.getScreenPos(x: sidePadding+(buttonWidth/2), y: buttonsY))
        homeButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .MultiplayerGameOver, to: .MainMenu)
        }
        
        replayButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: Screen.getScreenPos(x: sidePadding+(1*buttonWidth)+buttonWidth/2, y: buttonsY))
        replayButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .MultiplayerGameOver, to: .Multiplayer)
        }
        
        
        horizontalLine = UIView(frame: CGRect(origin: horizontalLineOutPos, size: Screen.getScreenSize(x: 0.6, y: 0.01)))
        horizontalLine.backgroundColor = UIColor.white
        //horizontalLine.layer.borderWidth = 5
        //horizontalLine.layer.borderColor = UIColor.white.cgColor
        
        super.init(frame: frame)
        
        addSubview(homeButton)
        addSubview(replayButton)
        addSubview(gameOverLabel)
        
        addSubview(upScoreLabel)
        addSubview(downScoreLabel)
        
        addSubview(upScorePlayerLabel)
        addSubview(downScorePlayerLabel)
        
        addSubview(horizontalLine)
    }
    
    func animateInHorizontalLine(time : CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.horizontalLine.center = self.horizontalLineInPos
        })
    }
    
    func animateOutHorizontalLine(time : CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.horizontalLine.center = self.horizontalLineOutPos
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        
        upScoreLabel.text = "\(upScore)"
        downScoreLabel.text = "\(downScore)"
        
        upScoreLabel.changeTextColor(color: GameController.sharedInstance.multiplayer.upSide.staticShape.col)
        downScoreLabel.changeTextColor(color: GameController.sharedInstance.multiplayer.downSide.staticShape.col)
        downScorePlayerLabel.changeTextColor(color: GameController.sharedInstance.multiplayer.downSide.staticShape.col)
        upScorePlayerLabel.changeTextColor(color: GameController.sharedInstance.multiplayer.upSide.staticShape.col)
        
        if(upScore == downScore){
            horizontalLine.backgroundColor = UIColor.white
        }else{
            horizontalLine.backgroundColor = upScore > downScore ? GameController.sharedInstance.multiplayer.upSide.staticShape.col : GameController.sharedInstance.multiplayer.downSide.staticShape.col
        }
        
        homeButton.animateIn(time: transitionTime)
        replayButton.animateIn(time: transitionTime)
        gameOverLabel.animateIn(time: transitionTime)
        
        upScoreLabel.animateIn(time: transitionTime)
        downScoreLabel.animateIn(time: transitionTime)

        upScorePlayerLabel.animateIn(time: transitionTime)
        downScorePlayerLabel.animateIn(time: transitionTime)
        
        animateInHorizontalLine(time: transitionTime)
    }
    
    func animateOut(){
        homeButton.animateOut(time: transitionTime)
        replayButton.animateOut(time: transitionTime)
        gameOverLabel.animateOut(time: transitionTime)
        upScoreLabel.animateOut(time: transitionTime)
        downScoreLabel.animateOut(time: transitionTime)
        
        upScorePlayerLabel.animateOut(time: transitionTime)
        downScorePlayerLabel.animateOut(time: transitionTime)
        
        animateOutHorizontalLine(time: transitionTime)
    }
}
