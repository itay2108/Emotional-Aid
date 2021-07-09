//
//  AudioManager.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/07/2021.
//

import Foundation
import AVFoundation

class AudioManager {
    
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    
    func insert(audio url: URL?, completion: (() -> Void)? = nil) {
        guard let URL = url else { print("couldn't parse audio url"); return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: URL, fileTypeHint: AVFileType.wav.rawValue)
            
            if completion != nil { completion!() }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playAudio() {
        guard player != nil && player?.url != nil else { print("can't play audio - player is nil"); return }
        player!.play()
    }
    
    func pauseAudio() {
        guard player != nil && player?.url != nil else { print("can't pause audio - player is nil"); return }
        player!.pause()
    }
    
    func stopAudio() {
        guard player != nil && player?.url != nil else { print("can't stop audio - player is nil"); return }
        player!.stop()
    }
    
    func rewindAudio() {
        guard player != nil && player?.url != nil else { print("can't rewind audio - player is nil"); return }
        player!.currentTime = 0
    }
    
}
