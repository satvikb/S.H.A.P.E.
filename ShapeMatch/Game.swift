//
//  Game.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit
import Flurry_iOS_SDK

class Game: UIView{
    
//    let transitionTime: CGFloat = 0.5
    
    var timer: SquareTimer = SquareTimer.null
    
    var score: Int = 0
    var timerTime: CGFloat = 2.5
    
    var movingShape: MovingShape!
    var staticShape: StaticShape!
    var scoreLabel: Label!
    
    let posXMinMax: Range = Range(min: 0.3, max: 0.7)
    let posYMinMax: Range = Range(min: 0.3, max: 0.7)
    
    let sizeMinMax: Range = Range(min: 0.1, max: 0.38)
    
    let scaleMinMax: Range = Range(min: 0.9, max: 1.3)
    
    var isGameOver: Bool = false
    
//    var tutorialView : View!
    var tutorialLabel: Label!
    var howToPlayLabel: Label!

    var fingerImage : UIImageView!
    
    var tutorialEnabled: Bool = true
    private var tutorialFinished: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        tutorialView = View(frame: frame, _outPos: Screen.getScreenPos(x: -1, y: 0), _inPos: Screen.getScreenPos(x: 0, y: 0))
//        tutorialView.backgroundColor = UIColor.black
//        tutorialView.layer.opacity = 0.5
        tutorialLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0, y: 0.05), size: Screen.getScreenSize(x: 0.8, y: 0.1)), text: "Match the shape.", _outPos: Screen.getScreenPos(x: -1, y: 0.5), _inPos: Screen.getScreenPos(x: 0.025, y: 0.8), textColor: UIColor.white, debugFrame: false, _neon: true)
        tutorialLabel.textAlignment = .left
        tutorialLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2.5))
        
        howToPlayLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0, y: 0.05), size: Screen.getScreenSize(x: 0.5, y: 0.1)), text: "Use two fingers.", _outPos: Screen.getScreenPos(x: -1, y: 0.5), _inPos: Screen.getScreenPos(x: 0.025, y: 0.9), textColor: UIColor.white, debugFrame: false, _neon: true)
        howToPlayLabel.textAlignment = .left
        howToPlayLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2))
        
        let imageWidth = Screen.getScreenSize(x: 0.2, y: 0).width
        fingerImage = UIImageView(frame: CGRect(origin: CGPoint.outOfScreen, size: CGSize(width: imageWidth, height: imageWidth)))
        fingerImage.image = #imageLiteral(resourceName: "finger.png")
        
        let timerWidth = Screen.getScreenSize(x: 0.016, y: 0).width
        
        timer = SquareTimer(frame: CGRect(origin: Screen.getScreenPos(x: 0, y: 0), size: Screen.screenSize.size), lineWidth: timerWidth)
        
        timer.done = {
            self.GameOver()
        }
                
        let staticMovingPos = Screen.getScreenPos(x: -1, y: -1)
        let staticMovingSize = CGSize(width: 0, height: 0)
        
        staticShape = StaticShape(position: staticMovingPos, size: staticMovingSize)
       
        let movingShapePos = Screen.getScreenPos(x: -1, y: -1)
        let movingShapeSize = Screen.getActualSize(0, height: 0)
        
        movingShape = MovingShape(position: movingShapePos, size: movingShapeSize)
        movingShape.setupGestureRecognizers()
        movingShape.anyGestureHappened = {
            if(self.isGameOver == false){
                //Restrict moving shape size here?
                
                if(self.similarToStaticShape()){
                    
                    if(self.tutorialEnabled == true && self.tutorialFinished == false){
                        Sounds.PlayMatchedSound()
                        self.newShapePositions()
                        self.animateOutTutorialLabel()
                        self.timer.start(time: self.timerTime)
//                        self.timer.reset(time: self.timerTime)
//                        self.timer.resume()
                        self.tutorialFinished = true
                    }else{
                        self.increaseDifficulty()
                        Sounds.PlayMatchedSound()
                        self.newShapePositions()
                        self.timer.reset(time: self.timerTime)
                        self.score += 1
                        self.scoreLabel.text = "\(self.score)"
                    }
                }
            }
        }
        
        let labelSize = Screen.getActualSize(1, height: 0.2)
        
        scoreLabel = Label(frame: CGRect(origin: CGPoint.zero, size: labelSize), text: "\(score)", _outPos: Screen.getScreenPos(x: 0, y: -0.2), _inPos: Screen.getScreenPos(x: 0, y: 0))
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "HiraginoSans-W3", size: Screen.fontSize(fontSize: 10))
        scoreLabel.textColor = UIColor.white
        
        self.addSubview(timer)
        self.addSubview(movingShape)
        self.addSubview(staticShape)
        self.addSubview(scoreLabel)
        self.addSubview(movingShape.gestureView)
//        self.addSubview(tutorialView)
        self.addSubview(tutorialLabel)
        self.addSubview(howToPlayLabel)
        self.addSubview(fingerImage)
    }
    
    func increaseDifficulty(){

        timerTime -= Gameplay.spReduceTime
        
        if(timerTime < Gameplay.spMinTime){
            timerTime = Gameplay.spMinTime
        }
        
    }
    
    func newShapePositions(changeMovingShapePos: Bool = false){
        var staticShapeNewSize = Screen.getActualSize(Functions.randomFloat(sizeMinMax.Min, maximum: sizeMinMax.Max), height: Functions.randomFloat(sizeMinMax.Min, maximum: sizeMinMax.Max))
        
        if(staticShapeNewSize.width > Screen.screenSize.width/2 || staticShapeNewSize.height > Screen.screenSize.height/2){
            staticShapeNewSize = CGSize(width: Screen.screenSize.width/2.01, height: Screen.screenSize.height/2.01)
        }
        
        let staticShapeNewPos = Screen.getScreenPos(x: Functions.randomFloat(posXMinMax.Min, maximum: posXMinMax.Max), y: Functions.randomFloat(posYMinMax.Min, maximum: posYMinMax.Max))
        
        staticShape.transform = CGAffineTransform.identity
        staticShape.startSize = staticShapeNewSize
        staticShape.bounds = CGRect(origin: CGPoint.zero, size: staticShapeNewSize)
        
        staticShape.center = staticShapeNewPos
        staticShape.setRotation(Functions.randomRadian())
        staticShape.setColor(Functions.randomColor())
        
        let randomScale = Functions.randomFloat(scaleMinMax.Min, maximum: scaleMinMax.Max)
        
        let movingShapeNewSize = CGSize(width: staticShapeNewSize.width*randomScale, height: staticShapeNewSize.height*randomScale)
        
        print("Scale1: \(self.transform.a) \(self.transform.d) \(self.frame.size)")

        movingShape.transform = CGAffineTransform.identity
        movingShape.currentScale = 1
        movingShape.startSize = movingShapeNewSize
        movingShape.bounds = CGRect(x: 0, y: 0, width: movingShapeNewSize.width, height: movingShapeNewSize.height)
        print("Scale2: \(self.transform.a) \(self.transform.d) \(self.frame.size)")

        
        if(changeMovingShapePos){
            let movingShapeNewPos = Screen.getScreenPos(x: Functions.randomFloat(posXMinMax.Min, maximum: posXMinMax.Max), y: Functions.randomFloat(posYMinMax.Min, maximum: posYMinMax.Max))
            movingShape.center = movingShapeNewPos
        }
        
        movingShape.setColor((staticShape.col.GetDarkerColor(1.05)))
        timer.changeColor(col: staticShape.col)
        movingShape.calculateMaxScale()
    }
    
//    func restrictMovingShapeSize(){
//        
//    }
    
    
    func similarToStaticShape() -> Bool{
        return framesClose()
    }
    
    func framesClose() -> Bool{
        
        let movingSize = movingShape.frame.size//__CGSizeApplyAffineTransform(movingShape.startSize, movingShape.transform)
        let staticSize = staticShape.frame.size//__CGSizeApplyAffineTransform(staticShape.startSize, staticShape.transform)

        let movingCenter = movingShape.center
        let staticCenter = staticShape.center
        
        let movingFrame = CGRect(origin: movingCenter, size: movingSize)
        let staticFrame = CGRect(origin: staticCenter, size: staticSize)

        let deltaRect = subRect(movingRect: movingFrame, staticRect: staticFrame)
    
        let width = Gameplay.spCompareWidth
        let minimumDiffRect = CGRect(x: width, y: width, width: width, height: width)
        
        let isSame = rectLessThan(rect1: deltaRect, rect2: minimumDiffRect)
        
        return isSame
    }
    
    func rectLessThan(rect1: CGRect, rect2: CGRect) -> Bool{
        // rect1 < rect2
        if((rect1.origin.x < rect2.origin.x) && (rect1.origin.y < rect2.origin.y) && (rect1.size.width < rect2.size.width) && (rect1.size.height < rect2.size.height)){
            return true
        }
        return false
    }
    
    func subRect(movingRect: CGRect, staticRect: CGRect) -> CGRect{
        let deltaRect = CGRect(x: abs(movingRect.origin.x - staticRect.origin.x), y: abs(movingRect.origin.y - staticRect.origin.y), width: abs(movingRect.size.width - staticRect.size.width), height: abs(movingRect.size.height - staticRect.size.height))
        
        return deltaRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func GameOver(){
        Sounds.PlayGameOverSound()
        isGameOver = true
        GameController.sharedInstance.gameOver.score = score
        
        GameController.sharedInstance.switchFromTo(from: .Game, to: .GameOver)
    }
    
    func animateIn(){
        Flurry.logEvent("Game", withParameters: nil, timed: true)
        
        score = 0
        scoreLabel.text = "\(score)"
        isGameOver = false
        scoreLabel.animateIn(time: Gameplay.transitionTime)
        newShapePositions(changeMovingShapePos: true)
        timer.animateIn(time: Gameplay.transitionTime)

        if(tutorialEnabled == false){
            timer.start(time: timerTime)
        }
        
        self.bringSubview(toFront: movingShape.gestureView)
        
        if(tutorialEnabled == true){
            print("tutorial")
            tutorialFinished = false
//            timer.pause() //For tutorial
            
            tutorialLabel.animateIn(time: Gameplay.transitionTime)
            howToPlayLabel.animateIn(time: Gameplay.transitionTime)
            UIView.animate(withDuration: TimeInterval(Gameplay.transitionTime), animations: {
                self.fingerImage.frame.origin = CGPoint(x: Screen.screenSize.width-self.fingerImage.frame.width, y: Screen.screenSize.height-self.fingerImage.frame.height)
            })
        }
    }
    
    func animateOutTutorialLabel(){
        print("animate out tutrial label")
//        UIView.animate(withDuration: TimeInterval(Gameplay.transitionTime), delay: 3, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: .curveLinear, animations: {
//            self.tutorialLabel.frame.origin = self.tutorialLabel.outPos
//        }, completion: {(complete: Bool) in
//            
//        })
        tutorialLabel.animateOut(time: Gameplay.transitionTime)
        howToPlayLabel.animateOut(time: Gameplay.transitionTime)
        
        UIView.animate(withDuration: TimeInterval(Gameplay.transitionTime), animations: {
            self.fingerImage.frame.origin = CGPoint(x: Screen.screenSize.width+self.fingerImage.frame.width, y: Screen.screenSize.height-self.fingerImage.frame.height)
        })
    }
    
    func animateOut(){
        let flurryRectDiff = subRect(movingRect: CGRect(origin: movingShape.center, size: movingShape.frame.size), staticRect: CGRect(origin: staticShape.center, size: staticShape.frame.size))
        let col = staticShape.col
        Flurry.logEvent("Game", withParameters: ["Score": score, "StaticShapeSize": ["width":staticShape.frame.size.width, "height": staticShape.frame.size.height], "RectDiff": ["x":flurryRectDiff.origin.x,"y":flurryRectDiff.origin.y,"width":flurryRectDiff.size.width,"height":flurryRectDiff.size.height], "Color":["r":col?.components.red, "g":col?.components.green, "b":col?.components.blue]], timed: true)

        timer.animateOut(time: Gameplay.transitionTime)
        timer.removeTimer()
        scoreLabel.animateOut(time: Gameplay.transitionTime)
        movingShape.animateOut(time: Gameplay.transitionTime)
        staticShape.animateOut(time: Gameplay.transitionTime)
    }
}
