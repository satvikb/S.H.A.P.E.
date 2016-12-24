//
//  MainMenu.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class MainMenu: UIView {
    
    let transitionTime: CGFloat = 0.5
    
    var titleLabel: Label = Label.Null
    var scoreLabel: Label = Label.Null
    
    var settingsButton: Square
    var playButton: Square
    var leaderboardButton: Square
    
    var multiplayerButton: Square = Square.null

    
    override init(frame: CGRect) {
        let buttonsY: CGFloat = 0.7
        let buttonWidth: CGFloat = 0.266666666666
        let buttonHeight: CGFloat = 0.15
        let sidePadding: CGFloat = 0.1
        
        let startOutPos: CGPoint = Screen.getScreenPos(x: 0.5-(buttonWidth/2), y: 1+buttonHeight)
        
        let titleLabelSize = CGSize(width: 0.8, height: 0.3)
        
        titleLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "S.H.A.P.E.", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.1), textColor: UIColor.green)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 10))
        titleLabel.textAlignment = .center
        
        scoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Highscore: \(ScoreManager.currentHighScore)", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.22), textColor: .orange)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2.5))
        scoreLabel.textAlignment = .center
        
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
            ScoreManager.showLeaderboardIn(viewController: GameController.sharedInstance.viewController)
        }
        
        if(GameController.sharedInstance.deviceModel == .iPad){
            print("iPad: \(GameController.sharedInstance.deviceModel == .iPad)")
            multiplayerButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: Functions.randomColor(), _outPos: startOutPos, _inPos: Screen.getScreenPos(x: sidePadding+(1*buttonWidth)+buttonWidth/2, y: buttonsY+buttonHeight))
            multiplayerButton.tap = {
                GameController.sharedInstance.switchFromTo(from: .MainMenu, to: .Multiplayer)
            }
        }
        
        super.init(frame: frame)
        
        self.addSubview(settingsButton)
        self.addSubview(playButton)
        self.addSubview(leaderboardButton)
        self.addSubview(titleLabel)
        self.addSubview(scoreLabel)
        
        if(GameController.sharedInstance.deviceModel == .iPad){
            self.addSubview(multiplayerButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        scoreLabel.text = "Highscore: \(ScoreManager.currentHighScore)"
        
        playButton.animateIn(time: transitionTime)
        settingsButton.animateIn(time: transitionTime)
        leaderboardButton.animateIn(time: transitionTime)
        titleLabel.animateIn(time: transitionTime)
        scoreLabel.animateIn(time: transitionTime)
        
        if(GameController.sharedInstance.deviceModel == .iPad){
            multiplayerButton.animateIn(time: transitionTime)
        }
    }
    
    func animateOut(){
        playButton.animateOut(time: transitionTime)
        settingsButton.animateOut(time: transitionTime)
        leaderboardButton.animateOut(time: transitionTime)
        titleLabel.animateOut(time: transitionTime)
        scoreLabel.animateOut(time: transitionTime)
        
        if(GameController.sharedInstance.deviceModel == .iPad){
            multiplayerButton.animateOut(time: transitionTime)
        }
    }
}
