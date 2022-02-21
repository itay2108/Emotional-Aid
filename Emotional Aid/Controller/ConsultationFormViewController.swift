//
//  ConsultationFormViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/08/2021.
//

import UIKit
import MessageUI

class ConsultationFormViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let def = UserDefaults.standard
    
    var emailSuccessfullySent: Bool = false
    var delegate: ConsultationFormViewControllerDelegate?
    
    private lazy var handle: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.h1
        label.textAlignment = .left
        label.textColor = K.colors.appText
        
        label.text = "Запись на\nконсультацию"
        
        return label
    }()
    
    private lazy var mainDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = K.text.consultationFormDescription
        label.font = FontTypes.shared.ubuntuLight.withSize(14 * heightModifier)
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var consultationFormSV: UIStackView = {
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
        
        if let userName = def.string(forKey: K.def.name) {
            view.textField.text = userName
        }
        
        view.textField.delegate = self
        view.textField.returnKeyType = .next
        view.tag = 0
        return view
    }()
    
    private lazy var emailTextField: EAValidationView = {
        let view = EAValidationView()
        view.title.text = "Ваш email"
        view.type = .email
        view.textField.attributedPlaceholder = NSAttributedString(string: "jeff@icloud.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray.withAlphaComponent(0.5)])
        view.textField.delegate = self
        view.textField.returnKeyType = .next
        view.tag = 1
        return view
    }()
    
    private lazy var phoneTextField: EAValidationView = {
        let view = EAValidationView()
        view.type = .phone
        view.title.text = "Ваш номер телефона"
        view.textField.delegate = self
        view.textField.returnKeyType = .done
        view.tag = 2
        return view
    }()
    
    private lazy var sendButton: UIButton    = {
        let button = UIButton()
        button.setTitle("оставить заявку", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(K.colors.appRed ?? .red), for: .normal)
        
        button.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    // Success
    
    private lazy var successHandle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var successContainer: UIView = {
        let view = UIView()
        view.backgroundColor = K.colors.appBlue
        //view.gradientBackground(colors: [K.colors.appBlue!.cgColor, K.colors.appBlueDark!.cgColor], type: .radial, direction: .topToBottom)
        return view
    }()
    
    
    private lazy var successLogo: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var successTitle: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.h1.withSize(36 * heightModifier)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Спасибо!"
        return label
    }()
    
    private lazy var successDescription: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntu.withSize(18 * heightModifier)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "мы свяжемся с вами\nв ближайшее время"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        if emailSuccessfullySent {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.66) {
                self.dismiss(animated: true) {
                    self.delegate?.didSuccessfullySendRequest()
                }
            }
        }
    }
    
    private func setUpUI() {
        addSubviews()
        setConstraints()
        
        self.setupToHideKeyboardOnTapOnView()
    }
    
    private func addSubviews() {
        
        view.addSubview(handle)
        
        view.addSubview(mainTitle)
        view.addSubview(mainDescription)
        view.addSubview(consultationFormSV)

        consultationFormSV.addArrangedSubview(nameTextField)
        consultationFormSV.addArrangedSubview(emailTextField)
        consultationFormSV.addArrangedSubview(phoneTextField)
        
        view.addSubview(sendButton)

        
    }
    
    private func setConstraints() {
        
        handle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.height.equalTo(4 * heightModifier)
            make.width.equalTo(36 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(handle.snp.bottom).offset(42 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(mainTitle.font.pointSize.percentage(233))
        }
        
        mainDescription.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(24 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.centerX.equalToSuperview()
        }
        
        consultationFormSV.snp.makeConstraints { make in
            make.top.equalTo(mainDescription.snp.bottom).offset(36 * heightModifier)
            make.left.equalToSuperview().offset(48 * widthModifier)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(84 * heightModifier)
        }
        
        sendButton.snp.makeConstraints { make in
            make.width.equalTo(256 * widthModifier)
            make.height.equalTo(56 * heightModifier)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(36 + view.safeAreaSize(from: .bottom)))
        }


    }
    
    private func presentSuccessUI() {
        Vibration.success.vibrate()
        
        view.addSubview(successContainer)
        
        view.addSubview(successHandle)
        view.addSubview(successLogo)
        view.addSubview(successTitle)
        view.addSubview(successDescription)
        
        successContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        successHandle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.height.equalTo(4 * heightModifier)
            make.width.equalTo(36 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        successTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(successTitle.font.pointSize.percentage(110))
        }
        
        successLogo.snp.makeConstraints { make in
            make.height.equalTo(36 * heightModifier)
            make.width.equalTo(successLogo.snp.height)
            make.bottom.equalTo(successTitle.snp.top).offset(-32 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        successDescription.snp.makeConstraints { make in
            make.top.equalTo(successTitle.snp.bottom).offset(18 * heightModifier)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    //MARK: - selectors
    
    @objc private func sendButtonPressed(_ button: UIButton) {
        nameTextField.validationError = nameTextField.validate()
        emailTextField.validationError = emailTextField.validate()
        phoneTextField.validationError = phoneTextField.validate()
        
        if [nameTextField.validationError, emailTextField.validationError, phoneTextField.validationError].allElementsAreNil() {
           
            def.setValue(nameTextField.textField.text, forKey: K.def.name)
            
            if MFMailComposeViewController.canSendMail() {
                var countryPhoneCode = ""
                
                if let userLocale = (Locale.current as NSLocale).object(forKey: .countryCode) as? String,
                   let phonePrefix = K.locale.countryCodes[userLocale] {
                    countryPhoneCode = "+" + phonePrefix
                }
                
                let emailRecepients = ["emotionalaidapp@gmail.com"]
                
                let contactFormMessage = "Имя: \(nameTextField.textField.text ?? "")\nПочта: \(emailTextField.textField.text ?? "")\nНомер телефона: (\(countryPhoneCode)) \(phoneTextField.textField.text ?? "")\n\nОсобые Просьбы:\n\n"
                
                let mc = MFMailComposeViewController()
                
                mc.mailComposeDelegate = self
                mc.setToRecipients(emailRecepients)
                mc.setSubject("Emotional Aid Consultation Request")
                mc.setMessageBody(contactFormMessage, isHTML: false)
                self.present(mc, animated: true)
            } else {
                //cant send mail handled here
                textLog.write("cannot send mail.")
            }

        }
    }

}

extension ConsultationFormViewController: UITextFieldDelegate {
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
        }

        return true
    }
}

extension ConsultationFormViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .sent {
            presentSuccessUI()
            emailSuccessfullySent = true
        }
        
        self.dismiss(animated: true)
    }
    
}
