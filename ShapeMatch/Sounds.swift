//
//  Sounds.swift
//  ShapeMatch
//
//  Created by Satvik Borra on 12/21/16.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit
import AVFoundation

class Sounds{
    
    static var MatchedSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Matched", ofType: "wav")!)
    static var MatchedSoundPlayer = AVAudioPlayer()
    
    static var GameOverSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "GameOver", ofType: "wav")!)
    static var GameOverSoundPlayer = AVAudioPlayer()
    
    static func Setup(){
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            
        }
        
        MatchedSoundPlayer = try! AVAudioPlayer(contentsOf: MatchedSound as URL)
        GameOverSoundPlayer = try! AVAudioPlayer(contentsOf: GameOverSound as URL)

        MatchedSoundPlayer.prepareToPlay()
        GameOverSoundPlayer.prepareToPlay()
    }
    
    static func PlayMatchedSound(){
        DispatchQueue.global(qos: .background).async {
            MatchedSoundPlayer.play()
        }
    }
    
    static func PlayGameOverSound(){
        DispatchQueue.global(qos: .background).async {
            GameOverSoundPlayer.play()
        }
    }
    
}
