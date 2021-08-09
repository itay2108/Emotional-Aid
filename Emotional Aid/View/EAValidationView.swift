//
//  EAValidationView.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/08/2021.
//

import UIKit
import SnapKit

class EAValidationView: UIView {
    
    var type: ValidationFieldContentType = .generic
    var mustHaveContent: Bool = true
    var spacesAllowed: Bool = true
    
    var validationError: ValidationError? = nil {
        didSet {
            bottomBorder.tintColor = validationError == nil ? K.colors.appBlue : K.colors.appRed
            
            if validationError != nil {
                errorLabel.snp.remakeConstraints { make in
                    make.top.equalTo(bottomBorder.snp.bottom).offset(4 * heightModifier)
                    make.left.equalToSuperview().offset(textField.leftView?.frameWidth ?? 0)
                    make.right.equalToSuperview()
                    make.height.equalTo( 16 * heightModifier )
                }
                
                switch validationError {
                case .leftBlank:
                    errorLabel.text = K.text.blankError + " " + type.rawValue
                case .nameFormat:
                    errorLabel.text = K.text.nameRequirements
                case .emailFormat:
                    errorLabel.text = K.text.emailRequirements
                case .passWordLength:
                    errorLabel.text = K.text.passwordRequirements
                default:
                    errorLabel.text = "couldn't authenticate"
                }
            } else {
                errorLabel.snp.remakeConstraints { make in
                    make.top.equalTo(bottomBorder.snp.bottom).offset(4 * heightModifier)
                    make.left.equalToSuperview().offset(textField.leftView?.frameWidth ?? 0)
                    make.right.equalToSuperview()
                    make.height.equalTo(0)
                }
            }
        }
    }
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntuMedium.withSize(16 * heightModifier)
        label.numberOfLines = 1
        label.textColor = K.colors.appText
        label.textAlignment = .center
        return label
    }()

    lazy var textField: SignInTextField = {
       let tf = SignInTextField(padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -12))
        tf.borderStyle = .none
        tf.background = .none
        tf.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        tf.textAlignment = .left
        tf.textColor = K.colors.appText
        return tf
    }()
    
    lazy var bottomBorder: UIImageView = {
        let view = UIImageView()
        
        let lines = [K.uikit.lineScribble1?.withRenderingMode(.alwaysTemplate),
                     K.uikit.lineScribble2?.withRenderingMode(.alwaysTemplate),
                     K.uikit.lineScribble3?.withRenderingMode(.alwaysTemplate)]
        
        let rand = Int.random(in: 0...2)
        
        if rand < lines.count {
            view.image = lines[rand]
        }
        
        view.contentMode = .scaleAspectFit
        view.tintColor = K.colors.appBlue
        
        return view
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = K.colors.appRed
        label.font = FontTypes.shared.ubuntu.withSize(11 * heightModifier)
        return label
    }()
    
    private func setUpView() {
        addSubviews()
        addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(title)
        self.addSubview(textField)
        self.addSubview(bottomBorder)
        self.addSubview(errorLabel)
    }
    
    private func addConstraintsToSubviews() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(title.font.pointSize.percentage(110))
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40 * heightModifier)
        }
        
        bottomBorder.snp.makeConstraints { make in
            make.bottom.equalTo(textField).offset(6 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(6 * heightModifier)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomBorder.snp.bottom).offset(4 * heightModifier)
            make.left.equalToSuperview().offset(textField.padding.left)
            make.right.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    //MARK: - validation methods
    
    func validate() -> ValidationError? {
        
        let text = self.textField.text
        
        guard text != nil else { return .leftBlank }
        

        if mustHaveContent && text == "" { return .leftBlank } else
        if !spacesAllowed && text!.containsSpaces() { return .containsSpaces } else {
            
            switch type {
            case .name:
                if isValidName(text!) { return nil } else { return .nameFormat }
            case .email:
                if isValidEmail(text!) { return nil } else { return .emailFormat }
            case .password:
                if isValidPassword(text!) { return nil } else { return .passWordLength }
            default:
                return nil
            }
        }
    }
    
    func isValidName(_ name: String) -> Bool {
        let nameRegEx = K.regEx.name
        
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        
        let emailRegEx = K.regEx.email

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        
        let passwordRegEx = K.regEx.password

        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    //MARK: - communication
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextFieldDidBeginEditing), name: NSNotification.Name.SignInTextFieldDidBeginEditing, object: nil)
    }
    
    @objc private func handleTextFieldDidBeginEditing() {
        validationError = nil
    }
    
    //MARK: - inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUpView()
        setUpObservers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUpView()
        setUpObservers()
    }
    
}

enum ValidationFieldContentType: String {
    case generic
    case name = "a name"
    case email = "an email"
    case password = "a password"
}

enum ValidationError {
    case leftBlank
    case nameFormat
    case emailFormat
    case passWordLength
    case containsSpaces
}
