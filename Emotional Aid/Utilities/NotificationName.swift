//
//  NotificationName.swift
//  Emotional Aid
//
//  Created by itay gervash on 10/07/2021.
//

import UIKit

extension Notification.Name {
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

}
