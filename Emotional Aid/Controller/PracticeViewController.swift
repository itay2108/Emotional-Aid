//
//  PracticeViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit

class PracticeViewController: UIViewController {
    
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
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
        handle.isOn = false
        handle.transform = CGAffineTransform(scaleX: 0.66, y: 0.66)
        return handle
    }()
    
    private lazy var exerciseView: ExerciseView = {
        let view = ExerciseView()
        view.questionLabel.text = "1. Lorem ipsum dolor sit amet"
        view.descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. "
        return view
    }()
    
    
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
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
