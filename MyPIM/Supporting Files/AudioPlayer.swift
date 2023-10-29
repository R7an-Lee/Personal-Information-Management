//
//  AudioPlayer.swift
//  Communicate
//
//  Created by Osman Balci on 4/7/22.
//  Copyright © 2022 Osman Balci. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

// Global variable
var playerOfAudio: AVAudioPlayer!
 
final class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
   
    @Published var isPlaying = false
    
    /*
     ******************************************************************
     CREATE Audio Player to play the audio contained in a file with url
     ******************************************************************
     */
    func createAudioPlayer(url: URL) {
        do {
            playerOfAudio = try AVAudioPlayer(contentsOf: url)
            playerOfAudio.prepareToPlay()
        } catch {
            print("Unable to create AVAudioPlayer from URL!")
        }
    }
 
    /*
     ************************************************************
     CREATE Audio Player to play the audio contained in audioData
     ************************************************************
     */
    func createAudioPlayer(audioData: Data) {
        do {
            playerOfAudio = try AVAudioPlayer(data: audioData)
            playerOfAudio!.prepareToPlay()
        } catch {
            print("Unable to create AVAudioPlayer from audioData!")
        }
    }
   
    /*
     ***********************
     START Playing the Audio
     ***********************
     */
    func startAudioPlayer() {
       
        let audioSession = AVAudioSession.sharedInstance()
       
        do {
            /*
             AVAudioSession.PortOverride.speaker option causes the system to route audio
             to the built-in speaker and microphone regardless of other settings.
             */
            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Unable to route audio to the built-in speaker!")
        }
       
        if let player = playerOfAudio {
            /*
             Make this class to be a delegate for the AVAudioPlayerDelegate protocol so that
             we can implement the audioPlayerDidFinishPlaying protocol method below.
             */
            player.delegate = self
           
            player.play()
            isPlaying = true
        }
    }
   
    /*
     ***********************
     PAUSE Playing the Audio
     ***********************
     */
    func pauseAudioPlayer() {
        if let player = playerOfAudio {
            player.pause()
            isPlaying = false
        }
    }
   
    /*
     **********************
     STOP Playing the Audio
     **********************
     */
    func stopAudioPlayer() {
        if let player = playerOfAudio {
            player.stop()
            isPlaying = false
        }
    }
   
    /*
     *************************************
     AVAudioPlayerDelegate Protocol Method
     *************************************
     */
    
    // Set @Published var isPlaying to false when the Audio Player finishes playing.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
   
}
