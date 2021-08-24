//
//  MediaButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/07/2021.
//

import UIKit

class MediaButton: UIButton {
    
    var graphicsTint: UIColor? = K.colors.appRed {
        didSet {
            self.tintColor = graphicsTint
            self.imageView?.tintColor = graphicsTint
            self.imageView?.image = self.imageView?.image?.withTintColor(graphicsTint ?? .red)
            layoutSubviews()
        }
    }

    var playbackState: AudioPlaybackState = .finished {
        didSet {
            switch playbackState {
            case .finished:
                changeButtonImage(to: UIImage(named: "play-clear")?.withRenderingMode(.alwaysTemplate), withTint: graphicsTint)
            case .playing:
                changeButtonImage(to: UIImage(named: "pause-clear")?.withRenderingMode(.alwaysTemplate), withTint: graphicsTint)
            default:
                changeButtonImage(to: UIImage(named: "play-clear")?.withRenderingMode(.alwaysTemplate), withTint: graphicsTint)
            }
        }
    }
    
    func changeButtonImage(to image: UIImage?, withTint color: UIColor? = nil) {
        self.setImage(image?.withTintColor(color ?? .gray).withRenderingMode(.alwaysTemplate), for: .normal)
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
