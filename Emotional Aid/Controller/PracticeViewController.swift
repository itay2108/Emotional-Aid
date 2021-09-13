//
//  PracticeViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit
import PaddingLabel
import AVKit

class PracticeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    var isInDemoMode: Bool {
        get {
            return demoSwitch.isOn
        }
    }
    
    var exerciseModel: ExerciseModel = ExerciseModel()
    
    var currentExercise: Exercise {
        get {
            return exerciseModel.dataBase[exerciseModel.currentExercise]
        }
    }
    
    var didSetSliderScoreInCurrentExercise: Bool = false
    
    var personality: Personality = Personality()
    
    var audioGuide: URL? {
        get {
            if isInDemoMode {
                return personality.emotionalState == .negative && currentExercise.audioGuide?.negative != nil ? currentExercise.audioGuide?.negative : currentExercise.audioGuide?.positive
            } else {
                return personality.emotionalState == .negative && currentExercise.audioGuide?.negative != nil ? currentExercise.audioGuide?.negativeShort : currentExercise.audioGuide?.positiveShort
            }

        }
    }
    
    
    private lazy var navContainer: UIView = {
        return Container()
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(K.uikit.backButton, for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var navTitle: UILabel = {
        let label = UILabel()
        label.text = "Практика"
        label.textAlignment = .left
        label.textColor = K.colors.appText
        label.font = FontTypes.shared.h2
        return label
    }()
    
    private lazy var demoModeContainer: UIView = {
        return Container()
    }()
    
    private lazy var demoBorder: UIImageView = {
        let view = UIImageView()
        view.image = K.uikit.demobar
        return view
    }()
    
    private lazy var demoLabel: UILabel = {
        let label = UILabel()
        label.text = "Деморежим"
        label.textAlignment = .left
        label.textColor = K.colors.appText
        label.font = FontTypes.shared.h2
        return label
    }()
    
    private lazy var demoSwitch: UISwitch = {
        let handle = UISwitch()
        handle.onTintColor = K.colors.appBlue
        handle.isOn = true
        handle.transform = CGAffineTransform(scaleX: 0.66, y: 0.66)
        handle.addTarget(self, action: #selector(demoSwitchTapped(uiswitch:)), for: .touchUpInside)
        return handle
    }()
    
    private lazy var exerciseView: ExerciseView = {
        let view = ExerciseView()
        view.titleLabel.text = "1. Lorem ipsum dolor sit amet"
        view.descriptionLabel.text = "Lorem ipsum dolor sit amet"
        return view
    }()
    
    private lazy var audioGuideBar: UIView = {
        let view = UIView()
        view.backgroundColor = K.colors.appOffWhite
        view.roundCorners(.topCorners, radius: (22 * 1.05) * heightModifier)
        return view
    }()
    
    private lazy var audioGuideBarTrigger: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.clear, for: .normal)
        button.setTitle(nil, for: .normal)
        
        button.addTarget(self, action: #selector(audioBarPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var audioGuideTitle: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        label.numberOfLines = 2
        label.minimumScaleFactor = 10
        label.textColor = K.colors.appText
        label.textAlignment = .left
        label.text = "Lesson 1"
        return label
    }()
    
    private lazy var audioControlsSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    
    private lazy var playPauseButton: MediaButton = {
        let button = MediaButton()
        button.setImage(UIImage(named: "play-clear")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = K.colors.appBlue
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-forward")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = K.colors.appBlue
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(goForwardButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var goBackwardsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-backwards")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(goBackwardsButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .darkGray
        label.roundCorners(.allCorners, radius: label.topInset * 1.3)
        label.font = FontTypes.shared.ubuntu.withSize(14 * heightModifier)
        label.topInset = label.font.pointSize
        label.bottomInset = label.font.pointSize
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var swipeLeftGR: UISwipeGestureRecognizer = {
        let gr = UISwipeGestureRecognizer()
        gr.cancelsTouchesInView = false
        gr.direction = .left
        gr.delegate = self
        gr.addTarget(self, action: #selector(handleLeftSwipe(_:)))
        return gr
    }()
    
    private lazy var swipeRightGR: UISwipeGestureRecognizer = {
        let gr = UISwipeGestureRecognizer()
        gr.cancelsTouchesInView = false
        gr.direction = .right
        gr.delegate = self
        gr.addTarget(self, action: #selector(handleRightSwipe(_:)))
        return gr
    }()
    
    //MARK: - UI Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
        setUpObservers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
        setExercise(toExercise: exerciseModel.currentExercise)
    }
    
    private func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(backButton)
        navContainer.addSubview(navTitle)
        
        view.addSubview(demoModeContainer)
        demoModeContainer.addSubview(demoBorder)
        demoModeContainer.addSubview(demoLabel)
        demoModeContainer.addSubview(demoSwitch)
        
        view.addSubview(exerciseView)
        
        view.addSubview(audioGuideBar)
        audioGuideBar.addSubview(audioGuideBarTrigger)
        audioGuideBar.addSubview(audioGuideTitle)
        audioGuideBar.addSubview(audioControlsSV)
        
        audioControlsSV.addArrangedSubview(goBackwardsButton)
        audioControlsSV.addArrangedSubview(playPauseButton)
        audioControlsSV.addArrangedSubview(goForwardButton)
        
        view.addGestureRecognizer(swipeLeftGR)
        view.addGestureRecognizer(swipeRightGR)
        
    }
    
    private func setConstraints() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(64 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.height.equalTo(20 * heightModifier)
            make.width.equalTo(12 * heightModifier)
        }
        
        navTitle.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(24 * widthModifier)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview().offset(2 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        demoModeContainer.snp.makeConstraints { make in
            make.top.equalTo(navContainer.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(navContainer.snp.height)
            make.centerX.equalToSuperview()
        }
        
        demoBorder.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(28)
            make.height.equalToSuperview().multipliedBy(0.90)
        }
        
        demoLabel.snp.makeConstraints { make in
            make.left.equalTo(demoBorder.snp.left).offset(24 * widthModifier)
            make.height.equalTo(demoBorder.snp.height).multipliedBy(0.85)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33)
        }
        
        demoSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(2 * heightModifier)
            make.right.equalTo(demoBorder.snp.right)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        exerciseView.snp.makeConstraints { make in
            make.top.equalTo(demoModeContainer.snp.bottom).offset(16 * heightModifier)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
            make.bottom.equalToSuperview().offset(view.safeAreaSize(from: .bottom))
        }
        
        for view in exerciseView.scrollView.subviews {
            view.snp.makeConstraints { make in
                make.width.equalTo(exerciseView)
            }
        }
        
        audioGuideBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(105 * heightModifier)
        }
        
        audioGuideBarTrigger.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        audioGuideTitle.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.centerY.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom).percentage(50)))
        }
        
        audioControlsSV.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.55)
            make.right.equalToSuperview().offset(-36 * widthModifier)
            make.centerY.equalToSuperview().offset(-view.safeAreaSize(from: .bottom).percentage(50))
        }
        
        goBackwardsButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        goForwardButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
    }
    
    func presentErrorToast(message: String, fadeOutAfter: Double? = nil) {
        
        Vibration.error.vibrate()
        
        view.addSubview(errorLabel)
        errorLabel.text = message
        errorLabel.alpha = 1
        
        errorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(audioGuideBar.snp.top).offset(-16 * heightModifier)
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
        }
        
        //if no specified fade out time - calculate fadeout time depending on average wpm (333) reading speed + 1 second until user sees message.
        let fadeoutTime: Double = fadeOutAfter ?? Double(message.wordCount() / 6) + 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeoutTime) {
            UIView.animate(withDuration: 0.3) {
                self.errorLabel.alpha = 0
            } completion: { success in
                self.errorLabel.removeFromSuperview()
            }
        }
    }
    
    //MARK: - Exercise Logic Methods
    
    func setExercise(toExercise index: Int) {
        //select the new exercise with index from the exercise list
        let newExercise = exerciseModel.dataBase[index]
        
        //set new exercise internal boolean value to selected 
        exerciseModel.deselectAllExercises()
        newExercise.isCurrentlySelected = true
        
        //set title and descriptions
        exerciseView.titleLabel.text = "\(index + 1). \(newExercise.title)"
        audioGuideTitle.text = newExercise.title
        //attributed description formats the text design and also selects the positive or negative descriptions according to
        //the user's emotional state.
        exerciseView.descriptionLabel.attributedText = attributedDescription(of: newExercise, isDemo: demoSwitch.isOn)
        
        //if animation is present in exercise, we set it to the default height specified in the exerciseView class.
        //if it is not present, we set the height to 0 and hide it from the VC
        if newExercise.isAnimationPresent && newExercise.animationURLName != nil {
            //here we set the animation that we want to show
            exerciseView.accessoryAnimation.animate(withGIFNamed: newExercise.animationURLName!)
            exerciseView.accessoryAnimation.isHidden = false
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .expanded, with: exerciseView.defaultAnimationHeight)
        } else {
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .collapsed)
            exerciseView.accessoryAnimation.isHidden = true
            exerciseView.accessoryAnimation.stopAnimating()
        }
        
        //same for the slider.
        if newExercise.isSliderPresent {
            exerciseView.changeviewState(of: exerciseView.accessorySlider, to: .expanded, with: exerciseView.defaultSliderHeight)
            exerciseView.accessorySlider.isHidden = false
            exerciseView.accessorySlider.value = 0
            
            //by default we set the slider back to 0 for next times, but to we also want to remember user input
            //in past exercises. so - if we have data for an emotional score in the current exercise, we set it to the slider.
            if let scoreIndex = newExercise.scoreIndex {
                if let emotionalScore = personality.practiceScores[scoreIndex] {
                    exerciseView.accessorySlider.value = Float(emotionalScore)
                }
            }
        } else {
            exerciseView.changeviewState(of: exerciseView.accessorySlider, to: .collapsed)
            exerciseView.accessorySlider.isHidden = true
        }
        
        //set audio guide here
        
        AudioManager.shared.insert(audio: audioGuide)
        
        exerciseView.layoutSubviews()
    }
    
    func applyDemoMode(isActive demo: Bool) {
        if demo {
            if exerciseModel.dataBase[exerciseModel.currentExercise].isAnimationPresent {
                exerciseView.accessoryAnimation.animate(withGIFNamed: exerciseModel.dataBase[exerciseModel.currentExercise].animationURLName!)
                exerciseView.accessoryAnimation.isHidden = false
                exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .expanded, with: exerciseView.defaultAnimationHeight)
            }
        } else {
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .collapsed)
            exerciseView.accessoryAnimation.isHidden = true
            exerciseView.accessoryAnimation.stopAnimating()
        }
        
        exerciseView.descriptionLabel.attributedText = attributedDescription(of: exerciseModel.dataBase[exerciseModel.currentExercise], isDemo: demo)
    }
    
    func setNextExercise() {
        guard exerciseModel.currentExercise < exerciseModel.dataBase.count - 1 else { return }
        
        if AudioManager.shared.playbackState == .playing {
            AudioManager.shared.stopAudio()
        }
        
        exerciseModel.currentExercise += 1
        setExercise(toExercise: exerciseModel.currentExercise)
        
        //if errorlabel is still shown when user fixes first slider score - hide it immediately
        errorLabel.alpha = 0
    }
    
    func nextExerciseLogic() {
        
        if let scoreIndex = exerciseModel.dataBase[exerciseModel.currentExercise].scoreIndex {
            //if current exercise has slider and user did not set any value, add 0 to the scores array.
            if exerciseModel.dataBase[exerciseModel.currentExercise].isSliderPresent && personality.practiceScores[scoreIndex] == nil {
                
                //if were on 2nd or 3rd slider - set score according to last score. if were on first slider - set 0
                let scoreToSet = scoreIndex > 0 ? personality.practiceScores[scoreIndex - 1] : 0
                personality.practiceScores[scoreIndex] = scoreToSet
            }
        }
        
        //dont let user do the practice if he's in a relatively calm state.
        if let firstScore = personality.practiceScores[0] {
            if firstScore == 0 {
                presentErrorToast(message: "It seems that you are not in such a bad mood, as your score is 0. try using this section when you feel stressed")
                return
            }
        }
        
        if exerciseModel.currentExercise < exerciseModel.dataBase.count - 1 {
            //move to next exercise
            setNextExercise()
            self.exerciseView.scrollView.setContentOffset(.zero, animated: true)
            //reset did set slider score bool value
            didSetSliderScoreInCurrentExercise = false
            
        } else /* If it is the last exercise - show success or fail according to scores */{
                        
            let firstScore = personality.practiceScores.first
            let lastScore = personality.practiceScores.last
            
            if let finishCondition = checkForFinishCondition(with: personality.practiceScores) {
                if isFinishWithSuccess(with: finishCondition) {
                    self.navigationController?.pushViewController(SuccessViewController(success: finishCondition, first: firstScore ?? nil, lastScore: lastScore ?? nil), animated: true)
                } else {
                    self.navigationController?.pushViewController(FailViewController(fail: finishCondition), animated: true)
                }
            } else {
                print("couldnt get finish condition, try checking scores array.")
                textLog.write("couldnt get finish condition, try checking scores array.")
            }
            print("scores:", personality.practiceScores)
            textLog.write("scores: \(personality.practiceScores)")
        }
    }
    
    func rewindExerciseLogic() {
        
        
        let isPlayerInitiallyPaused = AudioManager.shared.playbackState == .paused || AudioManager.shared.playbackState == .ready ? true : false
        
        if AudioManager.shared.playerTime() < 2 && exerciseModel.currentExercise > 0 {
            
            if AudioManager.shared.playbackState == .playing {
                AudioManager.shared.stopAudio()
            }
            
            exerciseModel.currentExercise -= 1
            setExercise(toExercise: exerciseModel.currentExercise)
            
        } else if AudioManager.shared.playerTime() < 2 && exerciseModel.currentExercise == 0 {
             leavePractice()
             return
        } else {
            AudioManager.shared.rewindAudio()
        }
        
        if !isPlayerInitiallyPaused { AudioManager.shared.playAudio() }
    }
    
    
    func leavePractice() {
        AudioManager.shared.stopAudio()
        AudioManager.shared.stopAudioEngine()
        AudioManager.shared.invalidatePlayer()
        SpeechRecognitionManager.main.invalidate()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkForFinishCondition(with scores: [Int?]) -> FinishCondition? {
        if scores.contains(where: {$0 == nil}) { return nil }

        let firstScore: Int = scores.first!!
        let lastScore: Int = scores.last!!
        
        if firstScore.isNegative() && lastScore.isPositive() && lastScore > 4 { return .warningBecamePositive }
        else if firstScore.isPositive() && lastScore.isNegative() && lastScore < -4 { return .warningBecameNegative }
        else if firstScore.isNegative() && lastScore.isPositive() && lastScore <= 4 { return .successBecamePositive }
        else if firstScore.isPositive() && lastScore.isNegative() && lastScore >= -4 { return .successBecameNegative }
        else if lastScore * firstScore > 0 && lastScore.positiveValue() - firstScore.positiveValue() > 1 { return .failDidNotHelp }
        else { return .success }
        
    }
    
    func isFinishWithSuccess(with finishCondition: FinishCondition) -> Bool {
        if finishCondition == .success || finishCondition == .successBecameNegative || finishCondition == .successBecamePositive {
            return true
        } else {
            return false
        }
    }
    
    func attributedDescription(of exercise: Exercise, isDemo: Bool) -> NSAttributedString {
        //for layout convenience reasons - the description text will be designed in a single label with attributes.
        //this method returns the attributed text description according to if the demo label is on or not.
        //if demo mode is on, the text will be title + shortDesc + title + longDesc. if not - the text will only be shortDesc.
        //create attributes for headings and paragraph
        let headingAttr: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : FontTypes.shared.h3.withSize(24), NSAttributedString.Key.foregroundColor : K.colors.appRed ?? .red]
        let paragraphAttr: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : FontTypes.shared.ubuntu.withSize(16), NSAttributedString.Key.foregroundColor : K.colors.appText ?? .darkGray]
        
        let formattedLongDescription = NSMutableAttributedString()
        
        if let what = (personality.emotionalState == .negative && exercise.theWhatNegative != nil) ? exercise.theWhatNegative : exercise.theWhat,
           let why = (personality.emotionalState == .negative && exercise.theWhyNegative != nil) ? exercise.theWhyNegative : exercise.theWhy {
            
            let shortDescTitle = NSMutableAttributedString(string: "Как?\n\n", attributes: headingAttr)
            let shortDesctAttributed = NSMutableAttributedString(string: "\(what)\n", attributes: paragraphAttr)
            let longDescTitle = NSMutableAttributedString(string: "\nПочему?\n\n", attributes: headingAttr)
            let descriptionAttributed = NSMutableAttributedString(string: why, attributes: paragraphAttr)
            
            if isDemo {
                formattedLongDescription.append(shortDescTitle)
                formattedLongDescription.append(shortDesctAttributed)
                formattedLongDescription.append(longDescTitle)
                formattedLongDescription.append(descriptionAttributed)
            } else {
                formattedLongDescription.append(shortDesctAttributed)
            }
            
        }
        
        return formattedLongDescription
    }
    
    //MARK: - Button/GR Targets & Selectors
    
    @objc func backButtonPressed() {
        
        if exerciseModel.currentExercise > 0 {
            let alertTitle = "Вы уверены, что хотите выйти?"
            let exitAction = UIAlertAction(title: "Да", style: .destructive) { action in
                self.leavePractice()
            }
            let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
            let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
            alert.addAction(cancelAction)
            alert.addAction(exitAction)
            
            present(alert, animated: true)
        } else {
            leavePractice()
        }
    

    }
    
    @objc func demoSwitchTapped(uiswitch: UISwitch) {
        applyDemoMode(isActive: uiswitch.isOn)
    }
    
    @objc func audioBarPressed() { 
        let destination = ExerciseQueueController()
        destination.modalPresentationStyle = .popover
        destination.exerciseModel = exerciseModel
        destination.personality = self.personality
        destination.delegate = self
        
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func goBackwardsButtonPressed() {
        
        rewindExerciseLogic()
    }
    
    @objc func playPauseButtonPressed(_ button: MediaButton) {
        
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
        
    }
    
    @objc func goForwardButtonPressed() {
        nextExerciseLogic()
        
    }
    
    @objc func handleLeftSwipe(_ gr: UISwipeGestureRecognizer) {
        if gr.state == .ended && gr.state != .cancelled {
            Vibration.soft.vibrate()
            nextExerciseLogic()
        }
    }
    
    @objc func handleRightSwipe(_ gr: UISwipeGestureRecognizer) {
        if gr.state == .ended && gr.state != .cancelled {
            Vibration.soft.vibrate()
            rewindExerciseLogic()
        }
    }
    
    //MARK: - Communication methods
    
    private func setUpObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlaybackStateChange), name: NSNotification.Name.audioManagerStateDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSpeechRecognitionTrigger(_:)), name: NSNotification.Name.SpeechRecognizerDidMatchTrigger, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleExerciseSliderValueChange), name: NSNotification.Name.exerciseSliderValueHasChanged, object: nil)
        
    }
    
    @objc private func handlePlaybackStateChange() {
        self.playPauseButton.playbackState = AudioManager.shared.playbackState
        
        //start listening to keywaords that will change current exercise (ie "next"/"rewind"/etc)
        if AudioManager.shared.playbackState == .finished {

            AudioManager.shared.prepareAudioEngine {

                AudioManager.shared.startAudioEngine()
            }
        }
    }
    
    @objc private func handleAudioBuffer(_ notification: NSNotification) {
        //handle spoken words with speech recognizer
        if let buffer = notification.userInfo?["buffer"] as? AVAudioPCMBuffer {
            if !SpeechRecognitionManager.main.isRecognizerActive {
                SpeechRecognitionManager.main.initiate(language: .russian) { success in
                    if success {
                        SpeechRecognitionManager.main.listen(to: buffer)
                    }
                }
            }

            SpeechRecognitionManager.main.recognitionRequest?.append(buffer)
        }
    }

    
    @objc private func handleSpeechRecognitionTrigger(_ notification: NSNotification) {
        guard let action = notification.userInfo?["action"] as? TriggerWordType else { textLog.write("unexpectedly received nil as speech recognition trigger"); return }
        print("received SR Trigger: \(action)")
        Vibration.light.vibrate()
        if action == .next { self.nextExerciseLogic() } else
        if action == .rewind { AudioManager.shared.rewindAudio() }
    }
    
    @objc private func handleExerciseSliderValueChange(_ notification: NSNotification) {
        if let score = notification.userInfo?["value"] as? Float {
            
            switch exerciseModel.currentExercise {
            case 1:
                personality.practiceScores[0] = Int(score)
            case 8:
                personality.practiceScores[1] = Int(score)
            case 15:
                personality.practiceScores[2] = Int(score)
            default:
                textLog.write("\(score), couldn't set score from value - slider isn't on correct exercise.")
                
            }
            
            switch Int(score) {
            case 1...:
                personality.emotionalState = .positive
            case 0:
                personality.emotionalState = .neutral
            case ...(-1):
                personality.emotionalState = .negative
            default:
                personality.emotionalState = .neutral
            }
            
            didSetSliderScoreInCurrentExercise = true
        }
    }
    
    //MARK: - deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.exerciseView.accessoryAnimation.image = nil
        
        self.exerciseView.removeFromSuperview()
    }
}

extension PracticeViewController: ExerciseSelectorDelegate {
    
    func set(exerciseTo index: Int) {
        setExercise(toExercise: index)
    }
    
}

extension PracticeViewController: UIGestureRecognizerDelegate {
    //swipes coming from uisliders will be ignored in Swipe Gesture Recognizers.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let gestureSender = touch.view {
            if gestureSender.isKind(of: UISlider.self) {
                return false
            }
        }
        return true
    }
}


