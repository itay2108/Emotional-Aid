//
//  ProfileViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 04/09/2021.
//

import UIKit
import SnapKit
import MessageUI
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let def = UserDefaults.standard
    
    private var sharingMessage: String = K.text.socialMediaSharingMessage
    
    private lazy var headTitle: UILabel         = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = FontTypes.shared.h4.withSize(22 * heightModifier)
        label.text = "Профиль"
        label.textSpacing(of: 2)
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var profileImage: UIImageView    = {
        let view = UIImageView()
        view.image = UIImage(named: "profile-artwork")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var userNameLabel: UILabel         = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FontTypes.shared.ubuntuMedium.withSize(20 * heightModifier)
        
        if let username = def.string(forKey: K.def.name) {
            label.text = username
        } else if let email = def.string(forKey: K.def.email) {
            label.text = email
        }
        
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var consultationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Записаться на консультацию", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(consultButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var line1: UIImageView = {
        return Scribble().random()
    }()
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Мне нужна помощь", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(helpButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var line2: UIImageView = {
        return Scribble().random()
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Выход из аккаунта", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(logoutButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var line3: UIImageView = {
        return Scribble().random()
    }()
    
    private lazy var sendLogsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Send Logs", for: .normal)
        button.setTitleColor(K.colors.appRed, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(sendLogsButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var socialDescription: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = FontTypes.shared.ubuntuLight.withSize(14 * heightModifier)
        label.text = "расскажите вашим друзьям"
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var socialSV: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.spacing = 22 * widthModifier
        return sv
    }()
    
    private lazy var messengerButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = .clear
         button.setImage(UIImage(named: "i-messenger"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
         button.contentVerticalAlignment = .fill
         button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(shareToMessenger(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var telegramButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = .clear
         button.setImage(UIImage(named: "i-telegram"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
         button.contentVerticalAlignment = .fill
         button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(shareToTelegram(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var whatsappButton: UIButton = {
        let button = UIButton()
         button.backgroundColor = .clear
         button.setImage(UIImage(named: "i-whatsapp"), for: .normal)
         button.imageView?.contentMode = .scaleAspectFit
         button.contentVerticalAlignment = .fill
         button.contentHorizontalAlignment = .fill
        
        button.addTarget(self, action: #selector(shareToWhatsapp(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
        setNeedsStatusBarAppearanceUpdate()

    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        
        addSubviews()
        addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(headTitle)
        
        view.addSubview(profileImage)
        view.addSubview(userNameLabel)
        
        view.addSubview(consultationButton)
        view.addSubview(line1)
        view.addSubview(helpButton)
        view.addSubview(line2)
        view.addSubview(logoutButton)
        view.addSubview(line3)
        view.addSubview(sendLogsButton)
        
        view.addSubview(socialSV)
        if emotionalAid.canOpenURL(messengerSharingURL()) { socialSV.addArrangedSubview(messengerButton) }
        if emotionalAid.canOpenURL(whatsappSharingURL()) { socialSV.addArrangedSubview(whatsappButton) }
        if emotionalAid.canOpenURL(telegramSharingURL()) { socialSV.addArrangedSubview(telegramButton) }

        if socialSV.arrangedSubviews.count > 0 { view.addSubview(socialDescription) }
        
    }
    
    private func addConstraintsToSubviews() {
        headTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        profileImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headTitle.snp.bottom).offset(42 * heightModifier)
            make.height.equalTo(128 * heightModifier)
            make.width.equalTo(profileImage.snp.height)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(18 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.75)
            
            if def.string(forKey: K.def.name) == nil && def.string(forKey: K.def.email) == nil {
                make.height.equalTo(0)
            }
        }
        
        consultationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(56 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(48 * heightModifier)
        }
        
        line1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(consultationButton.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(8 * heightModifier)
        }
        
        helpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(line1.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(48 * heightModifier)
        }
        
        line2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(helpButton.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(8 * heightModifier)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(line2.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(48 * heightModifier)
        }
        
        line3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoutButton.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(8 * heightModifier)
        }
        
        sendLogsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(line3.snp.bottom)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(48 * heightModifier)
        }
        
        socialSV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(22 * heightModifier)
            make.bottom.equalToSuperview().offset(-(24 + view.safeAreaSize(from: .bottom)))
        }
        
        if emotionalAid.canOpenURL(messengerSharingURL()) {
            messengerButton.snp.makeConstraints { make in
                make.width.equalTo(22 * widthModifier)
            }
        }
        
        if emotionalAid.canOpenURL(telegramSharingURL()) {
            telegramButton.snp.makeConstraints { make in
                make.width.equalTo(22 * widthModifier)
            }
        }
        
        if emotionalAid.canOpenURL(whatsappSharingURL()) {
            whatsappButton.snp.makeConstraints { make in
                make.width.equalTo(22 * widthModifier)
            }
        }
        
        socialDescription.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(socialSV.snp.top).offset(-18 * heightModifier)
        }
    }
    
  
    //MARK: - selectors
    
    @objc private func consultButtonPressed(_ button: UIButton) {
        self.present(ConsultationFormViewController(), animated: true)
    }
    
    @objc private func helpButtonPressed(_ button: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            
            let emailRecepients = ["emotionalaidapp@gmail.com"]
            
            let contactFormMessage = "Здравствуйте, мне нужна помощь с"
            
            let mc = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            mc.setToRecipients(emailRecepients)
            mc.setSubject("Emotional Aid help needed")
            mc.setMessageBody(contactFormMessage, isHTML: false)
            self.present(mc, animated: true)
        } else {
            //cant send mail handled here
            print("cannot send email")
            
        }
    }
    
    @objc private func logoutButtonPressed(_ button: UIButton) {
        
        let alertTitle = "Вы уверены, что хотите выйти?"
        let logoutAction = UIAlertAction(title: "Да", style: .destructive) { action in
            if Auth.auth().currentUser != nil {
                do {
                    try Auth.auth().signOut()
                    self.def.removeObject(forKey: K.def.name)
                    self.def.removeObject(forKey: K.def.email)
                    self.def.removeObject(forKey: K.def.password)
                } catch {
                    print("error signing out")
                    return
                }
                
                self.dismiss(animated: true) {
                    UIApplication.shared.windows.first?.rootViewController = NavigationController(rootViewController: AuthViewController())
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        present(alert, animated: true)
        
    }
    
    //MARK: - sharing functions
    
    private func messengerSharingURL(with message: String? = nil) -> URL {
        if message != nil {
            let urlFormattedMessage = message!.replacingOccurrences(of: " ", with: "%20")
            
            if let url = URL(string: "fb-messenger://share?text=\(urlFormattedMessage)") {
                return url
            }
        }
        
        return URL(string: "fb-messenger://")!
    }
    
    @objc private func shareToMessenger(_ button: UIButton) {
        emotionalAid.open(messengerSharingURL(with: sharingMessage))
    }
    
    private func telegramSharingURL(with message: String? = nil) -> URL {
        if message != nil {
            let urlFormattedMessage = message!.replacingOccurrences(of: " ", with: "%20")
            
            if let url = URL(string: "tg://msg?text=\(urlFormattedMessage)") {
                return url
            }
        }
        
        return URL(string: "tg://")!
    }
    
    @objc private func shareToTelegram(_ button: UIButton) {
        emotionalAid.open(telegramSharingURL(with: sharingMessage))
    }
    
    private func whatsappSharingURL(with message: String? = nil) -> URL {
        if message != nil {
            let urlFormattedMessage = message!.replacingOccurrences(of: " ", with: "%20")
            
            if let url = URL(string: "whatsapp://send?text=\(urlFormattedMessage)") {
                return url
            }
        }
        
        return URL(string: "whatsapp://")!
    }
    
    @objc private func shareToWhatsapp(_ button: UIButton) {
        emotionalAid.open(whatsappSharingURL(with: sharingMessage))
    }
    
    //MARK: - logging functions
    
    @objc private func sendLogsButtonPressed(_ button: UIButton) {
        sendLogs()
    }
    
    private func sendLogs() {
        if MFMailComposeViewController.canSendMail() {
            guard textLog.path != nil else { print("error: unexpectedly found nil while fetching textlog URL"); return }
            guard let logData = NSData(contentsOf: textLog.path!) else { print("error: error getting NSData from log.txt"); return }
            
            let emailRecepients = ["emotionalaidapp@gmail.com"]
            
            let mc = MFMailComposeViewController()
            
            mc.mailComposeDelegate = self
            mc.setToRecipients(emailRecepients)
            mc.setSubject("Emotional Aid Consultation Request")
            mc.addAttachmentData(logData as Data, mimeType: "text/txt", fileName: "log.txt")
            self.present(mc, animated: true)
        } else {
            //cant send mail handled here
            print("error: cannot send emails")
        }
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true)
    }
}
