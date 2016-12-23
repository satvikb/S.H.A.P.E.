//
//  MultiplayerScreenSide.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

public enum ScreenSide {
    case up
    case down
}



class MultiplayerScreenSide{

    var playerId : Int = 0
    var screenSide : ScreenSide
    var timer : SquareTimer = SquareTimer.null
    
    var score : Int = 0;
    var timerTime : CGFloat = 40;
    
    var movingShape : MovingShape!
    var staticShape : StaticShape!
    var scoreLabel : Label!;
    
    static let posXMinMax : Range = Range(min: 0.3, max: 0.8)
    static let posYMinMaxUp : Range = Range(min: 0.15, max: 0.35)
    static let posYMinMaxDown : Range = Range(min: 0.65, max: 0.85)
    
    static let sizeMinMax : Range = Range(min: 0.05, max: 0.225)
    static let scaleMinMax : Range = Range(min: 0.8, max: 1.3)

    
    static func getPosYFromSide(side : ScreenSide) -> Range{
        return side == .up ? posYMinMaxUp : posYMinMaxDown
    }
    
    init(_playerId : Int, _screenSide : ScreenSide){
        playerId = _playerId
        screenSide = _screenSide
    }

}
