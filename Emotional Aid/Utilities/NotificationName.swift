//
//  NotificationName.swift
//  Emotional Aid
//
//  Created by itay gervash on 10/07/2021.
//

import UIKit

extension Notification.Name {
    
    static var ApplicationDidEnterForeground: Notification.Name {
            return .init("application.DidEnterForeground")
    }
    
    static var audioManagerDidFinishPlayback: Notification.Name {
            return .init(rawValue: "audioManager.didFinichPlayback")
        }
    
    static var audioManagerStateDidChange: Notification.Name {
            return .init(rawValue: "audioManager.stateDidChange")
        }
    
    static var audioEngineBufferReceived: Notification.Name {
            return .init(rawValue: "audioEngine.bufferReceived")
    }
    
    static var exerciseSliderValueHasChanged: Notification.Name {
            return .init(rawValue: "exerciseSlider.valueHasChanged")
    }
    
    static var SignInTextFieldDidBeginEditing: Notification.Name {
            return .init(rawValue: "signInTextField.didBeginEditing")
    }
    
    static var SystemVolumeDidChange: Notification.Name {
            return .init("systemVolume.DidChange")
    }
    
    static var SpeechRecognizerDidMatchTrigger: Notification.Name {
            return .init("speechRecognizer.DidMatchTrigger")
    }
    
    static var AudioEngineDidTimeout: Notification.Name {
            return .init("audioManager.DidTimeout")
    }
    
    static var SpeechRecognitionDidInvalidate: Notification.Name {
            return .init("speechRecognition.DidInvalidate")
    }
    
    static var GenderDidChange: Notification.Name {
            return .init("gender.didChange")
    }
    
    static var AudioSessionDidInterrupt: Notification.Name {
            return .init("audioSession.didInterrupt")
    }

}
