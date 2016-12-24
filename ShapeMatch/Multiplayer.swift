//
//  Multiplayer.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class Multiplayer : UIView{
    
    let transitionTime : CGFloat = 0.5
    
    var upSide : MultiplayerScreenSide!
    var downSide : MultiplayerScreenSide!
    
    var isGameOver : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        upSide = MultiplayerScreenSide(_playerId: 0, _screenSide: .up)
        downSide = MultiplayerScreenSide(_playerId: 0, _screenSide: .down)

        
        let upSideTimerSize : CGSize = Screen.getScreenSize(x: 1, y: 0.5)
        upSide.timer = SquareTimer(frame: CGRect(origin: Screen.getScreenPos(x: 0, y: 0), size: upSideTimerSize), lineWidth: 6)
        upSide.timer.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))

        upSide.timer.done = {
            self.GameOver(side: self.upSide)
        }
        
        let staticShapePosUp = Screen.getScreenPos(x: -1, y: -1)
        let staticShapeSizeUp = CGSize(width: 0, height: 0)
        
        upSide.staticShape = StaticShape(position: staticShapePosUp, size: staticShapeSizeUp)
        
        let movingShapePosUp = Screen.getScreenPos(x: -1, y: -1)
        let movingShapeSizeUp = Screen.getActualSize(0, height: 0)
        let movingShapeGestureSizeUp = Screen.getActualSize(1, height: 0.5)
        
        upSide.movingShape = MovingShape(position: movingShapePosUp, size: movingShapeSizeUp, gestureViewSize: movingShapeGestureSizeUp)
        upSide.movingShape.setupGestureRecognizers()
        upSide.movingShape.anyGestureHappened = {
            if(self.isGameOver == false){
                if(self.similarToStaticShape(side: self.upSide)){
                    self.increaseDifficulty(side: self.upSide)
                    Sounds.PlayMatchedSound()
                    self.newShapePositions(side: self.upSide)
                    self.upSide.timer.reset(time: self.upSide.timerTime)
                    self.upSide.score += 1
                    self.upSide.scoreLabel.text = "\(self.upSide.score)"
                }
            }
        }
        
        let labelSizeUp = Screen.getActualSize(1, height: 0.2)
        
        let halfYPos : CGPoint = Screen.getScreenPos(x: 0, y: 0.5)
        let upSideInPos : CGPoint = CGPoint(x: 0, y: halfYPos.y - labelSizeUp.height)
        upSide.scoreLabel = Label(frame: CGRect(origin: CGPoint.zero, size: labelSizeUp), text: "\(upSide.score)", _outPos: Screen.getScreenPos(x: 0, y: -0.2), _inPos: upSideInPos)
        upSide.scoreLabel.textAlignment = .center
        upSide.scoreLabel.font = UIFont(name: "HiraginoSans-W3", size: Screen.fontSize(fontSize: 10))
        upSide.scoreLabel.textColor = UIColor.white
        upSide.scoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))

        
        self.addSubview(upSide.timer)
        self.addSubview(upSide.movingShape)
        self.addSubview(upSide.staticShape)
        self.addSubview(upSide.scoreLabel)
        self.addSubview(upSide.movingShape.gestureView)
        
        
        
        
        let downSideTimerSize : CGSize = Screen.getScreenSize(x: 1, y: 0.5)
        downSide.timer = SquareTimer(frame: CGRect(origin: Screen.getScreenPos(x: 0, y: 0.5), size: downSideTimerSize), lineWidth: 6)
        
        downSide.timer.done = {
            self.GameOver(side: self.upSide)
        }
        
        let staticShapePosDown = Screen.getScreenPos(x: -1, y: -1)
        let staticShapeSizeDown = CGSize(width: 0, height: 0)
        
        downSide.staticShape = StaticShape(position: staticShapePosDown, size: staticShapeSizeDown)
        
        let movingShapePosDown = Screen.getScreenPos(x: -1, y: -1)
        let movingShapeSizeDown = Screen.getActualSize(0, height: 0)
        let movingShapeGestureSizeDown = Screen.getActualSize(1, height: 0.5)
        
        downSide.movingShape = MovingShape(position: movingShapePosDown, size: movingShapeSizeDown, gestureViewSize: movingShapeGestureSizeDown, gestureViewPos: Screen.getScreenPos(x: 0, y: 0.5))
        downSide.movingShape.setupGestureRecognizers()
        downSide.movingShape.anyGestureHappened = {
            if(self.isGameOver == false){
                if(self.similarToStaticShape(side: self.downSide)){
                    self.increaseDifficulty(side: self.downSide)
                    Sounds.PlayMatchedSound()
                    self.newShapePositions(side: self.downSide)
                    self.downSide.timer.reset(time: self.downSide.timerTime)
                    self.downSide.score += 1
                    self.downSide.scoreLabel.text = "\(self.downSide.score)"
                }
            }
        }
        
        let labelSizeDown = Screen.getActualSize(1, height: 0.2)
        
        downSide.scoreLabel = Label(frame: CGRect(origin: CGPoint.zero, size: labelSizeDown), text: "\(downSide.score)", _outPos: Screen.getScreenPos(x: 0, y: -0.2), _inPos: Screen.getScreenPos(x: 0, y: 0.5))
        downSide.scoreLabel.textAlignment = .center
        downSide.scoreLabel.font = UIFont(name: "HiraginoSans-W3", size: Screen.fontSize(fontSize: 10))
        downSide.scoreLabel.textColor = UIColor.white
        
        
        self.addSubview(downSide.timer)
        self.addSubview(downSide.movingShape)
        self.addSubview(downSide.staticShape)
        self.addSubview(downSide.scoreLabel)
        self.addSubview(downSide.movingShape.gestureView)
        
    }
    
    func increaseDifficulty(side : MultiplayerScreenSide){
        side.timerTime -= 0.01
        
        if(side.timerTime < 1.75){
            side.timerTime = 1.75
        }
        
    }
    
    func newShapePositions(side : MultiplayerScreenSide, changeMovingShapePos : Bool = false){
        var staticShapeNewSize = Screen.getActualSize(Functions.randomFloat(MultiplayerScreenSide.sizeMinMax.Min, maximum: MultiplayerScreenSide.sizeMinMax.Max), height: Functions.randomFloat(MultiplayerScreenSide.sizeMinMax.Min, maximum: MultiplayerScreenSide.sizeMinMax.Max))
        
        if(staticShapeNewSize.width > Screen.screenSize.width/2 || staticShapeNewSize.height > Screen.screenSize.height/4){
            staticShapeNewSize = CGSize(width: Screen.screenSize.width/4.01, height: Screen.screenSize.height/4.01)
        }
        
        let staticShapeNewPos = Screen.getScreenPos(x: Functions.randomFloat(MultiplayerScreenSide.posXMinMax.Min, maximum: MultiplayerScreenSide.posXMinMax.Max), y: Functions.randomFloat(MultiplayerScreenSide.getPosYFromSide(side: side.screenSide).Min, maximum: MultiplayerScreenSide.getPosYFromSide(side: side.screenSide).Max))
        
        side.staticShape.transform = CGAffineTransform.identity
        side.staticShape.startSize = staticShapeNewSize
        side.staticShape.bounds = CGRect(origin: CGPoint.zero, size: staticShapeNewSize)
        
        side.staticShape.center = staticShapeNewPos
        side.staticShape.setRotation(Functions.randomRadian())
        side.staticShape.setColor(Functions.randomColor())
        
        let randomScale = Functions.randomFloat(MultiplayerScreenSide.scaleMinMax.Min, maximum: MultiplayerScreenSide.scaleMinMax.Max)
        
        let movingShapeNewSize = CGSize(width: staticShapeNewSize.width*randomScale, height: staticShapeNewSize.height*randomScale)
        
        side.movingShape.transform = CGAffineTransform.identity
        side.movingShape.startSize = movingShapeNewSize
        side.movingShape.bounds = CGRect(x: 0, y: 0, width: movingShapeNewSize.width, height: movingShapeNewSize.height)
        
        
        if(changeMovingShapePos){
            let movingShapeNewPos = Screen.getScreenPos(x: Functions.randomFloat(MultiplayerScreenSide.posXMinMax.Min, maximum: MultiplayerScreenSide.posXMinMax.Max), y: Functions.randomFloat(MultiplayerScreenSide.getPosYFromSide(side: side.screenSide).Min, maximum: MultiplayerScreenSide.getPosYFromSide(side: side.screenSide).Max))
            side.movingShape.center = movingShapeNewPos
        }
        
        side.movingShape.setColor((side.staticShape.col.GetDarkerColor(1.05)))
        
        side.timer.changeColor(col: side.staticShape.col)
        side.scoreLabel.changeTextColor(color: side.staticShape.col)
    }
    
    func similarToStaticShape(side : MultiplayerScreenSide) -> Bool{
        return framesClose(side: side)
    }
    
    func framesClose(side : MultiplayerScreenSide) -> Bool{
        
        let movingSize = side.movingShape.frame.size//__CGSizeApplyAffineTransform(movingShape.startSize, movingShape.transform)
        let staticSize = side.staticShape.frame.size//__CGSizeApplyAffineTransform(staticShape.startSize, staticShape.transform)
        
        let movingCenter = side.movingShape.center
        let staticCenter = side.staticShape.center
        
        let movingFrame = CGRect(origin: movingCenter, size: movingSize)
        let staticFrame = CGRect(origin: staticCenter, size: staticSize)
        
        let deltaRect = subRect(movingRect: movingFrame, staticRect: staticFrame)
        
        let width = Screen.getScreenSize(x: 0.05, y: 0).width
        let minimumDiffRect = CGRect(x: width, y: width, width: width, height: width)
        
        let isSame = rectLessThan(rect1: deltaRect, rect2: minimumDiffRect)
        
        return isSame
    }
    
    func rectLessThan(rect1 : CGRect, rect2 : CGRect) -> Bool{
        // rect1 < rect2
        if((rect1.origin.x < rect2.origin.x) && (rect1.origin.y < rect2.origin.y) && (rect1.size.width < rect2.size.width) && (rect1.size.height < rect2.size.height)){
            return true
        }
        return false
    }
    
    func subRect(movingRect : CGRect, staticRect : CGRect) -> CGRect{
        let deltaRect = CGRect(x: abs(movingRect.origin.x - staticRect.origin.x), y: abs(movingRect.origin.y - staticRect.origin.y), width: abs(movingRect.size.width - staticRect.size.width), height: abs(movingRect.size.height - staticRect.size.height))
        
        return deltaRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func GameOver(side : MultiplayerScreenSide){
        Sounds.PlayGameOverSound()
        isGameOver = true;
        
        GameController.sharedInstance.multiplayerGameOver.upScore = upSide.score
        GameController.sharedInstance.multiplayerGameOver.downScore = downSide.score

        GameController.sharedInstance.switchFromTo(from: .Multiplayer, to: .MultiplayerGameOver)
    }
    
    func animateIn(){
        isGameOver = false

        newShapePositions(side: upSide, changeMovingShapePos: true)
        newShapePositions(side: downSide, changeMovingShapePos: true)

        upSide.score = 0
        upSide.scoreLabel.text = "\(upSide.score)"
        upSide.scoreLabel.animateIn(time: transitionTime)
        upSide.timer.animateIn(time: transitionTime)
        upSide.timer.start(time: upSide.timerTime)
        self.bringSubview(toFront: upSide.movingShape.gestureView)
        
        downSide.score = 0
        downSide.scoreLabel.text = "\(downSide.score)"
        downSide.scoreLabel.animateIn(time: transitionTime)
        downSide.timer.animateIn(time: transitionTime)
        downSide.timer.start(time: downSide.timerTime)
        self.bringSubview(toFront: downSide.movingShape.gestureView)
        
        
    }
    
    func animateOut(){
        upSide.timer.animateOut(time: transitionTime)
        upSide.timer.removeTimer()
        upSide.scoreLabel.animateOut(time: transitionTime)
        upSide.movingShape.animateOut(time: transitionTime)
        upSide.staticShape.animateOut(time: transitionTime)
        
        downSide.timer.animateOut(time: transitionTime)
        downSide.timer.removeTimer()
        downSide.scoreLabel.animateOut(time: transitionTime)
        downSide.movingShape.animateOut(time: transitionTime)
        downSide.staticShape.animateOut(time: transitionTime)
        
        
    }
}
