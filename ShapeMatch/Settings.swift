//
//  Settings.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/22/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

class Settings: UIView {
    
    let transitionTime: CGFloat = 0.5
    
    var titleLabel: Label = Label.Null
    var scoreLabel: Label = Label.Null
    
    var creditsLabel: Label = Label.Null
    
    var backButton: Square
    
    var settingLabels : [Label] = []
    var settingButtons : [SettingButton] = []
    
    override init(frame: CGRect) {
        
        let titleLabelSize = CGSize(width: 0.6, height: 0.2)
        let buttonHeight: CGFloat = 0.15

        titleLabel = Label(frame: CGRect(origin: Screen.getScreenPos(x: 0.1, y: 0.1), size: Screen.getScreenSize(x: titleLabelSize.width, y: titleLabelSize.height)), text: "Settings", _outPos: Screen.getScreenPos(x: 0.5-(titleLabelSize.width/2), y: 1+buttonHeight), _inPos: Screen.getScreenPos(x: 0.2, y: 0.1), textColor: UIColor.cyan)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 10))
        titleLabel.textAlignment = .center
        
        backButton = Square(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: 0.2, y: 0.1)), color: UIColor.clear, _outPos: Screen.getScreenPos(x: -0.2, y: 0), _inPos: Screen.getScreenPos(x: 0.15, y: 0.05), text: "Back")
        backButton.tap = {
            GameController.sharedInstance.switchFromTo(from: .Settings, to: .MainMenu)
        }
          
        creditsLabel = Label(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: 1, y: 0.1)), text: "© Satvik Borra & Virindh Borra", _outPos: Screen.getScreenPos(x: 0, y: 1), _inPos: Screen.getScreenPos(x: 0, y: 0.9), textColor: UIColor.white, debugFrame: false, _neon: false)
        creditsLabel.textAlignment = .center
                
        super.init(frame: frame)

//        let settingsData = SettingsData.settings
        
        let settingYOffset: CGFloat = 0.4
        let settingX: CGFloat = 0.1
        let widthOfSetting: CGFloat = 0.8
        let heightOfSetting: CGFloat = 0.1
        let labelWidth : CGFloat = 0.5
        
        for i in 0...SettingsData.settings.count-1{
            let setting = SettingsData.settings[i]
            let text = setting.name
            let activated = setting.value
            
            let settingY = settingYOffset+(CGFloat(i)*heightOfSetting)
            
            let label: Label = Label(frame: CGRect(origin: CGPoint.outOfScreen, size: Screen.getScreenSize(x: labelWidth, y: heightOfSetting)), text: text, _outPos: Screen.getScreenPos(x: -widthOfSetting, y: settingY), _inPos: Screen.getScreenPos(x: settingX, y: settingY))
            label.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2))
            label.adjustsFontSizeToFitWidth = true
            
            settingLabels.append(label)
            self.addSubview(label)
            
            var buttonSize : CGSize = Screen.getScreenSize(x: 0, y: heightOfSetting)
            buttonSize.width = buttonSize.height
            let button: SettingButton = SettingButton(frame: CGRect(origin: CGPoint.outOfScreen, size: buttonSize), _inPos: Screen.getScreenPos(x: 0.7, y: settingY), _outPos: Screen.getScreenPos(x: 1.3, y: settingY), _activated: activated)
            button.tap = {
                SettingsData.settings[i].setValue(val: button.activated)
            }
            
            settingButtons.append(button)
            self.addSubview(button)
        }
        
        
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(creditsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(){
        titleLabel.animateIn(time: transitionTime)
        backButton.animateIn(time: transitionTime)
        creditsLabel.animateIn(time: transitionTime)
        
        for label in settingLabels{
            label.animateIn(time: transitionTime)
        }
        
        for button in settingButtons{
            button.animateIn(time: transitionTime)
        }
    }
    
    func animateOut(){
        titleLabel.animateOut(time: transitionTime)
        backButton.animateOut(time: transitionTime)
        creditsLabel.animateOut(time: transitionTime)
        
        for label in settingLabels{
            label.animateOut(time: transitionTime)
        }
        
        for button in settingButtons{
            button.animateOut(time: transitionTime)
        }
    }
}
