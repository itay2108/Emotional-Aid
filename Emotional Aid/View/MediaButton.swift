//
//  MediaButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/07/2021.
//

import UIKit

class MediaButton: UIButton {

    var playbackState: AudioPlaybackState = .finished {
        didSet {
            switch playbackState {
            case .finished:
                changeButtonImage(to: UIImage(named: "play-clear"), withTint: K.colors.appBlue)
            case .playing:
                changeButtonImage(to: UIImage(named: "pause-clear"), withTint: K.colors.appBlue)
            default:
                changeButtonImage(to: UIImage(named: "play-clear"), withTint: K.colors.appBlue)
            }
        }
    }
    
    func changeButtonImage(to image: UIImage?, withTint color: UIColor?) {
        self.setImage(image?.withTintColor(color ?? .gray), for: .normal)
        self.layoutSubviews()
    }
    
    //MARK: - Communication methods
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlaybackStateChange), name: NSNotification.Name.audioManagerStateDidChange, object: nil)
    }
    
    @objc private func handlePlaybackStateChange() {
        self.playbackState = AudioManager.shared.playbackState
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUpObservers()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUpObservers()
    }

}
