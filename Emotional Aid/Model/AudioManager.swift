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
    
    //MARK: - Audio player
    
    var player: AVAudioPlayer?

    public var playbackState: AudioPlaybackState = .standby {
        didSet {
            if playbackState == .finished { NotificationCenter.default.post(name: NSNotification.Name.audioManagerDidFinishPlayback, object: nil)}
            
            NotificationCenter.default.post(name: NSNotification.Name.audioManagerStateDidChange, object: nil)
        }
    }
    
    func setAudioSessionState(to category: AVAudioSession.Category) {
        do {
            try AVAudioSession.sharedInstance().setCategory(category)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func insert(audio url: URL?, completion: (() -> Void)? = nil) {
        guard let URL = url else { print("couldn't parse audio url"); return }
        
        do {
            setAudioSessionState(to: .playback)
            
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
        if playbackState == .playing { print("player is already playing"); return }
        player!.play()
        playbackState = .playing
    }
    
    func playAudioAt(time: Double) {
        guard player != nil && player?.url != nil else { print("can't play audio - player is nil"); return }
        player!.currentTime = time
        player?.play()
        playbackState = .playing
    }
    
    func pauseAudio() {
        guard player != nil && player?.url != nil else { print("can't pause audio - player is nil"); return }
        if playbackState == .paused { print("player is already paused"); return }
        player!.pause()
        playbackState = .paused
    }
    
    func stopAudio() {
        guard player != nil && player?.url != nil else { print("can't stop audio - player is nil"); return }
        if playbackState == .standby { print("player is already stopped"); return }
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
    
    //MARK: - Audio Recorder
    
    private var audioEngine: AVAudioEngine?
    
    var audioEngineMaxAllowedTimeActive = 10
    
    var timer: Timer?
    
    func requestMicrophoneUsage(completion: ((_ success: Bool) -> Void)?) {
        AVAudioSession.sharedInstance().requestRecordPermission { success in
            guard completion != nil else { return }
            if success { completion!(true) }
            else { completion!(false) }
        }
    }
    
    func prepareAudioEngine(_ completion: (() -> Void)?) {
        audioEngine = AVAudioEngine()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let recordingFormat = audioEngine!.inputNode.outputFormat(forBus: 0)
        audioEngine!.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            if !SpeechRecognitionManager.main.isRecognizerActive {
                SpeechRecognitionManager.main.initiate(language: .russian) { success in
                    if success {
                        SpeechRecognitionManager.main.listen(to: buffer)
                    }
                }
            }

            SpeechRecognitionManager.main.recognitionRequest?.append(buffer)
        }

        audioEngine?.prepare()
        print("preparing audio engine")
        if completion != nil { completion!() }

    }
    
    func startAudioEngine() {
        guard audioEngine != nil,
              !audioEngine!.isRunning
        else { return }
        
        do {
            try audioEngine?.start()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(audioEngineMaxAllowedTimeActive)) {
                if let engine = self.audioEngine {
                    if engine.isRunning {
                        self.stopAudioEngine()
                    }
                }
            }
            
            print("starting audio engine")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopAudioEngine() {
        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine?.stop()
        
        timer?.invalidate()
        timer = nil
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch {
            print("error setting session category to playback when stopping audio engine.")
        }
        
        print("stopping audio engine")
    }    
    
}


enum AudioPlaybackState {
    case standby
    case ready
    case playing
    case paused
    case finished
}
