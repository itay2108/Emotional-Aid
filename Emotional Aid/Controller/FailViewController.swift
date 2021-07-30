//
//  FailViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 24/07/2021.
//

import UIKit

class FailViewController: UIViewController {
    
    var finishCondition: FinishCondition
    
    private var audioUIUpdateTimer: Timer?
    
    private lazy var navContainer: UIView  = {
        return Container()
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(K.uikit.xButton?.withTintColor(.white), for: .normal)
        button.tintColor = .white
        //button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainTitle: UILabel    = {
        let label = UILabel()
        label.font = FontTypes.shared.h1.withSize(44 * heightModifier)
        label.textColor = .white
        label.textAlignment = .center
        label.textSpacing(of: 5)
        
        label.text = "Хм..."
        return label
    }()
    
    private lazy var mainArtwork: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = K.uikit.successArt
        return view
    }()
    
    lazy var playPauseButton: MediaButton = {
        let button = MediaButton()
        button.playbackState = AudioManager.shared.playbackState
        button.contentMode = .scaleAspectFit
        button.graphicsTint = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var audioProgressSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "slider-thumb-half-opaque-blue")?.withTintColor(.white), for: .normal)
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = K.colors.appOffWhite?.withAlphaComponent(0.66)
        
        if AudioManager.shared.playbackState != .standby {
            slider.maximumValue = Float(AudioManager.shared.player?.duration ?? 0)
        }
        
        slider.value = Float(AudioManager.shared.playerTime())
        slider.addTarget(self, action: #selector(handleSliderValueChanged(_:_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var currentAudioTimeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        label.textAlignment = .left
        label.textColor = .white.withAlphaComponent(0.3)
        
        label.text = "0:00"
        
        return label
    }()
    
    lazy var timeLeftForAudioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        label.textAlignment = .right
        label.textColor = .white.withAlphaComponent(0.3)
        
        label.text = "0:00"
        
        return label
    }()
    
    private lazy var failDescription: UITextView = {
        let textView = UITextView()
        textView.font = FontTypes.shared.ubuntu.withSize(13 * heightModifier)
        textView.textColor = .white
        textView.backgroundColor = .clear
        //        textView.backgroundColor = .black.withAlphaComponent(0.12)
        //        textView.roundCorners(.allCorners, radius: 15)
        textView.textAlignment = .center
        textView.isScrollEnabled = true
        textView.text = K.text.failDidNotHelpDescription
        return textView
    }()
    
    private lazy var consultButton: UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.white), for: .normal)
        
        button.setTitle("Записаться на консультацию", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(K.colors.appText, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.gradientBackground(colors: [K.colors.appRedLight!.cgColor, K.colors.appRed!.cgColor], type: .radial, direction: .topToBottom)
        
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        failDescription.flashScrollIndicators()
    }
    
    func setUpUI() {
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(closeButton)
        navContainer.addSubview(mainTitle)
        
        view.addSubview(mainArtwork)
        
        view.addSubview(playPauseButton)
        view.addSubview(audioProgressSlider)
        view.addSubview(currentAudioTimeLabel)
        view.addSubview(timeLeftForAudioLabel)
        
        view.addSubview(failDescription)
        
        view.addSubview(consultButton)
    }
    
    func addConstraintsToSubviews() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(84 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.height.equalTo(20 * heightModifier)
            make.width.equalTo(20 * heightModifier)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.left.equalTo(closeButton.snp.right).offset(16 * widthModifier)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview().offset(5 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        mainArtwork.snp.makeConstraints { make in
            make.width.equalTo(160 * widthModifier)
            make.height.equalTo(148 * heightModifier)
            make.centerX.equalToSuperview()
            make.top.equalTo(navContainer.snp.bottom).offset(48 * heightModifier)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.width.equalTo(32 * widthModifier)
            make.height.equalTo(32 * widthModifier)
            make.top.equalTo(mainArtwork.snp.bottom).offset(64)
            make.left.equalToSuperview().offset(56 * widthModifier)
        }
        
        audioProgressSlider.snp.makeConstraints { make in
            make.left.equalTo(playPauseButton.snp.right).offset(16 * widthModifier)
            make.centerY.equalTo(playPauseButton).offset(-6)
            make.right.equalToSuperview().offset(-60 * widthModifier)
            make.height.equalTo(16 * heightModifier)
        }
        
        currentAudioTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(audioProgressSlider).offset(2 * widthModifier)
            make.centerY.equalTo(playPauseButton).offset(12)
            make.width.equalTo(30 * widthModifier)
            make.height.equalTo(currentAudioTimeLabel.font.pointSize.percentage(120))
        }
        
        timeLeftForAudioLabel.snp.makeConstraints { make in
            make.right.equalTo(audioProgressSlider).offset(-2 * widthModifier)
            make.centerY.equalTo(playPauseButton).offset(12)
            make.width.equalTo(30 * widthModifier)
            make.height.equalTo(currentAudioTimeLabel.font.pointSize.percentage(120))
        }
        
        consultButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(24 + view.safeAreaSize(from: .bottom)))
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.right.equalToSuperview().offset(-28 * widthModifier)
            make.height.equalTo(56 * heightModifier)
        }
        
        failDescription.snp.makeConstraints { make in
            make.top.equalTo(audioProgressSlider.snp.bottom).offset(36 * heightModifier)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(consultButton.snp.top).offset(-36 * heightModifier)
        }
        
    }
    
    func setContentAccordingToFinishCondition() {
        
        switch finishCondition {
        case .failDidNotHelp:
            mainArtwork.image = K.uikit.failArt
            failDescription.text = K.text.failDidNotHelpDescription
        case .warningBecamePositive:
            mainArtwork.image = K.uikit.failArt
            failDescription.text = K.text.warningBecamePositiveDescription
        case .warningBecameNegative:
            mainArtwork.image = K.uikit.failArt
            failDescription.text = K.text.warningBecameNegativeDescription
        default:
            mainArtwork.image = K.uikit.failArt
            failDescription.text = ""
        }
    }
    
    //MARK: - media methods
    
    func updateAudioUIEvery(interval: TimeInterval) {
        audioProgressSlider.maximumValue = Float(AudioManager.shared.player?.duration ?? 0)
        audioUIUpdateTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.updateAudioUI), userInfo: nil, repeats: true)
    }
    
    @objc func updateAudioUI() {
        updateMediaLabels()
        updateMediaSlider()
    }
    
    private func updateMediaSlider() {
        audioProgressSlider.value = Float(AudioManager.shared.playerTime())
    }
    
    private func updateMediaLabels() {
        //here the code takes the length of the audio in seconds and formats it for text labels
        //get array of minutes + seconds for audio length
        let currentAudioTime = AudioManager.shared.playerTime().seconds(inComponents: [.minute, .second])
        //format array of in to string. also adds a 0 to seconds if it is single digit
        currentAudioTimeLabel.text = audioFormattedTimeLabel(minutes: currentAudioTime[0], seconds: currentAudioTime[1])
        //calculate time left for playback and format in the same way
        let audioTimeLeft = (AudioManager.shared.audioLengthInSeconds() - AudioManager.shared.playerTime()).seconds(inComponents: [.minute, .second])
        timeLeftForAudioLabel.text = "-" + audioFormattedTimeLabel(minutes: audioTimeLeft[0], seconds: audioTimeLeft[1])
    }
    
    private func audioFormattedTimeLabel(minutes: Int, seconds: Int) -> String {
        var time = "\(minutes):"
        let formattedSeconds = String(seconds).count == 1 ? "0\(seconds)" : "\(seconds)"
        time.append(formattedSeconds)
        
        return time
    }
    
    //MARK: - Button selectors
    
    @objc func playPauseButtonPressed(_ button: MediaButton) {
        
    }
    
    @objc func handleSliderValueChanged(_ slider: UISlider, _ event: UIEvent) {
        
        let wasPlayingAudio = AudioManager.shared.playbackState == .playing ? true : false
        
        if AudioManager.shared.playbackState != .standby {
            audioUIUpdateTimer?.invalidate()
            
            if let eventPhase = event.allTouches?.first?.phase {
                if eventPhase == .ended {
                    AudioManager.shared.playAudioAt(time: Double(slider.value))
                    
                    if wasPlayingAudio { updateAudioUIEvery(interval: 0.1) }
                    else { AudioManager.shared.pauseAudio() }
                }
            }
            
        }
    }
    
    //MARK: - inits
    
    init(fail reason: FinishCondition) {
        self.finishCondition = reason
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.finishCondition = .failDidNotHelp
        super.init(coder: aDecoder)
    }
    
    
    
}
