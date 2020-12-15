//
//  SoundManager.swift
//  MatchApp
//
//  The MIT License (MIT)
//  Copyright © 2020 d-exclaimation
//

import Foundation

import AVFoundation

class SoundManager {
    
    // Make a new sound variable
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    // Method for playing sound
    func playSound(_ effect: SoundEffect) {
        
        // Creating a variable to pass in the name of sound files
        var soundFileName = ""
        
        // Play sound determined by parameter
        switch effect {
            
            case .flip:
            soundFileName = "cardflip"
            
            case .match:
            soundFileName = "dingcorrect"
            
            case .nomatch:
            soundFileName = "dingwrong"
            
            case .shuffle:
            soundFileName = "shuffle"
            
        }
        
        // Find the path using bundle
        let soundPath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        // Check for not nil
        guard soundPath != nil else {
            return
        }
        
        // Assigning a url using the path
        let soundURL = URL(fileURLWithPath: soundPath!)
        
        // Catching error
        do {
            
            // Playing the sound using url
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
            
        } catch {
            // Failed or Error happened
            print("Failed")
            return
        }
        
        
    }
}
