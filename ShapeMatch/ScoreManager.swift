//
//  ScoreManager.swift
//  ShapeMatch
//
//  Created by Virindh Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit
import GameKit
import Flurry_iOS_SDK

class ScoreManager {
    static var gcEnabled: Bool = false
    static var gcDefaultLeaderBoard = "mainScoreboard"
    
    static func isScoreHighScore(newScore: Int) -> Bool {
        return (newScore > currentHighScore)
    }
    
    static func saveScoreToGameCenter(score: Int) {
        let gcScore = GKScore(leaderboardIdentifier: gcDefaultLeaderBoard)
        gcScore.value = Int64(score)
        
        GKScore.report([gcScore]) { (error) in
            if error != nil {
                print(error.debugDescription)
            } else {
                Flurry.logEvent("GamecenterScoreSubmitted", withParameters: ["Score":gcScore])
                print("Score submitted")
            }
        }
    }
    
    static func saveScoreLocally(score: Int) {
        UserDefaults.standard.set(score, forKey: "hs")
        UserDefaults.standard.synchronize()
    }
    
    static var currentHighScore: Int {
        return UserDefaults.standard.integer(forKey: "hs")
    }
    
    static func authenticateGameCenterPlayer(currVC: UIViewController) {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = { (vc, error) -> Void in
            if vc != nil {
                currVC.present(vc!, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                self.gcEnabled = true
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (boardID, error) in
                    if error != nil {
                        print(error.debugDescription)
                    } else {
                        self.gcDefaultLeaderBoard = boardID!
                    }
                })
            } else {
                self.gcEnabled = false
                Flurry.logEvent("GamecenterDisabled")
                print("No game center enabled")
            }
        }
    }
    
    static func showLeaderboardIn(viewController: ViewController) {
        let leaderboardVC = GKGameCenterViewController()
        leaderboardVC.gameCenterDelegate = viewController
        leaderboardVC.viewState = .leaderboards
        leaderboardVC.leaderboardIdentifier = gcDefaultLeaderBoard
        viewController.present(leaderboardVC, animated: true, completion: nil)
    }
}
