//
//  SignUpViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 07/08/2021.
//  https://youtu.be/BxQsdhglZtE

import UIKit
import SnapKit
import Firebase
import AuthenticationServices
import CryptoKit

class SignUpViewController: UIViewController {
    
    private lazy var mainLogo: UIImageView = {
       let view = UIImageView()
        view.image = K.uikit.logo
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Здравствуйте!"
        label.font = FontTypes.shared.h2.withSize(30 * heightModifier)
        label.textColor = K.colors.appText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var authDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = K.text.authDescription
        label.font = FontTypes.shared.ubuntuLight.withSize(14 * heightModifier)
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var googleAuthButton: AuthButton = {
        let button = AuthButton()

        button.authImageView.image = UIImage(named: "google-auth-logo")
        button.authTitle = "Sign up with Google"

        button.layer.borderWidth = 2
        button.layer.borderColor = K.colors.appBlue?.cgColor
        button.setTitleColor(K.colors.appText, for: .normal)

        return button
    }()
    
    private lazy var appleAuthButton: AuthButton = {
        let button = AuthButton()
        
        button.authImageView.image = UIImage(systemName: "applelogo")
        button.authTitle = "Continue with Apple"

        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        
        button.addTarget(self, action: #selector(handleAppleAuthButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondaryButtonSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private lazy var emailAuthButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        button.setTitle("Sign up with email", for: .normal)
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        button.setTitle("Sign in", for: .normal)
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
        setUpUI()

    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
    }

    private func addSubviews() {
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
        view.addSubview(authDescription)
        
        view.addSubview(appleAuthButton)
        view.addSubview(googleAuthButton)
        
        view.addSubview(secondaryButtonSV)
        secondaryButtonSV.addArrangedSubview(emailAuthButton)
        secondaryButtonSV.addArrangedSubview(signInButton)
        
        view.addSubview(privacyDescription)
        
        
    }
    
    private func setConstraints() {
        mainLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(81 * heightModifier)
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
        
        authDescription.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(24 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.centerX.equalToSuperview()
        }
        
        privacyDescription.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(view.safeAreaSize(from: .bottom) + (16 * heightModifier)))
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(privacyDescription.font.pointSize.percentage(225))
        }
        
        secondaryButtonSV.snp.makeConstraints { make in
            make.bottom.equalTo(privacyDescription.snp.top).offset(-22 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.375)
            make.height.equalTo(18 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        appleAuthButton.snp.makeConstraints { make in
            make.bottom.equalTo(secondaryButtonSV.snp.top).offset(-22 * heightModifier)
            make.height.equalTo(56 * heightModifier)
            make.width.equalTo(appleAuthButton.snp.height).multipliedBy(5.55)
            make.centerX.equalToSuperview()
        }
        
        googleAuthButton.snp.makeConstraints { make in
            make.bottom.equalTo(appleAuthButton.snp.top).offset(-18 * heightModifier)
            make.height.equalTo(56 * heightModifier)
            make.width.equalTo(appleAuthButton.snp.height).multipliedBy(5.55)
            make.centerX.equalToSuperview()
        }
        
        

    }


    //MARK: - button selectors
    
    @objc private func handleAppleAuthButtonTapped(_ button: UIButton) {
        print("tap")
        performSignInWithApple()
    }
    
    //MARK: - auth methods
    
    fileprivate var currentNonce: String?
    
    private func performSignInWithApple() {
        let request = createAppleIDRequest()
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        authController.delegate = self
        authController.presentationContextProvider = self
        
        authController.performRequests()
    }
    
    private func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        
        currentNonce = nonce
        
        return request
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
    
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
      let nonce = randomNonceString()
      currentNonce = nonce
      let appleIDProvider = ASAuthorizationAppleIDProvider()
      let request = appleIDProvider.createRequest()
      request.requestedScopes = [.fullName, .email]
      request.nonce = sha256(nonce)

      let authorizationController = ASAuthorizationController(authorizationRequests: [request])
      authorizationController.delegate = self
      authorizationController.presentationContextProvider = self
      authorizationController.performRequests()
    }

    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }

}

extension SignUpViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("did complete bla bla")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else { fatalError("Invalid state: a login callback was received, but no request was made") }
            guard let appleIDAuthToken = appleIDCredential.identityToken else { print("unable to fetch id token"); return }
            guard let idTokenString = String(data: appleIDAuthToken, encoding: .utf8) else {print("unable to parse token string from data: \(appleIDAuthToken.debugDescription)"); return}
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let _ = authResult?.user {
                    let destination = MainTabBarController()
                    destination.modalPresentationStyle = .fullScreen
                    destination.modalTransitionStyle = .coverVertical
                    self.show(destination, sender: self)
                }
            }
        }
        
    }
    
    
    
}

