//
//  EmailSignUpViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 08/08/2021.
//

import UIKit
import SnapKit
import Firebase
import PaddingLabel

class EmailAuthViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    let def = UserDefaults.standard

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
    
    private lazy var authFormSV: UIStackView = {
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
        view.textField.attributedPlaceholder = NSAttributedString(string: "Артем Андреевич", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        view.textField.delegate = self
        view.textField.returnKeyType = .next
        view.textField.textContentType = .name
        view.tag = 0
        return view
    }()
    
    private lazy var emailTextField: EAValidationView = {
        let view = EAValidationView()
        view.title.text = "Ваш email"
        view.type = .email
        view.textField.attributedPlaceholder = NSAttributedString(string: "artem@icloud.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        view.textField.delegate = self
        view.textField.returnKeyType = .next
        view.textField.textContentType = .emailAddress
        view.tag = 1
        return view
    }()
    
    private lazy var passwordTextField: EAValidationView = {
        let view = EAValidationView()
        view.type = .password
        view.title.text = "Ваш пароль"
        view.textField.isSecureTextEntry = true
        view.textField.delegate = self
        view.textField.returnKeyType = .done
        view.textField.textContentType = .newPassword
        view.tag = 2
        return view
    }()
    
    private lazy var passwordShowHideButton: UIButton = {
       let button = UIButton()
        button.setImage(K.uikit.eyeFill, for: .normal)
        button.tintColor = K.colors.appText
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(showHidePasswordButtonPressed(_:)), for: .touchUpInside)
       return button
    }()
    
    private lazy var authButton: UIButton = {
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
    
    private lazy var privacyDescription: UITextView = {
        let label = UITextView()
        label.backgroundColor = .white
        label.font = FontTypes.shared.ubuntuLight.withSize(11 * heightModifier)
        label.textAlignment = .center
        label.textColor = K.colors.appText
        label.tintColor = K.colors.appBlueDark
        label.attributedText = K.text.privacyAndTermsDescription
        label.isEditable = false
        label.isScrollEnabled = false
        label.sizeToFit()
        return label
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
        
        view.addSubview(authFormSV)
        if authState == .signUp {
            authFormSV.addArrangedSubview(nameTextField)
        }
        authFormSV.addArrangedSubview(emailTextField)
        authFormSV.addArrangedSubview(passwordTextField)
        
        passwordTextField.addSubview(passwordShowHideButton)
        
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
        
        authFormSV.snp.makeConstraints { make in
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
        
        passwordShowHideButton.snp.makeConstraints { make in
            make.height.equalTo(18 * heightModifier)
            make.width.equalTo(passwordShowHideButton.snp.height)
            make.centerY.equalTo(passwordTextField)
            make.right.equalTo(passwordTextField).offset(-12 * widthModifier)
        }
        
        authButton.snp.makeConstraints { make in
            make.width.equalTo(256 * widthModifier)
            make.height.equalTo(56 * heightModifier)
            make.top.equalTo(authFormSV.snp.bottom).offset(36 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        privacyDescription.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom) + (16 * heightModifier)))
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
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
                
                self.authFormSV.addArrangedSubview(self.nameTextField)
                self.authFormSV.addArrangedSubview(self.emailTextField)
                self.authFormSV.addArrangedSubview(self.passwordTextField)
                
                self.privacyDescription.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().offset(-(self.view.safeAreaSize(from: .bottom) + (12 * self.heightModifier)))
                    make.left.equalToSuperview().offset(64 * self.widthModifier)
                    make.centerX.equalToSuperview()
                }
                
            } else if self.authState == .signIn {
                self.mainTitle.text = "Вход с email"
                self.authButton.setTitle("Вход", for: .normal)
                self.changeAuthStateButton.setTitle("Регистрация", for: .normal)

                self.authFormSV.addArrangedSubview(self.emailTextField)
                self.authFormSV.addArrangedSubview(self.passwordTextField)

                
                self.privacyDescription.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview().offset(-(self.view.safeAreaSize(from: .bottom) + (16 * self.heightModifier)))
                    make.left.equalToSuperview().offset(64 * self.widthModifier)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(0)
                }
            }
        }
    }
    
    private func presentErrorToast(message: String, fadeOutAfter: Double? = nil) {
        
        Vibration.error.vibrate()
        
        view.addSubview(errorLabel)
        errorLabel.text = message
        errorLabel.alpha = 1
        
        errorLabel.snp.makeConstraints { make in
            make.bottom.equalTo(authButton.snp.top).offset(-16 * heightModifier)
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
    
    //MARK: - auth methods
    
    private func performAuth(withEmail email: String?, password: String?) {
        guard let email = emailTextField.textField.text,
              let password = passwordTextField.textField.text
        else { print("email or password were nil when creating user"); return }
        if authState == .signUp {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user {
                    if !user.isEmailVerified {
                        print("email isnt verified")
                        user.sendEmailVerification { error in
                            if error == nil {
                                print("email sent to: \(email)")
                                self.def.setValue(email, forKey: K.def.email)
                                self.def.setValue(password, forKey: K.def.password)
                                self.def.setValue(self.nameTextField.textField.text, forKey: K.def.name)
                                
                                let destination = EmailVerificationViewController()
                                destination.delegate = self
                                
                                self.present(destination, animated: true)
                            } else {
                                print("error: ", error as Any)
                                textLog.write("error: \(String(describing: error?.localizedDescription))")
                            }
                        }
                    } else {
                        //user is verified
                        self.didSignInWith(user: authResult!.user, present: MainTabBarController())
                    }
                } else {
                    if let authError = error as NSError? {
                        switch authError.code {
                        case 17007:
                            self.emailTextField.validationError = .usernameExists
                        default:
                            self.presentErrorToast(message: K.text.errorDescriptions.signUpGeneric)
                        }
                        print(authError)
                        textLog.write("\(authError)")
                    }
                }
            }
        } else if authState == .signIn {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let user = authResult?.user {
                    if !user.isEmailVerified {
                        print("email isnt verified")
                        user.sendEmailVerification { error in
                            if error == nil {
                                textLog.write("email sent to: \(email)")
                                self.def.setValue(email, forKey: K.def.email)
                                self.def.setValue(password, forKey: K.def.password)
                                
                                let destination = EmailVerificationViewController()
                                destination.delegate = self
                                
                                self.present(destination, animated: true)
                            } else {
                                print("error: ", error as Any)
                                textLog.write("error: \(String(describing: error?.localizedDescription))")
                            }
                        }
                    } else {
                        //user is verified
                        self.didSignInWith(user: authResult?.user, present: MainTabBarController())
                    }
                } else {
                    if let signInError = error as NSError? {
                        switch signInError.code {
                        case 17009:
                            self.passwordTextField.validationError = .wrongPassword
                        case 17011:
                            self.emailTextField.validationError = .noSuchUser
                        default:
                            self.presentErrorToast(message: K.text.errorDescriptions.signUpGeneric)
                        }
                        print(signInError)
                        textLog.write("error: \(String(describing: error?.localizedDescription))")
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
        }
    }
    
    @objc private func handleChangeAuthSteteButtonTapped(_ button: UIButton) {
        authState = authState == .signUp ? .signIn : .signUp
        self.view.layoutSubviews()
    }
    
    @objc private func showHidePasswordButtonPressed(_ button: UIButton) {
        passwordTextField.textField.isSecureTextEntry = !passwordTextField.textField.isSecureTextEntry
        
        if passwordTextField.textField.isSecureTextEntry {
            button.setImage(K.uikit.eyeFill, for: .normal)
        } else {
            button.setImage(K.uikit.eyeFillWithSlash, for: .normal)
        }
    }
    
}

extension EmailAuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.post(name: NSNotification.Name.SignInTextFieldDidBeginEditing, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            if  let currentTag = textField.superview?.tag,
                let nextResponderHolder = textField.superview?.superview?.viewWithTag(currentTag + 1) as! EAValidationView? {
                let nextResponder = nextResponderHolder.textField
                nextResponder.becomeFirstResponder()
                return false
            }
        } else if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        return true
    }
}

extension EmailAuthViewController: EmailVerificationDelegate {
    func didVerifyEmail(for user: User?) {
        didSignInWith(user: user, present: MainTabBarController())
    }
    
    
}
