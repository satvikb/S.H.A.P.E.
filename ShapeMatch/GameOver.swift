//
//  GameOver.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class GameOver: UIView{
    
    let transitionTime: CGFloat = 0.5
    
    var homeButton: Square
    var replayButton: Square
    var shareButton: Square
    
    var gameOverLabel: Label!
    var highScoreLabel: Label!
    var currentScoreLabel: Label!
    
    var score: Int = 0
    
    override init(frame: CGRect) {
        
        let buttonsY: CGFloat = 0.7
        let buttonWidth: CGFloat = 0.26
        let buttonHeight: CGFloat = 0.15
        let sidePadding: CGFloat = 0.1
        
        let titleLabelSize = CGSize(width: 0.8, height: 0.15)// Screen.getScreenSize(x: 0.8, y: 0.3)
        
        gameOverLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Game Over", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.025))
        gameOverLabel.changeTextColor(color: .red)
        gameOverLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 10))
        gameOverLabel.adjustsFontSizeToFitWidth = true
        gameOverLabel.textAlignment = .center
        
        highScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Highscore: \(ScoreManager.currentHighScore)", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.22))
        highScoreLabel.changeTextColor(color: .orange)
        highScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2.5))
        highScoreLabel.adjustsFontSizeToFitWidth = true
        highScoreLabel.textAlignment = .center
        
        currentScoreLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "\(score)", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.1, y: 0.4))
        currentScoreLabel.changeTextColor(color: .white)
        currentScoreLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 6))
        currentScoreLabel.adjustsFontSizeToFitWidth = true
        currentScoreLabel.textAlignment = .center
        
        homeButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: UIColor.belizeHoleColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: Screen.getScreenPos(x: sidePadding+(buttonWidth/2), y: buttonsY))
        homeButton.imageView.image = #imageLiteral(resourceName: "homeicon.png")
        
        replayButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: UIColor.nephritisColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: Screen.getScreenPos(x: sidePadding+(1*buttonWidth)+buttonWidth/2, y: buttonsY))
        replayButton.imageView.image = #imageLiteral(resourceName: "restart.png")
        
        shareButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: buttonWidth, y: buttonHeight)), color: UIColor.alizarinColor(), _outPos: Screen.getScreenPos(x: -buttonWidth, y: buttonsY), _inPos: Screen.getScreenPos(x: sidePadding+(2*buttonWidth)+buttonWidth/2, y: buttonsY))
        shareButton.imageView.image = #imageLiteral(resourceName: "shareicon.png")
        super.init(frame: frame)

        homeButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .GameOver, to: .MainMenu)
        }
        
        replayButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .GameOver, to: .Game)
        }
        
        shareButton.tap = {
            //TODO: Show share button here
            let pluralword: String = (self.score == 1) ? "match" : "matches"
            let activityVC = UIActivityViewController(activityItems: ["I just scored \(self.score) \(pluralword) on S.H.A.P.E! Can you beat that? http://bit.ly/S_H_A_P_E"], applicationActivities: nil)
            GameController.sharedInstance.viewController.present(activityVC, animated: true, completion: nil)
        }
        
        addSubview(homeButton)
        addSubview(replayButton)
        addSubview(shareButton)
        addSubview(gameOverLabel)
        addSubview(highScoreLabel)
        addSubview(currentScoreLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        
        currentScoreLabel.text = "\(score)"
        
        if ScoreManager.isScoreHighScore(newScore: score) {
            ScoreManager.saveScoreLocally(score: score)
            highScoreLabel.text = "New Highscore!"
        } else {
            highScoreLabel.text = "Highscore: \(ScoreManager.currentHighScore)"
        }
        
        ScoreManager.saveScoreToGameCenter(score: score) //Submit to game center and save
        
        homeButton.animateIn(time: transitionTime)
        replayButton.animateIn(time: transitionTime)
        shareButton.animateIn(time: transitionTime)
        gameOverLabel.animateIn(time: transitionTime)
        currentScoreLabel.animateIn(time: transitionTime)
        highScoreLabel.animateIn(time: transitionTime)
    }
    
    func animateOut(){
        homeButton.animateOut(time: transitionTime)
        replayButton.animateOut(time: transitionTime)
        shareButton.animateOut(time: transitionTime)
        gameOverLabel.animateOut(time: transitionTime)
        currentScoreLabel.animateOut(time: transitionTime)
        highScoreLabel.animateOut(time: transitionTime)
    }
}
