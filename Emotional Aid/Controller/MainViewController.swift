//
//  ViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var didLogPermissionResults: Bool = false
    
    private lazy var navContainer:  UIView      = {
        return Container()
    }()
    
    private lazy var profileButton: UIButton    = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "profile-artwork"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var consultButton: UIButton    = {
        let button = UIButton()
        button.setTitle("Записаться на консультацию", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(UIImage(named: "button-md"), for: .normal)
        
        button.addTarget(self, action: #selector(consultButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoContainer: UIView      = {
        return Container()
    }()
    
    private lazy var logoView:      UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "logo")
        
        guard image != nil else { return UIImageView() }
        
        view.image = image
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainTitle:     UILabel     = {
       let title = UILabel()
        title.text = "Emotional\nAid"
        title.numberOfLines = 2
        title.textAlignment = .center
        title.textColor = K.colors.appText
        title.font = FontTypes.shared.h1.withSize(30)
        title.textSpacing(of: 5)
        return title
    }()
    
    private lazy var ctaContainer:  UIView      = {
       return Container()
    }()
    
    private lazy var sosButton:     UIButton    = {
       let button = SOSButton()
        button.setTitle("SOS", for: .normal)
        button.addTextSpacing(10.0)
        button.addTarget(self, action: #selector(sosButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var ctaTitle:      UILabel     = {
        let label = UILabel()
        label.text = "Начать практику"
        label.font = FontTypes.shared.ubuntuLight.withSize(18)
        label.textSpacing(of: 1)
        label.textAlignment = .center
        label.textColor = K.colors.appText
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        
        SpeechRecognitionManager.main.authorizeSpeechRecognition { success in
            if success { print("speech recognition authorized") }
        }
        
        AudioManager.shared.requestMicrophoneUsage { success in
            if success { print("microphone usage authorized") }
            else { print("microphone usage denied") }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setUpUI() {
        
        addSubviews()
        setConstraints()
        
    }

    private func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(profileButton)
        navContainer.addSubview(consultButton)
        
        view.addSubview(logoContainer)
        logoContainer.addSubview(logoView)
        logoContainer.addSubview(mainTitle)
        
        view.addSubview(ctaContainer)
        ctaContainer.addSubview(sosButton)
        ctaContainer.addSubview(ctaTitle)

    }
    
    private func setConstraints() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(84 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24 * widthModifier)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
            make.width.equalTo(navContainer.snp.height).multipliedBy(0.65)
        }
        
        consultButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30 * widthModifier)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.55)
            make.right.equalTo(profileButton.snp.left).offset(-20 * widthModifier)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
            make.centerX.equalToSuperview()
            make.top.equalTo(navContainer.snp.bottom).offset(36 * heightModifier)
        }
    
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalTo(logoView.snp.height)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4).offset(-16 * heightModifier)
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).offset(16 * heightModifier)
        }
        
        ctaContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-safeAreaSize(from: .bottom)).offset(-(tabBarController?.tabBar.frameHeight ?? 0))
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        
        sosButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-24 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.68)
            make.height.equalTo(sosButton.snp.width).multipliedBy(0.46)
            sosButton.contentEdgeInsets.top = self.view.frame.height / 45
            sosButton.contentEdgeInsets.left = 10
        }
        
        ctaTitle.snp.makeConstraints { make in
            make.bottom.equalTo(sosButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(sosButton)
        }
        
    }
    
    //MARK: - selectors
    
    @objc private func consultButtonPressed(_ button: UIButton) {
        self.present(ConsultationFormViewController(), animated: true)
    }
    
    @objc private func profileButtonTapped(_ button: UIButton) {
        self.present(ProfileViewController(), animated: true)
    }
    
    @objc private func sosButtonPressed() {
        Vibration.soft.vibrate()
        
        let destination = PracticeViewController()
        destination.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(destination, animated: true)
    }

}

