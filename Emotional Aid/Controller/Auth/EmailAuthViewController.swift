//
//  EmailSignUpViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/08/2021.
//

import UIKit
import SnapKit
import Firebase

class EmailAuthViewController: UIViewController {

    var authState: AuthState = .signUp {
        didSet {
            setSceneAccordingToState()
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
        label.text = authState == .signUp ? "Регистрация с email" : "Вход с email"
        label.font = FontTypes.shared.h2.withSize(30 * heightModifier)
        label.textColor = K.colors.appText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signInFormSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 24 * heightModifier
        sv.alignment = .fill
        return sv
    }()
    
    private lazy var nameTextField: EAValidationView = {
        let view = EAValidationView()
        view.title.text = "Ваше имя"
        view.type = .name
        view.textField.attributedPlaceholder = NSAttributedString(string: "Jeff Jefferson", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        view.textField.delegate = self
        return view
    }()
    
    private lazy var emailTextField: EAValidationView = {
        let view = EAValidationView()
        view.title.text = "Ваш email"
        view.type = .email
        view.textField.attributedPlaceholder = NSAttributedString(string: "jeff@icloud.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        view.textField.delegate = self
        return view
    }()
    
    private lazy var passwordTextField: EAValidationView = {
        let view = EAValidationView()
        view.type = .password
        view.title.text = "Ваш пароль"
        view.textField.isSecureTextEntry = true
        view.textField.delegate = self
        return view
    }()
    
    private lazy var authButton: UIButton    = {
        let button = UIButton()
        button.setTitle(authState == .signUp ? "регистрация" : "Вход", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(K.colors.appRed ?? .red), for: .normal)
        
        button.addTarget(self, action: #selector(handleAuthButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var changeAuthStateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        button.setTitle(authState == .signUp ? "Вход" : "Регистрация", for: .normal)
        
        button.addTarget(self, action: #selector(handleChangeAuthSteteButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyDescription: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntuLight.withSize(11 * heightModifier)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = K.colors.appText
        label.text = "By signing up, you agree to our Privacy policy and Terms & conditions"
        return label
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.setupToHideKeyboardOnTapOnView()
        
        addSubviews()
        setConstraints()
    }

    private func addSubviews() {
        
        view.addSubview(navContainer)
        navContainer.addSubview(backButton)
        
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
        
        view.addSubview(signInFormSV)
        if authState == .signUp {
            signInFormSV.addArrangedSubview(nameTextField)
        }
        signInFormSV.addArrangedSubview(emailTextField)
        signInFormSV.addArrangedSubview(passwordTextField)
        
        view.addSubview(authButton)

        view.addSubview(changeAuthStateButton)
        view.addSubview(privacyDescription)
        
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
        
        signInFormSV.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(56 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.right.equalToSuperview().offset(-48 * widthModifier)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        authButton.snp.makeConstraints { make in
            make.width.equalTo(256 * widthModifier)
            make.height.equalTo(56 * heightModifier)
            make.top.equalTo(signInFormSV.snp.bottom).offset(36 * heightModifier)
            make.centerX.equalToSuperview()
            
        }
        
        privacyDescription.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom) + (16 * heightModifier)))
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(privacyDescription.font.pointSize.percentage(225))
        }
        
        changeAuthStateButton.snp.makeConstraints { make in
            make.bottom.equalTo(privacyDescription.snp.top).offset(-22 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.25)
            make.height.equalTo(18 * heightModifier)
            make.centerX.equalToSuperview()
        }

    }
    
    private func setSceneAccordingToState() {
        
        nameTextField.removeFromSuperview()
        emailTextField.removeFromSuperview()
        passwordTextField.removeFromSuperview()
        
        UIView.animate(withDuration: 0.33) {
            if self.authState == .signUp {
                self.mainTitle.text = "Регистрация с email"
                self.authButton.setTitle("регистрация", for: .normal)
                self.changeAuthStateButton.setTitle("Вход", for: .normal)
                
                self.signInFormSV.addArrangedSubview(self.nameTextField)
                self.signInFormSV.addArrangedSubview(self.emailTextField)
                self.signInFormSV.addArrangedSubview(self.passwordTextField)
                
                self.privacyDescription.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().offset(-(self.view.safeAreaSize(from: .bottom) + (16 * self.heightModifier)))
                    make.left.equalToSuperview().offset(64 * self.widthModifier)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(self.privacyDescription.font.pointSize.percentage(225))
                }
                
            } else if self.authState == .signIn {
                self.mainTitle.text = "Вход с email"
                self.authButton.setTitle("Вход", for: .normal)
                self.changeAuthStateButton.setTitle("Регистрация", for: .normal)

                self.signInFormSV.addArrangedSubview(self.emailTextField)
                self.signInFormSV.addArrangedSubview(self.passwordTextField)

                
                self.privacyDescription.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().offset(-(self.view.safeAreaSize(from: .bottom) + (16 * self.heightModifier)))
                    make.left.equalToSuperview().offset(64 * self.widthModifier)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(0)
                }
            }
        }
    }
    
    //MARK: - auth methods
    
    private func performAuth(withEmail email: String?, password: String?) {
        guard let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text
        else { print("email or password were nil when creating user"); return }
        if authState == .signUp {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if authResult?.user != nil {
                    self.didSignInWith(user: authResult!.user, present: MainTabBarController())
                }
            }
        } else if authState == .signIn {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if authResult?.user != nil {
                    self.didSignInWith(user: authResult!.user, present: MainTabBarController())
                } else {
                    if let signInError = error as NSError? {
                        switch signInError.code {
                        case 17009:
                            self.passwordTextField.validationError = .wrongPassword
                        case 17011:
                            self.emailTextField.validationError = .noSuchUser
                        default:
                            self.passwordTextField.validationError = .signInGeneric
                        }
                        print(signInError)
                    }
                }
            }
        }

    }
    
    private func didSignInWith(user: User?, present viewController: UIViewController, animated: Bool = true) {
        precondition(user != nil)
        
        let destination = viewController
        destination.modalPresentationStyle = .fullScreen
        destination.modalTransitionStyle = .coverVertical

        self.present(destination, animated: animated)
    }
    
    
    
    //MARK: - button selectors
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAuthButtonPressed(_ button: UIButton) {
        
        nameTextField.validationError = authState == .signUp ? nameTextField.validate() : nil
        emailTextField.validationError = emailTextField.validate()
        passwordTextField.validationError = passwordTextField.validate()
        
        if [nameTextField.validationError, emailTextField.validationError, passwordTextField.validationError].allElementsAreNil() {
            //SIGN IN HERE
            performAuth(withEmail: emailTextField.textField.text, password: passwordTextField.textField.text)
            
            if let userName = nameTextField.textField.text {
                Personality.main.name = userName
            }
        }
    }
    
    @objc private func handleChangeAuthSteteButtonTapped(_ button: UIButton) {
        authState = authState == .signUp ? .signIn : .signUp
        self.view.layoutSubviews()
    }

    
}

extension EmailAuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name.SignInTextFieldDidBeginEditing, object: nil)
    }
}
