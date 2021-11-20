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

protocol PracticeControllerDelegate {
    func DidChangeExerciseTo(exercise: Int)
}

class PracticeViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    let def = UserDefaults.standard
    
    var delegate: PracticeControllerDelegate?
    
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
    
    var isOnLastExercise: Bool {
        get {
            return exerciseModel.currentExercise < exerciseModel.dataBase.count - 1 ? false : true
        }
    }
    
    var didSetSliderScoreInCurrentExercise: Bool = false
    
    var personality: Personality = Personality()
    
    var mainAudioGuide: URL? {
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
        handle.isOn = def.bool(forKey: K.def.isDemoPreffered) ? true : false
        handle.transform = CGAffineTransform(scaleX: 0.66, y: 0.66)
        handle.addTarget(self, action: #selector(demoSwitchTapped(uiswitch:)), for: .touchUpInside)
        return handle
    }()
    
    lazy var exerciseView: ExerciseView = {
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
        button.addTarget(self, action: #selector(audioBarPressed), for: .touchDragExit)
        return button
    }()
    
    private lazy var audioGuideBarArrow: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(systemName: "chevron.compact.up")
        view.tintColor = .lightGray
        return view
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
    
    private lazy var finishButton: UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md"), for: .normal)
        
        button.setTitle("Завершить сессию", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(.white, for: .normal)
        
        button.isHidden = true
        
        button.addTarget(self, action: #selector(finishButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.backgroundColor = .darkGray
        label.roundCorners(.allCorners, radius: label.topInset * 1.66)
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
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SpeechRecognitionManager.main.delegate = self
        
        //remove recommendationVC from stack in first launch, so when back button is pressed you go back to rootVC. also saves some memory.
        if let nc = self.navigationController {
            for vc in nc.viewControllers {
                if vc is RecommendationViewController {
                    vc.removeFromParent()
                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UIApplication.shared.isIdleTimerDisabled = false
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
        audioGuideBar.addSubview(audioGuideBarArrow)
        audioGuideBar.addSubview(audioGuideTitle)
        audioGuideBar.addSubview(audioControlsSV)
        
        audioControlsSV.addArrangedSubview(goBackwardsButton)
        audioControlsSV.addArrangedSubview(playPauseButton)
        audioControlsSV.addArrangedSubview(goForwardButton)
        
        view.addSubview(finishButton)
        
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
        
        audioGuideBarArrow.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(8 * heightModifier)
            make.width.equalTo(24 * heightModifier)
            make.top.equalToSuperview().offset(8 * heightModifier)
        }
        
        audioGuideTitle.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.centerY.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom).percentage(50)) + 6)
        }
        
        audioControlsSV.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.55)
            make.right.equalToSuperview().offset(-36 * widthModifier)
            make.centerY.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom).percentage(50)) + 6)
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
        
        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(playPauseButton.snp.top).offset(-32 * heightModifier)
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.right.equalToSuperview().offset(-28 * widthModifier)
            make.height.equalTo(56 * heightModifier)
        }
        
    }
    
    func presentErrorToast(message: String, fadeOutAfter: Double? = nil) {
        
        Vibration.error.vibrate()
        
        view.addSubview(errorLabel)
        errorLabel.text = message
        errorLabel.alpha = 1
        
        errorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(audioGuideBar.snp.top).offset(-16 * heightModifier)
            make.left.equalToSuperview().offset(36 * widthModifier)
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
        
        exerciseView.accessoryAnimation.prepareForReuse()
        
        //if animation is present in exercise, we set it to the default height specified in the exerciseView class.
        //if it is not present, we set the height to 0 and hide it from the VC
        if newExercise.isAnimationPresent && newExercise.animationURLName != nil {
            //here we set the animation that we want to show
            exerciseView.accessoryAnimation.image = (UIImage(named: newExercise.animationURLName!))
            exerciseView.accessoryAnimation.animate(withGIFNamed: newExercise.animationURLName!)
            
            if isInDemoMode {
                exerciseView.accessoryAnimation.isHidden = false
            }
            
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .expanded, with: exerciseView.defaultAnimationHeight)
        } else {
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .collapsed)
            exerciseView.accessoryAnimation.isHidden = true
            exerciseView.accessoryAnimation.stopAnimating()
        }
        
        //set title and descriptions
        exerciseView.titleLabel.text = "\(index + 1). \(newExercise.title)"
        audioGuideTitle.text = newExercise.title
        //attributed description formats the text design and also selects the positive or negative descriptions according to
        //the user's emotional state.
        exerciseView.descriptionLabel.attributedText = attributedDescription(of: newExercise, isDemo: demoSwitch.isOn)
        
        //same for the slider.
        if newExercise.isSliderPresent {
            exerciseView.changeviewState(of: exerciseView.accessorySlider, to: .expanded, with: exerciseView.defaultSliderHeight)
            exerciseView.accessorySlider.isHidden = false
            exerciseView.accessorySlider.value = 0
            exerciseView.accessorySlider.handleValueChange()
            exerciseView.accessoryContainer.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 64, leading: 0, bottom: 0, trailing: 0)
            //by default we set the slider back to 0 for next times, but to we also want to remember user input
            //in past exercises. so - if we have data for an emotional score in the current exercise, we set it to the slider.
            if let scoreIndex = newExercise.scoreIndex {
                if let emotionalScore = personality.practiceScores[scoreIndex] {
                    exerciseView.accessorySlider.value = Float(emotionalScore)
                    print(personality.practiceScores)
                }
            }
    
        } else {
            exerciseView.changeviewState(of: exerciseView.accessorySlider, to: .collapsed)
            exerciseView.accessorySlider.isHidden = true
            exerciseView.accessoryContainer.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        }
        
        //set audio guide here
        
        AudioManager.shared.insert(audio: mainAudioGuide)
        
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
    
    func nextExerciseLogic(wasTriggeredBySpeech: Bool = false) {
        print("nextExerciseLogic called")
        if let scoreIndex = exerciseModel.dataBase[exerciseModel.currentExercise].scoreIndex {
            //if current exercise has slider and user did not set any value, add 0 to the scores array.
            if exerciseModel.dataBase[exerciseModel.currentExercise].isSliderPresent && personality.practiceScores[scoreIndex] == nil {
                
                //if were on 2nd or 3rd slider - set score according to last score. if were on first slider - set 0
                let scoreToSet = 0 //scoreIndex > 0 ? personality.practiceScores[scoreIndex - 1] : 0
                personality.practiceScores[scoreIndex] = scoreToSet
            }
        }
        
        //dont let user do the practice if he's in a relatively calm state.
        if let firstScore = personality.practiceScores[0] {
            if firstScore == 0 {
                presentErrorToast(message: "Кажется, вы сейчас не испытываете стресса и вам вряд ли потребуется помощь. Возвращайтесь, если что-то действительно пойдет не так")
                return
            }
        }
        
        if exerciseModel.currentExercise < exerciseModel.dataBase.count - 1 {
            //move to next exercise
            setNextExercise()
            delegate?.DidChangeExerciseTo(exercise: exerciseModel.currentExercise)
            
            //only autoplay guides if proceeded by speech
            if wasTriggeredBySpeech {
                AudioManager.shared.playAudio()
            }
            
            //reset current part index to 0 for next custom logic
            currentExercise.audioGuide?.currentPartIndex = 0
            
            self.exerciseView.scrollView.setContentOffset(.zero, animated: true)
            //reset did set slider score bool value
            
            if !exerciseView.accessorySlider.isHidden {
                didSetSliderScoreInCurrentExercise = false
            }
            
            
        } else /* If it is the last exercise - show success or fail according to scores */{
            
            finishPracticeLogic()
        }
        
        finishButton.isHidden = isOnLastExercise ? false : true
        
        if !finishButton.isHidden {
            exerciseView.snp.remakeConstraints { make in
                make.top.equalTo(demoModeContainer.snp.bottom).offset(16 * heightModifier)
                make.left.equalToSuperview().offset(36)
                make.right.equalToSuperview().offset(-36)
                make.bottom.equalTo(finishButton.snp.top).offset(-8 * heightModifier)
            }
        } else {
            exerciseView.snp.remakeConstraints { make in
                make.top.equalTo(demoModeContainer.snp.bottom).offset(16 * heightModifier)
                make.left.equalToSuperview().offset(36)
                make.right.equalToSuperview().offset(-36)
                make.bottom.equalToSuperview().offset(view.safeAreaSize(from: .bottom))
            }
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
        
        finishButton.isHidden = isOnLastExercise ? false : true
        
        if !finishButton.isHidden {
            exerciseView.snp.remakeConstraints { make in
                make.top.equalTo(demoModeContainer.snp.bottom).offset(16 * heightModifier)
                make.left.equalToSuperview().offset(36)
                make.right.equalToSuperview().offset(-36)
                make.bottom.equalTo(finishButton.snp.top).offset(-8 * heightModifier)
            }
        } else {
            exerciseView.snp.remakeConstraints { make in
                make.top.equalTo(demoModeContainer.snp.bottom).offset(16 * heightModifier)
                make.left.equalToSuperview().offset(36)
                make.right.equalToSuperview().offset(-36)
                make.bottom.equalToSuperview().offset(view.safeAreaSize(from: .bottom))
            }
        }
    }
    
    func setNextAudioGuidePartAccordingTo(trigger: TriggerWordType, inExercise exercise: Int) {
        guard currentExercise.audioGuide != nil else { return }
        guard currentExercise.audioGuide!.hasAdditionalParts else { textLog.write("other part is not available for audio guide"); return }
        print("set next audio guide part called")
        let currentAudioGuidePart = currentExercise.audioGuide!.currentPartIndex
        var partToPlay: URL?
        
        if exercise == 10 {
            if trigger == .next {
                print(currentExercise.audioGuide!.isNextPartAvailable)
                if currentExercise.audioGuide!.isNextPartAvailable {
                    partToPlay = currentExercise.audioGuide!.nextPart()
                } else {
                    self.nextExerciseLogic(wasTriggeredBySpeech: true)
                    return
                }
            }
        } else if exercise == 11 {
            switch currentAudioGuidePart {
            case 0:
                if trigger == .yes { partToPlay = currentExercise.audioGuide!.part(1)}
                if trigger == .no { partToPlay = currentExercise.audioGuide!.part(2)}
            case 1:
                if trigger == .next { self.nextExerciseLogic(); return }
                if trigger == .rewind { partToPlay = mainAudioGuide; currentExercise.audioGuide!.currentPartIndex = 0 }
            case 2:
                if trigger == .next { partToPlay = currentExercise.audioGuide!.part(3) }
            case 3:
                if trigger == .yes { partToPlay = currentExercise.audioGuide!.part(5)}
                if trigger == .no { partToPlay = currentExercise.audioGuide!.part(4)}
            case 4:
                if trigger == .next { self.nextExerciseLogic(); return }
                if trigger == .rewind { partToPlay = mainAudioGuide; currentExercise.audioGuide!.currentPartIndex = 0 }
            case 5:
                if trigger == .next { partToPlay = currentExercise.audioGuide!.part(6) }
            case 6:
                if trigger == .next { self.nextExerciseLogic(); return }
                if trigger == .rewind { partToPlay = mainAudioGuide; currentExercise.audioGuide!.currentPartIndex = 0 }
            
            default:
                textLog.write("action not defined for current audio guide part")
            }
        } else if exercise == 13 {
            switch currentAudioGuidePart {
            case 0:
                if trigger == .next { partToPlay = currentExercise.audioGuide!.part(1) }
            case 1:
                if trigger == .next { self.nextExerciseLogic(); return }
                if trigger == .rewind { partToPlay = mainAudioGuide; currentExercise.audioGuide!.currentPartIndex = 0 }
            default:
                textLog.write("action not defined for current audio guide part")
            }
        } else if exercise == 14 {
            switch currentAudioGuidePart {
            case 0:
                if trigger == .yes { partToPlay = currentExercise.audioGuide!.part(1) }
                if trigger == .no { partToPlay = currentExercise.audioGuide!.part(2) }
            case 1...2:
                if trigger == .next { self.nextExerciseLogic(); return }
                if trigger == .rewind { partToPlay = mainAudioGuide; currentExercise.audioGuide!.currentPartIndex = 0 }
            default:
                textLog.write("action not defined for current audio guide part")
            }
        } else {
            textLog.write("action not defined for current exercise")
        }
        
        if partToPlay != nil {
            AudioManager.shared.insert(audio: partToPlay) {
                print("aaa")
                AudioManager.shared.playAudio()
            }
        } else {
            textLog.write("could not play designated part: is set to nil.\ncurrent exercise: \(exerciseModel.currentExercise), trigger found: \(trigger), current audio guide part: \(currentAudioGuidePart)")
        }
    }
    
    private func finishPracticeLogic() {
        if Int(exerciseView.accessorySlider.value) == 0 {
            personality.practiceScores[2] = 0
        }
        
        print("last score is: ", personality.practiceScores[2] as Any)
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
        else if lastScore * firstScore > 0 && lastScore.positiveValue() - firstScore.positiveValue() >= 0 { return .failDidNotHelp }
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
            
            let whyTitle = NSMutableAttributedString(string: "Как это работает?\n\n", attributes: headingAttr)
            let whyDescription = NSMutableAttributedString(string: why, attributes: paragraphAttr)
            let whatTitle = NSMutableAttributedString(string: "\n\nЧто нужно делать?\n\n", attributes: headingAttr)
            let whatDescription = NSMutableAttributedString(string: "\(what)\n", attributes: paragraphAttr)
           
            if isDemo {
                if why != "" {
                    formattedLongDescription.append(whyTitle)
                    formattedLongDescription.append(whyDescription)
                }
                
                formattedLongDescription.append(whatTitle)
                formattedLongDescription.append(whatDescription)
            } else {
                formattedLongDescription.append(whatDescription)
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
        def.set(uiswitch.isOn ? true : false, forKey: K.def.isDemoPreffered)
    }
    
    @objc func audioBarPressed() { 
        let destination = ExerciseQueueController()
        delegate = destination
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
            
            AudioManager.shared.insert(audio: mainAudioGuide) {
                print("bbb")
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
    
    @objc func finishButtonPressed(_ butotn: UIButton) {
        finishPracticeLogic()
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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleSpeechRecognitionTrigger(_:)), name: NSNotification.Name.SpeechRecognizerDidMatchTrigger, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleExerciseSliderValueChange), name: NSNotification.Name.exerciseSliderValueHasChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserReturnToApp), name: NSNotification.Name.ApplicationDidEnterForeground, object: nil)
        
    }
    
    @objc private func handleUserReturnToApp() {
        print("user returned")
        //fixes a weird bug where EASlider's min. track image would become plain white making the slider look dumb
        self.exerciseView.accessorySlider.setMinimumTrackImage(UIImage(named: "slider-track"), for: .normal)
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

    
//    @objc func handleSpeechRecognitionTrigger(_ notification: NSNotification) {
//        guard let action = notification.userInfo?["action"] as? TriggerWordType else { textLog.write("unexpectedly received nil as speech recognition trigger"); return }
//        print("received SR Trigger: \(action)")
//        print("current exercise: ", exerciseModel.currentExercise)
//        Vibration.light.vibrate()
//
//        if currentExercise.doesHaveSpecialLogic {
//            setNextAudioGuidePartAccordingTo(trigger: action, inExercise: exerciseModel.currentExercise)
//        } else {
//            if action == .next { self.nextExerciseLogic(wasTriggeredBySpeech: true) } else
//            if action == .rewind { AudioManager.shared.rewindAudio() }
//        }
//
//    }
    
    @objc private func handleExerciseSliderValueChange(_ notification: NSNotification) {
        guard !exerciseView.accessorySlider.isHidden else { return }
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

extension PracticeViewController: SpeechRecognitionTriggerDelegate {
    
    func didReceiveTrigger(ofType type: TriggerWordType) {
        print("received SR Trigger: \(type)")
        print("current exercise: ", exerciseModel.currentExercise)
        Vibration.light.vibrate()
        
        if currentExercise.doesHaveSpecialLogic {
            setNextAudioGuidePartAccordingTo(trigger: type, inExercise: exerciseModel.currentExercise)
        } else {
            if type == .next { self.nextExerciseLogic(wasTriggeredBySpeech: true) } else
            if type == .rewind { AudioManager.shared.rewindAudio(wasTriggeredBySpeech: true) }
        }
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


