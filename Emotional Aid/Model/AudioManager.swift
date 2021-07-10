//
//  AudioManager.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/07/2021.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, AVAudioPlayerDelegate {
    
    static let shared = AudioManager()
    
    var player: AVAudioPlayer?

    public var playbackState: AudioPlaybackState = .standby {
        didSet {
            if playbackState == .finished { NotificationCenter.default.post(name: NSNotification.Name.audioManagerDidFinishPlayback, object: nil)}
            
            NotificationCenter.default.post(name: NSNotification.Name.audioManagerStateDidChange, object: nil)
        }
    }
    
    func insert(audio url: URL?, completion: (() -> Void)? = nil) {
        guard let URL = url else { print("couldn't parse audio url"); return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: URL, fileTypeHint: AVFileType.wav.rawValue)
            player?.delegate = self
            playbackState = .ready
            if completion != nil { completion!() }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func playAudio() {
        guard player != nil && player?.url != nil else { print("can't play audio - player is nil"); return }
        player!.play()
        playbackState = .playing
    }
    
    func pauseAudio() {
        guard player != nil && player?.url != nil else { print("can't pause audio - player is nil"); return }
        player!.pause()
        playbackState = .paused
    }
    
    func stopAudio() {
        guard player != nil && player?.url != nil else { print("can't stop audio - player is nil"); return }
        player!.stop()
        playbackState = .standby
    }
    
    func rewindAudio() {
        guard player != nil && player?.url != nil else { print("can't rewind audio - player is nil"); return }
        player!.currentTime = 0
        playbackState = .ready
    }
    
    func playerTime() -> Int {
        guard player != nil else { return 0 }
        return Int(player!.currentTime)
    }
    
    func audioLengthInSeconds() -> Int {
        guard player != nil else { return 0 }
        return Int(player!.duration)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playbackState = .finished
    }
    
}


enum AudioPlaybackState {
    case standby
    case ready
    case playing
    case paused
    case finished
}
