//
//  SpeechRecognitionManager.swift
//  Emotional Aid
//
//  Created by itay gervash on 17/07/2021.
//

import UIKit
import Speech

class SpeechRecognitionManager: NSObject, SFSpeechRecognizerDelegate {
    
    static let main = SpeechRecognitionManager()
    
    var recognizer: SFSpeechRecognizer?
    var recognitionTask: SFSpeechRecognitionTask?
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    func initiate(language: Language, completion: (_ success: Bool) -> Void) {
        recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: language.rawValue))
        
        if let initiatedRecognizer = recognizer {
            guard initiatedRecognizer.isAvailable else { completion(false); return }
            initiatedRecognizer.delegate = self
            completion(true)
        }
    }
    
    func authorizeSpeechRecognition(completion: @escaping (_ success: Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    completion(true)
                default:
                    print("speech recognition denied")
                    completion(false)
                }
            }
            
        }
    }
    
    func listen(to audio: AVAudioPCMBuffer, handler: @escaping (_ result: String) -> Void) {
        guard recognizer != nil else { return }
        
        recognitionTask?.cancel()
        recognitionTask = nil
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        recognitionRequest.append(audio)
        
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        recognitionTask = recognizer!.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            print("listening...")
            if result != nil {
                if let result = result {
                    // handle results.
                    let transcription = result.bestTranscription.formattedString
                    //handler(transcription)
                    print(transcription)
                    
                    isFinal = result.isFinal
                }
            }
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                print(error?.localizedDescription as Any)
                
                self.recognitionTask?.cancel()
                self.recognitionRequest?.endAudio()
                
                AudioManager.shared.stopAudioEngine()
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
    }
    
    
    
    
}

enum Language: String {
    
    case english = "en_US"
    case russian = "ru_RU"
}
