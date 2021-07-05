//
//  PracticeViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit

class PracticeViewController: UIViewController {
    
    var exerciseModel: ExerciseModel = ExerciseModel()
    
//    override var prefersHomeIndicatorAutoHidden: Bool {
//        return true
//    }
    
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
        view.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. "
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
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-clear")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-forward")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
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
    
    //MARK: - UI Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
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
    
    //MARK: - Exercise Logic Methods
    
    func setExercise(toExercise index: Int) {
        //select the new exercise with index from the exercise list
        let newExercise = exerciseModel.dataBase[index]
        
        //set title and descriptions
        exerciseView.titleLabel.text = "\(index + 1). \(newExercise.title)"
        audioGuideTitle.text = newExercise.title
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
        } else {
            exerciseView.changeviewState(of: exerciseView.accessorySlider, to: .collapsed)
            exerciseView.accessorySlider.isHidden = true
        }
        
        //set audio guide here
        
        exerciseView.layoutSubviews()
    }
    
    func applyDemoMode(isActive demo: Bool) {
        if demo {
            exerciseView.accessoryAnimation.animate(withGIFNamed: exerciseModel.dataBase[exerciseModel.currentExercise].animationURLName!)
            exerciseView.accessoryAnimation.isHidden = false
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .expanded, with: exerciseView.defaultAnimationHeight)
        } else {
            exerciseView.changeviewState(of: exerciseView.accessoryAnimation, to: .collapsed)
            exerciseView.accessoryAnimation.isHidden = true
            exerciseView.accessoryAnimation.stopAnimating()
        }

        exerciseView.descriptionLabel.attributedText = attributedDescription(of: exerciseModel.dataBase[exerciseModel.currentExercise], isDemo: demo)
    }
    
    func attributedDescription(of exercise: Exercise, isDemo: Bool) -> NSAttributedString {
        //for layout convenience reasons - the description text will be designed in a single label with attributes.
        //this method return the attributed text description according to if the demo label is on or not.
        //if demo mode is on, the text will be title + shortDesc + title + longDesc. if not - the text will only be shortDesc.
        //create attributes for headings and paragraph
        let headingAttr: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : FontTypes.shared.h3.withSize(24), NSAttributedString.Key.foregroundColor : K.colors.appRed ?? .red]
        let paragraphAttr: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font : FontTypes.shared.ubuntu.withSize(16), NSAttributedString.Key.foregroundColor : K.colors.appText ?? .darkGray]
        
        let formattedLongDescription = NSMutableAttributedString()
        
        let shortDescTitle = NSMutableAttributedString(string: "The What\n\n", attributes: headingAttr)
        let shortDesctAttributed = NSMutableAttributedString(string: "\(exercise.shortDescription)\n", attributes: paragraphAttr)
        let longDescTitle = NSMutableAttributedString(string: "\nThe Why\n\n", attributes: headingAttr)
        let descriptionAttributed = NSMutableAttributedString(string: exercise.description, attributes: paragraphAttr)
        
        if isDemo {
            formattedLongDescription.append(shortDescTitle)
            formattedLongDescription.append(shortDesctAttributed)
            formattedLongDescription.append(longDescTitle)
            formattedLongDescription.append(descriptionAttributed)
        } else {
            formattedLongDescription.append(shortDesctAttributed)
        }
        
        return formattedLongDescription
    }
    
    //MARK: - Targets & Selectors
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func demoSwitchTapped(uiswitch: UISwitch) {
        applyDemoMode(isActive: uiswitch.isOn)
    }
    
    @objc func audioBarPressed() { 
        let destination = ExerciseQueueController()
        destination.modalPresentationStyle = .popover
        destination.exerciseModel = exerciseModel
        //self.navigationController?.pushViewController(destination, animated: false)
        self.present(destination, animated: true, completion: nil)
    }
    
    @objc func goBackwardsButtonPressed() {
        exerciseModel.currentExercise -= 1
        setExercise(toExercise: exerciseModel.currentExercise)
    }
    
    @objc func goForwardButtonPressed() {
        exerciseModel.currentExercise += 1
        setExercise(toExercise: exerciseModel.currentExercise)
    }
    
}
