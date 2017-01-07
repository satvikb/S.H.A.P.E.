//
//  MultiplayerGameOver.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK

class MultiplayerGameOver: UIView{
    
    let transitionTime: CGFloat = 0.5
    
    var homeButton: Square = Square.null
    var replayButton: Square = Square.null
    
    var gameOverLabel: Label!
    
    var upScoreLabel: Label!
    var upScorePlayerLabel: Label!

    var downScoreLabel: Label!
    var downScorePlayerLabel: Label!

    var horizontalLine: UIView!
    var horizontalLineOutPos: CGPoint = Screen.getScreenPos(x: -0.6, y: 0.5)
    var horizontalLineInPos: CGPoint = Screen.getScreenPos(x: 0.5, y: 0.5)

    var upScore: Int = 0
    var downScore: Int = 0
    
    override init(frame: CGRect) {
        let buttonsY: CGFloat = 0.85
        let buttonWidth: CGFloat = 0.3//0.266666666666
        let buttonHeight: CGFloat = 0.1
        
        let titleLabelSize = CGSize(width: 0.2, height: 0.44)// Screen.getScreenSize(x: 0.8, y: 0.3)
        let newTitleSizeOriginal = Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)
        let newTitleSize = CGSize(width: newTitleSizeOriginal.height, height: newTitleSizeOriginal.width)

        let scoreLabelSize = CGSize(width: 0.6, height: 0.15)// Screen.getScreenSize(x: 0.8, y: 0.3)

        
        let playerInfoLabelSize = CGSize(width: 0.6, height: 0.065)// Screen.getScreenSize(x: 0.8, y: 0.3)

        let gameOverOutPos : CGPoint = CGPoint(x: Screen.screenSize.width+newTitleSize.width, y: Screen.getScreenPos(x: 0.8, y: 0.285).y)
        gameOverLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: newTitleSize), text: "Game Over", _outPos: gameOverOutPos, _inPos: Screen.getScreenPos(x: 0.8, y: 0.285))
        gameOverLabel.changeTextColor(color: .red)
        gameOverLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 8))
        gameOverLabel.adjustsFontSizeToFitWidth = true
        gameOverLabel.textAlignment = .center
        gameOverLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))

        upScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: scoreLabelSize.width, y: scoreLabelSize.height)), text: "\(upScore)", _outPos: Screen.getScreenPos(x: -(scoreLabelSize.width), y: 0.285), _inPos: Screen.getScreenPos(x: 0.2, y: 0.285))
        upScoreLabel.changeTextColor(color: .white)
        upScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 6))
        upScoreLabel.adjustsFontSizeToFitWidth = true
        upScoreLabel.textAlignment = .center
        upScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        upScorePlayerLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: playerInfoLabelSize.width, y: playerInfoLabelSize.height)), text: "Your Score", _outPos: Screen.getScreenPos(x: -(playerInfoLabelSize.width), y: 0.43), _inPos: Screen.getScreenPos(x: 0.2, y: 0.43))
        upScorePlayerLabel.changeTextColor(color: .white)
        upScorePlayerLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 3))
        upScorePlayerLabel.adjustsFontSizeToFitWidth = true
        upScorePlayerLabel.textAlignment = .center
        upScorePlayerLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        downScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: scoreLabelSize.width, y: scoreLabelSize.height)), text: "\(downScore)", _outPos: Screen.getScreenPos(x: -(scoreLabelSize.width), y: 0.575), _inPos: Screen.getScreenPos(x: 0.2, y: 0.575))
        downScoreLabel.changeTextColor(color: .white)
        downScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 6))
        downScoreLabel.adjustsFontSizeToFitWidth = true
        downScoreLabel.textAlignment = .center
        
        downScorePlayerLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: playerInfoLabelSize.width, y: playerInfoLabelSize.height)), text: "Your Score", _outPos: Screen.getScreenPos(x: -(playerInfoLabelSize.width), y: 0.51), _inPos: Screen.getScreenPos(x: 0.2, y: 0.51))
        downScorePlayerLabel.changeTextColor(color: .white)
        downScorePlayerLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 3))
        downScorePlayerLabel.adjustsFontSizeToFitWidth = true
        downScorePlayerLabel.textAlignment = .center
        
        super.init(frame: frame)

        let centerY : CGFloat = 0.50
        let buttonSize : CGSize = Screen.getScreenSize(x: buttonWidth, y: buttonHeight)
        let buttonPropWidth = buttonSize.height/Screen.screenSize.width
        let sidePadding: CGFloat = ((0.25-buttonPropWidth)/2)+buttonPropWidth/2//((0.25-buttonPropWidth/2)/2)

        
        var homeButtonInPos : CGPoint = Screen.getScreenPos(x: sidePadding, y: centerY)
        homeButtonInPos.y -= buttonSize.width/2
        
        homeButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: UIColor.belizeHoleColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: homeButtonInPos)
        homeButton.imageView.image = #imageLiteral(resourceName: "homeicon.png")
        homeButton.tap = {
            Flurry.logEvent("HomeTappedMultiplayer", withParameters: ["ScoreUp":self.upScore, "ScoreDown":self.downScore])
            GameController.sharedInstance.switchFromTo(from: .MultiplayerGameOver, to: .MainMenu)
        }
        homeButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
        
        var replayButtonInPos : CGPoint = Screen.getScreenPos(x: sidePadding, y: centerY)
        replayButtonInPos.y += buttonSize.width/2
        
        replayButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: UIColor.nephritisColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: replayButtonInPos)
        replayButton.imageView.image = #imageLiteral(resourceName: "restart.png")
        replayButton.tap = {
            Flurry.logEvent("ReplayTappedMultiplayer", withParameters: ["ScoreUp":self.upScore, "ScoreDown":self.downScore])
            GameController.sharedInstance.switchFromTo(from: .MultiplayerGameOver, to: .Multiplayer)
        }
        replayButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2))
        
        horizontalLine = UIView(frame: CGRect(origin: horizontalLineOutPos, size: Screen.getScreenSize(x: 0.5, y: 0.01)))
        horizontalLine.backgroundColor = UIColor.white
        
        addSubview(homeButton)
        addSubview(replayButton)
        addSubview(gameOverLabel)
        
        addSubview(upScoreLabel)
        addSubview(downScoreLabel)
        
        addSubview(upScorePlayerLabel)
        addSubview(downScorePlayerLabel)
        
        addSubview(horizontalLine)
    }
    
    func animateInHorizontalLine(time: CGFloat){
        UIView.animate(withDuration: TimeInterval(time), animations: {
            self.horizontalLine.center = self.horizontalLineInPos
        })
    }
    
    func animateOutHorizontalLine(time: CGFloat){
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
            horizontalLine.backgroundColor = upScore > downScore ? GameController.sharedInstance.multiplayer.upSide.staticShape.col: GameController.sharedInstance.multiplayer.downSide.staticShape.col
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
