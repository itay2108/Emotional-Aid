//
//  ExerciseQueueController.swift
//  Emotional Aid
//
//  Created by itay gervash on 04/07/2021.
//

import UIKit
import MediaPlayer

class ExerciseQueueController: UIViewController {
    
    var exerciseModel: ExerciseModel?
    
    var currentExercise: Exercise? {
        get {
            return exerciseModel != nil ? exerciseModel!.dataBase[exerciseModel!.currentExercise] : nil
        }
    }
    var personality: Personality?
    
    var audioGuide: URL? {
        get {
            return personality?.emotionalState == .negative && currentExercise?.audioGuide?.negative != nil ? currentExercise?.audioGuide?.negative : currentExercise?.audioGuide?.positive
        }
    }
    
    var delegate: ExerciseSelectorDelegate?
    
    var audioUIUpdateTimer: Timer?
    
    private lazy var handle: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var currentExerciseTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.h1
        label.textAlignment = .left
        label.textColor = K.colors.appText
        
        label.text = exerciseModel != nil ? "\(exerciseModel!.currentExercise + 1). \(exerciseModel!.dataBase[exerciseModel!.currentExercise].title)" : "1. Lorem Ipsum"
        
        return label
    }()
    
    lazy var queueTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ExerciseQueueTableViewCell.self, forCellReuseIdentifier: "queueCell")
        tableView.rowHeight = 73 * heightModifier
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = K.colors.appOffWhite
        tableView.allowsMultipleSelection = false
        return tableView
    }()
    
    private lazy var audioControlsSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    
    lazy var playPauseButton: MediaButton = {
        let button = MediaButton()
        button.playbackState = AudioManager.shared.playbackState
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = K.colors.appBlue
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-forward")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(goForwardButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var goBackwardsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-backwards")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(goBackwardsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var volumeSlider: MPVolumeView = {
        let slider = MPVolumeView()
        slider.maximumVolumeSliderImage(for: .normal)
        slider.showsVolumeSlider = true
        return slider
    }()
    
    lazy var audioProgressSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(named: "slider-thumb-half-opaque-blue"), for: .normal)
        slider.tintColor = K.colors.appBlue
        
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
        label.textColor = K.colors.appText?.withAlphaComponent(0.3)

        label.text = "0:00"
        
        return label
    }()
    
    lazy var timeLeftForAudioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        label.textAlignment = .right
        label.textColor = K.colors.appText?.withAlphaComponent(0.3)

        label.text = "0:00"
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        queueTableView.scrollToRow(at: IndexPath(row: exerciseModel?.currentExercise ?? 0, section: 0), at: .top, animated: false)
        super.viewDidAppear(animated)
    }
    
    private func setUpUI() {
        
        self.view.backgroundColor = K.colors.appOffWhite
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        
        addSubviews()
        addConstraintsToSubviews()
        
        if AudioManager.shared.playbackState == .standby {
            if exerciseModel != nil {
                AudioManager.shared.insert(audio: audioGuide)
            }
        }
        updateAudioUIEvery(interval: 0.1)

    }
    
    private func addSubviews() {
        view.addSubview(handle)
        
        view.addSubview(currentExerciseTitleLabel)
        view.addSubview(queueTableView)
        view.addSubview(audioControlsSV)
        
        view.addSubview(audioProgressSlider)
        view.addSubview(currentAudioTimeLabel)
        view.addSubview(timeLeftForAudioLabel)
        
        audioControlsSV.addArrangedSubview(goBackwardsButton)
        audioControlsSV.addArrangedSubview(playPauseButton)
        audioControlsSV.addArrangedSubview(goForwardButton)
        
        view.addSubview(volumeSlider)
    }
    
    private func addConstraintsToSubviews() {
        
        handle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.height.equalTo(4 * heightModifier)
            make.width.equalTo(36 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        currentExerciseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(handle.snp.bottom).offset(42 * heightModifier)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.right.equalToSuperview().offset(-36 * widthModifier)
            make.height.equalTo(currentExerciseTitleLabel.font.pointSize.percentage(233))
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42 * widthModifier)
            make.right.equalToSuperview().offset(-42 * widthModifier)
            make.bottom.equalToSuperview().offset(-(28 * heightModifier + safeAreaSize(from: .bottom)))
            make.height.equalTo(16 * heightModifier)
        }
        
        audioControlsSV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(volumeSlider.snp.top).offset(-36 * heightModifier)
            make.height.equalTo(64 * heightModifier)
            make.width.equalTo(audioControlsSV.snp.height).multipliedBy(4)
        }
        
        goBackwardsButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.44)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.88)
        }
        
        goForwardButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.44)
        }
        
        currentAudioTimeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(44 * widthModifier)
            make.width.equalTo(30)
            make.bottom.equalTo(audioControlsSV.snp.top).offset(-32 * heightModifier)
            make.height.equalTo(14 * heightModifier)
        }
        
        timeLeftForAudioLabel.snp.makeConstraints { make in
            make.bottom.equalTo(audioControlsSV.snp.top).offset(-32 * heightModifier)
            make.right.equalTo(audioProgressSlider).offset(-2 * heightModifier)
            make.height.equalTo(14 * heightModifier)
            make.width.equalTo(30 * widthModifier)
        }
        
        audioProgressSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42 * widthModifier)
            make.right.equalToSuperview().offset(-42 * widthModifier)
            make.bottom.equalTo(currentAudioTimeLabel.snp.top).offset(-6 * heightModifier)
            make.height.equalTo(16 * heightModifier)
        }
        
        queueTableView.snp.makeConstraints { make in
            make.top.equalTo(currentExerciseTitleLabel.snp.bottom).offset(24 * heightModifier)
            make.left.equalToSuperview().offset(12 * widthModifier)
            make.right.equalToSuperview().offset(-12 * widthModifier)
            make.bottom.equalTo(audioProgressSlider.snp.top).offset(-36 * heightModifier)
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
    
    //MARK: - button targets
    
    @objc func goBackwardsButtonPressed() {
        guard exerciseModel != nil else { return }
        
        let isPlayerInitiallyPaused = AudioManager.shared.playbackState == .paused ? true : false
        
        if AudioManager.shared.playerTime() < 2 {
            
            AudioManager.shared.stopAudio()
            
            exerciseModel!.currentExercise -= 1
            setExercise(to: exerciseModel!.currentExercise)
            queueTableView.reloadData()
            queueTableView.selectRow(at: IndexPath(row: exerciseModel!.currentExercise, section: 0), animated: true, scrollPosition: .middle)
            
            delegate?.set(exerciseTo: exerciseModel!.currentExercise)

            AudioManager.shared.insert(audio: audioGuide)
        } else {
            AudioManager.shared.rewindAudio()
        }
        
        if !isPlayerInitiallyPaused { AudioManager.shared.playAudio() }
        
    }
    
    @objc func playPauseButtonPressed(_ button: MediaButton) {
        guard exerciseModel != nil else { return }
        
        switch AudioManager.shared.playbackState {
        case .standby:
            
            AudioManager.shared.insert(audio: audioGuide) {
                AudioManager.shared.playAudio()
            }
        case .ready:
            AudioManager.shared.playAudio()
        case .playing:
            AudioManager.shared.pauseAudio()
        case .paused:
            AudioManager.shared.playAudio()
        case .finished:
            AudioManager.shared.rewindAudio()
            AudioManager.shared.playAudio()
        }
        
        if AudioManager.shared.playbackState == .playing {
            updateAudioUIEvery(interval: 0.1)
        }

    }
    
    @objc func goForwardButtonPressed() {
        guard exerciseModel != nil else { return }
        
        AudioManager.shared.stopAudio()
        
        exerciseModel!.currentExercise += 1
        
        setExercise(to: exerciseModel!.currentExercise)
        queueTableView.reloadData()
        queueTableView.selectRow(at: IndexPath(row: exerciseModel!.currentExercise, section: 0), animated: true, scrollPosition: .middle)
        
        
        delegate?.set(exerciseTo: exerciseModel!.currentExercise)
        
        AudioManager.shared.insert(audio: audioGuide) {
            AudioManager.shared.playAudio()
        }

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
    
    private func setExercise(to index: Int) {
        //update current exercise in exercise model
        exerciseModel!.currentExercise = index
        
        //update current exercise label
        self.currentExerciseTitleLabel.text = "\(index + 1). \(exerciseModel!.dataBase[index].title)"
        
        //set selected exercise in function
        let selectedExercise = exerciseModel!.dataBase[index]
        
        //deselect all exercises in model and set isSelected to the currently selected one - this is done to display
        //the red ring only around the selected cell.
        exerciseModel!.deselectAllExercises()
        selectedExercise.isCurrentlySelected = true
    }
    
    //MARK: - Communication methods
    
    private func setUpObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlaybackStateChange), name: NSNotification.Name.audioManagerStateDidChange, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleAudioBuffer(_:)), name: NSNotification.Name.audioEngineBufferReceived, object: nil)
    }
    
    @objc private func handlePlaybackStateChange() {
        self.playPauseButton.playbackState = AudioManager.shared.playbackState
        
//        //start listening to keywaords that will change current exercise (ie "next"/"rewind"/etc
//        if AudioManager.shared.playbackState == .finished {
//
//            AudioManager.shared.prepareAudioEngine {
//
//                AudioManager.shared.startAudioEngine()
//            }
//        }
        
    }
    
//    @objc private func handleAudioBuffer(_ notification: NSNotification) {
//        //handle spoken words with speech recognizer
//        if let buffer = notification.userInfo?["buffer"] as? AVAudioPCMBuffer {
//            SpeechRecognitionManager.main.initiate(language: .russian) { success in
//                if success {
//                    SpeechRecognitionManager.main.listen(to: buffer) { result in
//                        print(result)
//                    }
//                }
//            }
//        }
//    }
    
    //MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
}

extension ExerciseQueueController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseModel?.dataBase.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard exerciseModel != nil else { return UITableViewCell() }
        
        let cell = queueTableView.dequeueReusableCell(withIdentifier: "queueCell", for: indexPath) as! ExerciseQueueTableViewCell
        
        cell.setCell(with: exerciseModel?.dataBase[indexPath.row] ?? Exercise(), index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard exerciseModel != nil else { return }
        
        setExercise(to: indexPath.row)
        
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(row: exerciseModel!.currentExercise, section: 0), at: .middle, animated: true)
        
        //update selected exercise also in practiceVC
        delegate?.set(exerciseTo: indexPath.row)
        
        //stop current exerciser audio and play selected one
        AudioManager.shared.stopAudio()
        
        AudioManager.shared.insert(audio: audioGuide) {
            AudioManager.shared.playAudio()
        }
    }
    
    //set header title design in tableview
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = FontTypes.shared.ubuntuMedium.withSize(18 * heightModifier)
        header.textLabel?.textColor = K.colors.appText
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36 * heightModifier
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: tableView.sectionHeaderHeight))
        view.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.contentView.backgroundColor = K.colors.appOffWhite
        view.textLabel?.text = "Exercises"
        return view
    }
    
}
