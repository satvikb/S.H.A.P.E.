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
        
        self.view.backgroundColor = UIColor(red: 0.168627451, green: 0.168627451, blue: 0.168627451, alpha: 1)
        GameController.sharedInstance.viewController = self
 
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
}
