//
//  Gameplay.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 1/21/17.
//  Copyright © 2017 Satvik Borra. All rights reserved.
//

import UIKit

class Gameplay {
    
    static let transitionTime: CGFloat = 0.5
    
    // CompareWidth variables: Change only the x value to decide how easy it should be to match a shape, a lower value means a small margin of error between the shapes making it harder. A higher value means the shapes can be more different making it easier.
    
    //single player
    static let spTimerTime: CGFloat = 3.5
    static let spMinTime: CGFloat = 2
    static let spReduceTime: CGFloat = 0.01
    static let spCompareWidth: CGFloat = Screen.getScreenSize(x: 0.06, y: 0).width
    
    //multi player
    static let mpTimerTime: CGFloat = 3.5
    static let mpMinTime: CGFloat = 2
    static let mpReduceTime: CGFloat = 0.01
    static let mpCompareWidth: CGFloat = Screen.getScreenSize(x: 0.06, y: 0).width

}
