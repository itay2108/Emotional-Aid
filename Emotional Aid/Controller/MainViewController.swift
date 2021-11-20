//
//  ViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import SnapKit
import CryptoKit
import Speech
import FirebaseAuth


class MainViewController: UIViewController {
    
    private let def = UserDefaults.standard
    
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
        button.setImage(getProfilePic(), for: .normal)
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
        
        view.image = K.uikit.logo
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
    
    private lazy var premiumIcon:   UIImageView    = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = K.uikit.premiumIconCircle
        view.isHidden = UIApplication.isPremiumAvailable() ? true : false
        return view
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
    
//    private lazy var testSlider: EASlider = {
//        return EASlider()
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        setUpObservers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        premiumIcon.isHidden = UIApplication.isPremiumAvailable() ? true : false
        profileButton.setImage(getProfilePic(), for: .normal)
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
        ctaContainer.addSubview(premiumIcon)
        ctaContainer.addSubview(ctaTitle)
//        ctaContainer.addSubview(testSlider)
    }
    
    private func setConstraints() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(84 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        consultButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30 * widthModifier)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.55)
            make.right.equalTo(profileButton.snp.left).offset(-20 * widthModifier)
        }
        
        profileButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.centerY.equalTo(navContainer)
            make.height.equalToSuperview().multipliedBy(0.9)
            make.width.equalTo(navContainer.snp.height).multipliedBy(0.9)
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
        
        premiumIcon.snp.makeConstraints { make in
            make.centerX.equalTo(sosButton.snp.right)
            make.centerY.equalTo(sosButton.snp.top)
            make.height.equalTo(48 * heightModifier)
            make.width.equalTo(premiumIcon.snp.height)
        }
        
        ctaTitle.snp.makeConstraints { make in
            make.bottom.equalTo(sosButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(sosButton)
        }
        
//        testSlider.snp.makeConstraints { make in
//            make.top.equalTo(mainTitle.snp.bottom).offset(24 * heightModifier)
//            make.width.equalToSuperview().multipliedBy(0.7)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(64 * heightModifier)
//        }
        
    }
    
    func getProfilePic() -> UIImage? {
        let image: UIImage?
        
        if Personality.main.gender == .female {
            image = UIApplication.isPremiumAvailable() ? K.uikit.profileFemalePremium : K.uikit.profileFemale
        } else {
            image = UIApplication.isPremiumAvailable() ? K.uikit.profileMalePremium : K.uikit.profileMale
        }
        
        return image
    }
    
    override func premiumViewShouldDismiss(withSuccess transactionSuccess: Bool) {
        super.premiumViewShouldDismiss(withSuccess: transactionSuccess)
        
        if transactionSuccess {
            premiumIcon.isHidden = true
            profileButton.setImage(getProfilePic(), for: .normal)
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
        //check if all permissions are set
        if UIApplication.isPremiumAvailable() {
            if AudioManager.shared.isMicrophoneAllowed() && SpeechRecognitionManager.main.isRecognitionAllowed() {
                //if user did not see recommendations yet - show them
                if def.bool(forKey: K.def.recommendationsHaveBeenShown) {
                    let destination = PracticeViewController()
                    destination.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(destination, animated: true)
                } else {
                    //if they already have - show Practice
                    let destination = RecommendationViewController()
                    destination.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            } else {
                
                var alertMessage = ""
                
                if !AudioManager.shared.isMicrophoneAllowed() {
                    alertMessage.append("Чтобы разрешить использование микрофона, перейдите в Настройки -> Конфиденциальность -> микрофон и разрешите его использование для этого приложения.")
                }
                
                if !AudioManager.shared.isMicrophoneAllowed() && !SpeechRecognitionManager.main.isRecognitionAllowed() {
                    alertMessage.append("\n\n")
                }
                
                if !SpeechRecognitionManager.main.isRecognitionAllowed() {
                    alertMessage.append("Чтобы разрешить распознавание речи, перейдите в Настройки -> Конфиденциальность -> Распознавание речи и включите")
                }
                
                
                let alert = UIAlertController(title: "Требуются дополнительные разрешения", message: alertMessage, preferredStyle: .alert)
                
                let settingsAction = UIAlertAction(title: "Настройки", style: .default) { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }

                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }
                
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
                
                alert.addAction(cancelAction)
                alert.addAction(settingsAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            //premium not available
            premiumDisplay()
        }
        


        
    }
    
    //MARK: - observers
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleGenderDidChange), name: NSNotification.Name.GenderDidChange, object: nil)
    }
    
    @objc private func handleGenderDidChange() {
        profileButton.setImage(getProfilePic(), for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

