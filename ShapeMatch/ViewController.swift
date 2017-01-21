//
//  ViewController.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 5/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.defaultCenter().addObserver(self, selector: Selector("myObserverMethod:"), name:UIApplicationDidEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)

        self.view.backgroundColor = UIColor(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        GameController.sharedInstance.viewController = self
 
        if(GameController.sharedInstance.deviceModel == .iPad){
            print("is a ipad")
            self.view.addSubview(GameController.sharedInstance.multiplayer)
            self.view.addSubview(GameController.sharedInstance.multiplayerGameOver)
        }
        
        self.view.addSubview(GameController.sharedInstance.settings)
        self.view.addSubview(GameController.sharedInstance.gameOver)
        self.view.addSubview(GameController.sharedInstance.game)
        self.view.addSubview(GameController.sharedInstance.mainMenu)
        
        
        
        GameController.sharedInstance.switchFromTo(from: .Start, to: .MainMenu)
        
        ScoreManager.authenticateGameCenterPlayer(currVC: self)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didEnterBackground() {
        print("Background")
        
        if(GameController.sharedInstance.currentView == .Game){
            GameController.sharedInstance.game.timer.pause()
        }
        
        if(GameController.sharedInstance.currentView == .Multiplayer){
            GameController.sharedInstance.multiplayer.upSide.timer.pause()
            GameController.sharedInstance.multiplayer.downSide.timer.pause()
        }
    }
    
    func didEnterForeground(){
        print("Foreground")
        
//        if(GameController.sharedInstance.currentView == .Game){
//            GameController.sharedInstance.game.timer.resume()
//        }
//        
//        if(GameController.sharedInstance.currentView == .Multiplayer){
//            GameController.sharedInstance.multiplayer.upSide.timer.resume()
//            GameController.sharedInstance.multiplayer.downSide.timer.resume()
//        }
    }
}
