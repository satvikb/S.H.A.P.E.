//
//  SettingsData.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/23/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

struct Setting{
    var name : String = ""
    var value : Bool = false
    
    var setNonActive = {}
    var setActive = {}

    init(_name : String, _value : Bool){
        name = _name
        value = _value
    }
    
    mutating func setValue(val : Bool){
        value = val
        
        if(val == true){
            setToActive()
        }else{
            setToNotActive()
        }
    }
    
    func setToNotActive(){
        self.setNonActive()
    }
    
    func setToActive(){
        self.setActive()
    }
}

class SettingsData {
    
    static var settings : [Setting] = []
    
    static var reduceColors : Bool = false
    
    static func Setup(){
        var audioSetting = Setting(_name: "Audio", _value: true)
        audioSetting.setNonActive = {
            Sounds.audioEnabled = false
        }
        audioSetting.setActive = {
            Sounds.audioEnabled = true
        }
        
        var reduceColorSetting = Setting(_name: "Reduce Colors", _value: false)
        reduceColorSetting.setValue(val: false)
        reduceColorSetting.setNonActive = {
            reduceColors = false
        }
        reduceColorSetting.setActive = {
            reduceColors = true
        }
        
        settings.append(audioSetting)
        settings.append(reduceColorSetting)
    }
}
