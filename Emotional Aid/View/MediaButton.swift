//
//  MediaButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/07/2021.
//

import UIKit

class MediaButton: UIButton {

    var playbackState: MediaButtonState = .finished {
        didSet {
            switch playbackState {
            case .finished:
                changeButtonImage(to: UIImage(named: "play-clear"), withTint: K.colors.appBlue)
            case .paused:
                changeButtonImage(to: UIImage(named: "play-clear"), withTint: K.colors.appBlue)
            case .playing:
                changeButtonImage(to: UIImage(named: "pause-clear"), withTint: K.colors.appBlue)
            }
        }
    }
    
    func changeButtonImage(to image: UIImage?, withTint color: UIColor?) {
        self.setImage(image?.withTintColor(color ?? .gray), for: .normal)
        self.layoutSubviews()
    }

}

enum MediaButtonState {
    case playing
    case paused
    case finished
}
