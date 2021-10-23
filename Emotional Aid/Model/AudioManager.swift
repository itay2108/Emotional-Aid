//
//  AudioManager.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/07/2021.
//

import Foundation
import AVKit
import SoundAnalysis

class AudioManager: NSObject, AVAudioPlayerDelegate {
    
    static let shared = AudioManager()
    
    //MARK: - Audio player
    
    var player: AVAudioPlayer?

    public var playbackState: AudioPlaybackState = .standby {
        didSet {
            if playbackState == .finished { NotificationCenter.default.post(name: NSNotification.Name.audioManagerDidFinishPlayback, object: nil)}
            
            NotificationCenter.default.post(name: NSNotification.Name.audioManagerStateDidChange, object: nil)
            textLog.write("AudioManager state chaged to: \(playbackState)")
        }
    }
    
    func setAudioSessionState(to category: AVAudioSession.Category) {
        do {
            try AVAudioSession.sharedInstance().setCategory(category)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            print(error.localizedDescription)
            textLog.write("AVAudioSession error: \(error.localizedDescription)")
        }
    }
    
    func insert(audio url: URL?, completion: (() -> Void)? = nil, file: String = #file, line: Int = #line, function: String = #function) {
        guard let URL = url else { print("couldn't parse audio url"); return }
        print("\(file):\(line) : \(function)")
        do {
            setAudioSessionState(to: .playback)
            
            player = try AVAudioPlayer(contentsOf: URL, fileTypeHint: AVFileType.wav.rawValue)
            player?.delegate = self
            playbackState = .ready
            if completion != nil { completion!() }
        } catch let error {
            print(error.localizedDescription)
            textLog.write("AVAudioSession error: couldnt prepare audio player. \(error.localizedDescription)")
        }
        
    }
    
    func playAudio() {
        guard player != nil && player?.url != nil else { textLog.write("can't play audio - player is nil"); return }
        if playbackState == .playing { print("player is already playing"); return }
        player!.play()
        playbackState = .playing
        print("playing: ", player?.url)
    }
    
    func playAudioAt(time: Double) {
        guard player != nil && player?.url != nil else { textLog.write("can't play audio - player is nil"); return }
        player!.currentTime = time
        player?.play()
        playbackState = .playing
    }
    
    func pauseAudio() {
        guard player != nil && player?.url != nil else { textLog.write("can't pause audio - player is nil"); return }
        if playbackState == .paused { print("player is already paused"); return }
        player!.pause()
        playbackState = .paused
    }
    
    func stopAudio() {
        guard player != nil && player?.url != nil else { textLog.write("can't stop audio - player is nil"); return }
        if playbackState == .standby { print("player is already stopped"); return }
        player!.stop()
        playbackState = .standby
    }
    
    func rewindAudio() {
        guard player != nil && player?.url != nil else { textLog.write("can't rewind audio - player is nil"); return }
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
    
    func invalidatePlayer() {
        guard player != nil else { return }
        player = nil
        playbackState = .standby
        textLog.write("player invalidated")
    }
    
    //MARK: - Audio Recorder
    
    private var audioEngine: AVAudioEngine?
    
    var audioEngineMaxAllowedTimeActive = 180
    
    var timer: Timer?
    
    func requestMicrophoneUsage(completion: ((_ success: Bool) -> Void)?) {
        AVAudioSession.sharedInstance().requestRecordPermission { success in
            guard completion != nil else { return }
            if success { completion!(true) }
            else { completion!(false) }
        }
    }
    
    func isMicrophoneAllowed() -> Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted ? true : false
    }
    
    func prepareAudioEngine(_ completion: (() -> Void)?) {
        audioEngine = AVAudioEngine()
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error {
            print(error.localizedDescription)
            textLog.write("Error: couldn't prepare audio engine - \(error.localizedDescription)")
        }
        
        let recordingFormat = audioEngine!.inputNode.outputFormat(forBus: 0)
        audioEngine!.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            if self.volume(of: buffer, bufferSize: 1024) > 0.01 {
                print(self.volume(of: buffer, bufferSize: 1024))
                if !SpeechRecognitionManager.main.isRecognizerActive {
                    SpeechRecognitionManager.main.initiate(language: .russian) { success in
                        if success {
                            SpeechRecognitionManager.main.listen(to: buffer)
                        }
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
            textLog.write("Error: couldn't start audio engine - \(error.localizedDescription)")
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
            textLog.write("error setting session category to playback when stopping audio engine.")
        }
        
        textLog.write("stopping audio engine")
    }
    
    private func volume(of buffer: AVAudioPCMBuffer, bufferSize: Int) -> Float {
        guard let channelData = buffer.floatChannelData?[0] else {
            return 0
        }

        let channelDataArray = Array(UnsafeBufferPointer(start:channelData, count: bufferSize))

        var outEnvelope = [Float]()
        var envelopeState:Float = 0
        let envConstantAtk:Float = 0.16
        let envConstantDec:Float = 0.003

        for sample in channelDataArray {
            let rectified = abs(sample)

            if envelopeState < rectified {
                envelopeState += envConstantAtk * (rectified - envelopeState)
            } else {
                envelopeState += envConstantDec * (rectified - envelopeState)
            }
            outEnvelope.append(envelopeState)
        }

        // 0.007 is the low pass filter to prevent
        // getting the noise entering from the microphone
        if let maxVolume = outEnvelope.max(),
            maxVolume > Float(0.015) {
            return maxVolume
        } else {
            return 0.0
        }
    }
    
}


enum AudioPlaybackState {
    case standby
    case ready
    case playing
    case paused
    case finished
}
