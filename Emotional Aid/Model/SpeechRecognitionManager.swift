//
//  SpeechRecognitionManager.swift
//  Emotional Aid
//
//  Created by itay gervash on 17/07/2021.
//

import UIKit
import Speech
import os

@available(iOS 14.0, *)
class SpeechRecognitionManager: NSObject, SFSpeechRecognizerDelegate {
    
    static let main = SpeechRecognitionManager()
    
    var recognizer: SFSpeechRecognizer?
    var recognitionTask: SFSpeechRecognitionTask?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    var isRecognizerActive = false
    var isRecognitionResultFinal = true {
        didSet {
            if isRecognitionResultFinal {
                print("result is final")
            }
        }
    }
    
    func initiate(language: Language, completion: (_ success: Bool) -> Void) {
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: language.rawValue))
        
        if let initiatedRecognizer = recognizer {
            guard initiatedRecognizer.isAvailable else { completion(false); return }
            initiatedRecognizer.delegate = self
            isRecognizerActive = true
            textLog.write("speech recognizer initiated")
            completion(true)
        }
    }
    
    func authorizeSpeechRecognition(completion: @escaping (_ success: Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    completion(true)
                    textLog.write("speech recognizer authorized")
                default:
                    print("speech recognition denied")
                    textLog.write("speech recognizer denied")
                    completion(false)
                }
            }
            
        }
    }
    
    func listen(to audio: AVAudioPCMBuffer) {
        guard recognizer != nil else { return }
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        var SRResult: String? {
            didSet {
                if SRResult != nil && SRResult != oldValue {
                    SpeechRecognitionManager.main.searchFor(trigger: K.speechTriggers.all, in: SRResult!.capitalized) { found, action  in
                        if found && action != nil {
                            NotificationCenter.default.post(name: NSNotification.Name.SpeechRecognizerDidMatchTrigger, object: nil, userInfo: ["action" : action!])
                            Vibration.success.vibrate()
                            textLog.write("found *\(action!)* trigger in \"\(SRResult!)\"")
                            self.invalidate()
                        }
                    }
                }
            }
        }
        
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionRequest.requiresOnDeviceRecognition = false
        
        recognitionTask = recognizer!.recognitionTask(with: recognitionRequest) { result, error in
            if result != nil {
                if let result = result {
                    // handle results.
                    SRResult = result.bestTranscription.formattedString
                    self.isRecognitionResultFinal = result.isFinal
                }
            }
            if ( error != nil && !error!.localizedDescription.contains("216") ) || self.isRecognitionResultFinal {
                // Stop recognizing speech if there is a problem.
                print(error != nil ? "SR error: \(error!.localizedDescription)" : "received final recognition result")
                textLog.write(error?.localizedDescription ?? "error: nil")
                self.recognitionTask?.cancel()
                self.recognitionRequest?.endAudio()
                
                self.invalidate()
            }
        }
        textLog.write("speech recognizer is listening...")
        Vibration.light.vibrate()
        
    }
    
    
    func searchFor(trigger words: [TriggerWord], in recognizedSpeechContent: String, completion: (_ success: Bool, _ action: TriggerWordType?) -> Void) {
        print("searching in \(recognizedSpeechContent)...")
        textLog.write("searching in \(recognizedSpeechContent)...")
        
        for word in words {
            if recognizedSpeechContent.contains(word.value) {
                completion(true, word.type)
            }
        }
        
    }
    
    func invalidate() {
        self.recognitionTask?.cancel()
        self.recognitionTask?.finish()
        self.recognitionRequest = nil
        self.isRecognizerActive = false
        textLog.write("speech recognizer invalidated")
    }
    
    
}

enum Language: String {
    
    case english = "en_US"
    case russian = "ru_RU"
}
