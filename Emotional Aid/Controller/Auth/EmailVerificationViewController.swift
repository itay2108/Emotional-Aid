//
//  EmailVerificationViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 20/08/2021.
//

import UIKit
import FirebaseAuth

class EmailVerificationViewController: UIViewController {
    
    var delegate: EmailVerificationDelegate?
    
    private var verificationTimer: Timer?

    private let def = UserDefaults.standard
    
    private var userEmail: String? {
        get {
            if let email = def.string(forKey: K.def.email) { return email } else {
                return nil
            }
        }
    }
    
    private var userPassword: String? {
        get {
            if let password = def.string(forKey: K.def.password) { return password } else {
                return nil
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
    
    private lazy var mainLogo: UIImageView = {
       let view = UIImageView()
        view.image = K.uikit.logo
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Проверьте вашу почту"
        label.font = FontTypes.shared.h2.withSize(30 * heightModifier)
        label.textColor = K.colors.appText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var verificationDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FontTypes.shared.ubuntuLight.withSize(14 * heightModifier)
        label.textColor = K.colors.appText
        label.text = K.text.verificationDescription
        label.sizeToFit()
        return label
    }()
    
    private lazy var footerSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var didntReceiveVerificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = FontTypes.shared.ubuntuLight.withSize(11 * heightModifier)
        label.textColor = K.colors.appText
        label.text = "Didn't receive an email?"
        return label
    }()
    
    private lazy var sendVerificationButton: UIButton = {
        let button = UIButton()
        button.tintColor = K.colors.appBlue
        button.setTitleColor(K.colors.appBlue, for: .normal)
        button.setTitle("Send Again", for: .normal)
        button.titleLabel?.font = FontTypes.shared.ubuntuMedium.withSize(11 * heightModifier)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()
        print(userEmail as Any, userPassword as Any, Auth.auth().currentUser as Any)
        
        checkForEmailVerification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("stopping timer")
        verificationTimer?.invalidate()
        verificationTimer = nil
    }
    
    
    func setUpUI() {
        view.backgroundColor = .white
        
        addSubviews()
        setConstraints()

    }
    
    func addSubviews() {
        
        view.addSubview(navContainer)
        navContainer.addSubview(backButton)
        
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
        view.addSubview(verificationDescription)
        
        view.addSubview(footerSV)
        footerSV.addArrangedSubview(didntReceiveVerificationLabel)
        footerSV.addArrangedSubview(sendVerificationButton)
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
        
        mainLogo.snp.makeConstraints { make in
            make.top.equalTo(navContainer.snp.centerY).offset(12 * heightModifier)
            make.width.equalTo(40 * widthModifier)
            make.height.equalTo(mainLogo.snp.width)
            make.centerX.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainLogo.snp.bottom).offset(18 * heightModifier)
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(mainTitle.font.pointSize.percentage(110))
        }
        
        verificationDescription.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(24 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.centerX.equalToSuperview()
        }
        
        footerSV.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom) + (16 * heightModifier)))
            make.width.equalToSuperview().multipliedBy(0.565)
            make.centerX.equalToSuperview()
            make.height.equalTo(didntReceiveVerificationLabel.font?.pointSize.percentage(125) ?? 18 * heightModifier)
        }

    }
    
    //MARK: - verification methods
    
    private func checkForEmailVerification(every timeInterval: Double = 5) {
        verificationTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(handleEmailVerified), userInfo: nil, repeats: true)
        verificationTimer?.fire()
    }
    
    @objc private func handleEmailVerified() {
        print("checking for email verification...\nemail is\(isEmailVerified() ? "" : "n't") verified")
        if isEmailVerified() {
            self.verificationTimer?.invalidate()
            self.verificationTimer = nil
            self.dismiss(animated: true)
            delegate?.didVerifyEmail(for: Auth.auth().currentUser)
        }
    }
    
    private func isEmailVerified() -> Bool {
        Auth.auth().currentUser?.reload()
        
        guard Auth.auth().currentUser != nil else { return false }
        let isVerified = Auth.auth().currentUser!.isEmailVerified
        return isVerified
    }
    
    //MARK: - button selectors
    
    @objc func sendVerificationEmail(_ sender: UIButton) {
        Vibration.success.vibrate()
        Auth.auth().currentUser?.sendEmailVerification(completion: nil)
        
        sender.setTitle("Send Again", for: .normal)
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true)
    }

}
