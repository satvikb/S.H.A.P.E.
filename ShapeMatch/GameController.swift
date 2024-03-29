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
    case Multiplayer
    case MultiplayerGameOver
}

public enum DeviceModel{
    case Unknown
    case iPhone
    case iPad
}

class GameController{
    
    static let sharedInstance = GameController()
    
    var viewController: ViewController!
    var deviceModel: DeviceModel = .Unknown
    
    var currentView : Views = .Start
    
    var mainMenu: MainMenu!
    var game: Game!
    var gameOver: GameOver!
    var settings: Settings!
    
    var multiplayer: Multiplayer! = Multiplayer(frame: CGRect.zero)
    var multiplayerGameOver: MultiplayerGameOver! = MultiplayerGameOver(frame: CGRect.zero)
    
    var gamePaused: Bool = false
    
    func Setup(){
        deviceModel = (UIDevice.current.model == "iPad") ? .iPad : .iPhone
        
        mainMenu = MainMenu(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        game = Game(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        gameOver = GameOver(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        
        settings = Settings(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        
        if(deviceModel == .iPad){
            multiplayer = Multiplayer(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
            multiplayerGameOver = MultiplayerGameOver(frame: CGRect(x: 0, y: 0, width: Screen.screenSize.width, height: Screen.screenSize.height))
        }
    }
    
    var switchingViews: Bool = false
    
    func switchFromTo(from: Views, to: Views){
        if(switchingViews == false){
            switchingViews = true
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
                settings.animateOut()
                break
            case .Multiplayer:
                if(GameController.sharedInstance.deviceModel == .iPad){
                    multiplayer.animateOut()
                }
                break
            case .MultiplayerGameOver:
                if(GameController.sharedInstance.deviceModel == .iPad){
                    multiplayerGameOver.animateOut()
                }
                break
            default:
                break
            }
            
            switch to {
            case .MainMenu:
                mainMenu.animateIn()
                currentView = .MainMenu
                viewController.view.bringSubview(toFront: mainMenu)
                break
            case .Game:
                game.animateIn()
                currentView = .Game
                viewController.view.bringSubview(toFront: game)
                break
            case .GameOver:
                gameOver.animateIn()
                currentView = .GameOver
                viewController.view.bringSubview(toFront: gameOver)
                break
            case .Settings:
                settings.animateIn()
                currentView = .Settings
                viewController.view.bringSubview(toFront: settings)
                break
            case .Multiplayer:
                if(GameController.sharedInstance.deviceModel == .iPad){
                    multiplayer.animateIn()
                    currentView = .Multiplayer
                    viewController.view.bringSubview(toFront: multiplayer)
                }
                break
            case .MultiplayerGameOver:
                if(GameController.sharedInstance.deviceModel == .iPad){
                    multiplayerGameOver.animateIn()
                    currentView = .MultiplayerGameOver
                    viewController.view.bringSubview(toFront: multiplayerGameOver)
                }
                break
            default:
                break
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(Gameplay.transitionTime*1000)), execute: {
                self.switchingViews = false
            })
        }
    }
}
