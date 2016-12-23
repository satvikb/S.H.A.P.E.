//
//  GameController.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/20/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

public enum Views{
    case Start
    case MainMenu
    case Game
    case GameOver
    case Settings
}

class GameController{
    
    static let sharedInstance = GameController()
    
    var viewController: ViewController!
    
    var mainMenu: MainMenu!
    var game: Game!
    var gameOver: GameOver!
    
    func Setup(){
        mainMenu = MainMenu(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        game = Game(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        gameOver = GameOver(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
    }
    
    func switchFromTo(from: Views, to: Views){
        switch from {
            case .MainMenu:
                mainMenu.animateOut()
                break
            case .Game:
                game.animateOut()
                break
            case .GameOver:
                gameOver.animateOut()
                break
            case .Settings:
                break
            default:
                break
        }
        
        switch to {
            case .MainMenu:
                mainMenu.animateIn()
                viewController.view.bringSubview(toFront: mainMenu)
                break
            case .Game:
                game.animateIn()
                viewController.view.bringSubview(toFront: game)
                break
            case .GameOver:
                gameOver.animateIn()
                viewController.view.bringSubview(toFront: gameOver)
                break
            case .Settings:
                break
            default:
                break
            }
        }
}
