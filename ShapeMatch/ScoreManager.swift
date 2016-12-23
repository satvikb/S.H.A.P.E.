//
//  ScoreManager.swift
//  ShapeMatch
//
//  Created by Virindh Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import Foundation

class ScoreManager {
    static func isScoreHighScore(newScore: Int) -> Bool {
        return (newScore > currentHighScore)
    }
    
    static func saveScoreToGameCenter(score: Int) {
        saveScoreLocally(score: score)
        
        //TODO: Save to game center
    }
    
    static func saveScoreLocally(score: Int) {
        UserDefaults.standard.set(score, forKey: "hs")
        UserDefaults.standard.synchronize()
    }
    
    static var currentHighScore: Int {
        return UserDefaults.standard.integer(forKey: "hs")
    }
    
    
}
