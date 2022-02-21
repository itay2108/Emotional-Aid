//
//  ProfileViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 04/09/2021.
//

import UIKit
import StoreKit
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
        label.font = FontTypes.shared.h4.withSize(21 * heightModifier)
        label.text = "Профиль"
        label.textSpacing(of: 2)
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var profileChevronLeft: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .lightGray
        return view
    }()
    
    private lazy var profileButton: UIButton    = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        button.setImage(getProfilePic(), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.adjustsImageWhenHighlighted = false
        
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(profileButtonTapped(_:)), for: .touchDragExit)

        return button
    }()
    
    private lazy var profileChevronRight: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .lightGray
        return view
    }()
    
    private lazy var userNameLabel: UITextField         = {
        let tf = UITextField()
        tf.delegate = self
        tf.isUserInteractionEnabled = true
        tf.textAlignment = .center
        tf.font = FontTypes.shared.ubuntuMedium.withSize(24 * heightModifier)
        tf.autocapitalizationType = .words
        
        tf.attributedPlaceholder = NSAttributedString(string: "Ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        tf.textColor = K.colors.appText
        return tf
    }()
    
    private lazy var userNameLabelEditIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "pencil.circle.fill")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = def.string(forKey: K.def.name) != nil ? K.colors.appText : .lightGray
        return view
    }()
    
    private lazy var profileSettingStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .equalSpacing
        //sv.spacing = 10 * heightModifier
        return sv
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
    
    private lazy var helpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Мне нужна помощь", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(helpButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Восстановить покупки", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(restorePurchasesButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var termsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Условия использования", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(termsButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Политика конфиденциальности", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(privacyPolicyButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var mentalHelathResourcesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Ресурсы психического здоровья", for: .normal)
        button.setTitleColor(K.colors.appText, for: .normal)
        button.titleLabel?.font = FontTypes.shared.h4.withSize(16 * heightModifier)
        
        button.addTarget(self, action: #selector(mentalHealthResourcesButtonPressed(_:)), for: .touchUpInside)
        return button
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
        label.font = FontTypes.shared.ubuntuLight.withSize(12 * heightModifier)
        label.text = "расскажите вашим друзьям о нашем приложении"
        label.textColor = K.colors.appText
        
        if !emotionalAid.canOpenURL(messengerSharingURL()) && !emotionalAid.canOpenURL(whatsappSharingURL()) && !emotionalAid.canOpenURL(telegramSharingURL()) {
            label.isHidden = true
        }
        
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
        
        button.isHidden = emotionalAid.canOpenURL(messengerSharingURL()) ? false : true
        
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
        
        button.isHidden = emotionalAid.canOpenURL(telegramSharingURL()) ? false : true
        
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
        
        button.isHidden = emotionalAid.canOpenURL(whatsappSharingURL()) ? false : true
        
        button.addTarget(self, action: #selector(shareToWhatsapp(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpUI()
        setUpObservers()
        
        SKPaymentQueue.default().add(self)
        
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = def.string(forKey: K.def.name) {
            userNameLabel.text = username
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if !UIApplication.isDeveloperModeEnabled() {
            sendLogsButton.isHidden = true
            profileSettingStackView.arrangedSubviews[profileSettingStackView.arrangedSubviews.count - 2].isHidden = true
        }
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        
        addSubviews()
        addConstraintsToSubviews()
        
        setupToHideKeyboardOnTapOnView()
    }
    
    private func addSubviews() {
        view.addSubview(headTitle)
        
        view.addSubview(profileChevronLeft)
        view.addSubview(profileButton)
        view.addSubview(profileChevronRight)
        
        view.addSubview(userNameLabel)
        view.addSubview(userNameLabelEditIcon)
        
        view.addSubview(profileSettingStackView)
        profileSettingStackView.addArrangedSubview(consultationButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(helpButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(restorePurchasesButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(termsButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(privacyPolicyButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(mentalHelathResourcesButton)
        profileSettingStackView.addArrangedSubview(Scribble().random())
        profileSettingStackView.addArrangedSubview(sendLogsButton)

        
        view.addSubview(socialSV)
        socialSV.addArrangedSubview(messengerButton)
        socialSV.addArrangedSubview(whatsappButton)
        socialSV.addArrangedSubview(telegramButton)
        
        if socialSV.arrangedSubviews.count > 0 { view.addSubview(socialDescription) }
        
    }
    
    private func addConstraintsToSubviews() {
        headTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        profileChevronLeft.snp.makeConstraints { make in
            make.height.equalTo(16 * heightModifier)
            make.width.equalTo(profileChevronLeft.snp.height)
            make.centerY.equalTo(profileButton)
            make.right.equalTo(profileButton.snp.left).offset(4.5 * widthModifier)
        }
        
        profileButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-9 * widthModifier)
            make.top.equalTo(headTitle.snp.bottom).offset(18 * heightModifier)
            make.height.equalTo(116 * heightModifier)
            make.width.equalTo(profileButton.snp.height)
        }
        
        profileChevronRight.snp.makeConstraints { make in
            make.height.equalTo(16 * heightModifier)
            make.width.equalTo(profileChevronRight.snp.height)
            make.centerY.equalTo(profileButton)
            make.left.equalTo(profileButton.snp.right).offset(9 * widthModifier)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileButton.snp.bottom).offset(10 * heightModifier)

        }
        
        userNameLabelEditIcon.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.right)
            make.centerY.equalTo(userNameLabel).offset(2 * heightModifier)
            make.height.equalTo(userNameLabel).multipliedBy(0.45)
            make.width.equalTo(userNameLabel.snp.height)
        }
        
        profileSettingStackView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(48 * heightModifier)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(56 * widthModifier)
            make.bottom.equalTo(socialDescription.snp.top).offset(-56 * heightModifier)
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
    
    func getProfilePic() -> UIImage? {
        let image: UIImage?
        if Personality.main.gender == .female {
            image = UIApplication.isPremiumAvailable() ? K.uikit.profileFemalePremium : K.uikit.profileFemale
        } else {
            image = UIApplication.isPremiumAvailable() ? K.uikit.profileMalePremium : K.uikit.profileMale
        }
        
        return image
    }
    
    
    //MARK: - selectors
    
    @objc private func profileButtonTapped(_ button: UIButton) {
        Personality.main.gender = Personality.main.gender == .female ? .male : .female
        Vibration.selection.vibrate()
    }
    
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
            textLog.write("cannot send email")
            
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
                    textLog.write("error signing out")
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
    
    @objc private func restorePurchasesButtonPressed(_ button: UIButton) {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    @objc private func termsButtonPressed(_ button: UIButton) {
//        if let url = URL(string: "https://www.termsfeed.com/live/bea204aa-97d8-4c50-9212-9729152fdeac") {
//            UIApplication.shared.open(url)
//        }
        if let url = URL(string: "https://letaem-bez-straha.ru/terms/") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func privacyPolicyButtonPressed(_ button: UIButton) {
//        if let url = URL(string: "https://www.termsfeed.com/live/ccde8341-7f81-4a68-ae1f-badf6420695d") {
//            UIApplication.shared.open(url)
//        }
        if let url = URL(string: "https://letaem-bez-straha.ru/politika/") {
            UIApplication.shared.open(url)
        }
        
    }
    
    @objc private func mentalHealthResourcesButtonPressed(_ button: UIButton) {
        if let url = URL(string: "https://www.telegra.ph/Mental-Health-Resources-11-29") {
            UIApplication.shared.open(url)
        }
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
    
    //MARK: - observers
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleGenderDidChange), name: NSNotification.Name.GenderDidChange, object: nil)
    }
    
    @objc private func handleGenderDidChange() {
        profileButton.setImage(getProfilePic(), for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        SKPaymentQueue.default().remove(self)
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

extension ProfileViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .restored {
               
                let alert = UIAlertController(title: "ваши покупки были успешно восстановлены", message: "", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Пропустить", style: .cancel)
                alert.addAction(dismissAction)
                
                UserDefaults.standard.set(true, forKey: "premium")
                
                present(alert, animated: true)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("restoreCompletedTransactionsFailedWithError")
        let alert = UIAlertController(title: "Не удалось восстановить покупки", message: "\(error)", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Пропустить", style: .cancel)
        alert.addAction(dismissAction)
        
        self.present(alert, animated: true)
    }
    
}



extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil && textField.text != "" {
            def.set(textField.text, forKey: K.def.name)
        } else {
            textField.text = def.string(forKey: K.def.name)
        }
        
        userNameLabelEditIcon.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameLabelEditIcon.snp.remakeConstraints { make in
            make.left.equalTo(userNameLabel.snp.right)
            make.centerY.equalTo(userNameLabel).offset(2 * heightModifier)
            make.height.equalTo(userNameLabel).multipliedBy(0.6)
            make.width.equalTo(userNameLabel.snp.height)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        Vibration.selection.vibrate()
        
        textField.attributedPlaceholder = NSAttributedString(string: textField.text ?? "Ваше имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.text = nil
        
        userNameLabelEditIcon.isHidden = true
    }
}
