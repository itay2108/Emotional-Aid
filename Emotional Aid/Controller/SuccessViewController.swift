//
//  SuccessViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 23/07/2021.
//

import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var firstScore: Int?
    var lastScore: Int?
    var finishCondition: FinishCondition
    
    private lazy var navContainer: UIView  = {
        return Container()
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(K.uikit.xButton?.withTintColor(.white), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "chevron.left")?.withTintColor(.white), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        button.tintColor = .white
        button.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var mainTitle: UILabel    = {
       let label = UILabel()
        label.font = FontTypes.shared.h1.withSize(56 * heightModifier)
        label.textColor = .white
        label.textAlignment = .center
        label.textSpacing(of: 5)
        
        label.text = "УРА!"
        return label
    }()
    
    private lazy var mainArtwork: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = K.uikit.successArt
        return view
    }()
    
    private lazy var successDescription: UITextView = {
        let textView = UITextView()
        textView.font = FontTypes.shared.ubuntu.withSize(13 * heightModifier)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.backgroundColor = .black.withAlphaComponent(0.12)
        textView.roundCorners(.allCorners, radius: 15)
        textView.textAlignment = .center
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        textView.isScrollEnabled = true
        textView.text = K.text.failDidNotHelpDescription
        return textView
    }()
    
    private lazy var consultButton: UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.white), for: .normal)
        
        button.setTitle("Завершить практику", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(K.colors.appText, for: .normal)
        
        button.addTarget(self, action: #selector(consultButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.gradientBackground(colors: [K.colors.appBlue!.cgColor, K.colors.appBlueDark!.cgColor], type: .radial, direction: .topToBottom)
        
        setUpUI()
        
    }
    
    func setUpUI() {
        addSubviews()
        addConstraintsToSubviews()
        setContentAccordingToFinishCondition()
    }
    
    func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(closeButton)
        navContainer.addSubview(backButton)
        
        view.addSubview(mainTitle)
        view.addSubview(mainArtwork)
        view.addSubview(successDescription)
        
        view.addSubview(consultButton)
    }
    
    func addConstraintsToSubviews() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(64 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(20 * heightModifier)
            make.width.equalTo(20 * heightModifier)
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(closeButton.snp.right).offset(32)
            make.height.equalTo(22 * heightModifier)
            make.width.equalTo(20 * heightModifier)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(navContainer.snp.bottom).offset(16 * heightModifier)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(64 * heightModifier)
            make.height.equalTo(72 * heightModifier)
        }
        
        mainArtwork.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.63)
            make.height.equalTo(mainArtwork.snp.width).multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitle.snp.bottom).offset(36 * heightModifier)
        }
        
        consultButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(24 + view.safeAreaSize(from: .bottom)))
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.right.equalToSuperview().offset(-28 * widthModifier)
            make.height.equalTo(56 * heightModifier)
        }
        
        successDescription.snp.makeConstraints { make in
            make.top.equalTo(mainArtwork.snp.bottom).offset(36 * heightModifier)
            make.width.equalTo(consultButton)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(consultButton.snp.top).offset(-48 * heightModifier)
        }
        
    }
    
    func setContentAccordingToFinishCondition() {
        guard firstScore != nil && lastScore != nil
        else { textLog.write("unexpectedly gound nil while unwrapping exercise scores for success text."); return }
        
        mainArtwork.image = K.uikit.successArt
        
        switch finishCondition {
        case .successBecamePositive:
            successDescription.text = K.text.successBecamePositiveDescription
        case .successBecameNegative:
            successDescription.text = K.text.successBecameNegativeDescription
        case .success:
            successDescription.text = "\(K.text.successDescriptionA)\(firstScore!)\(K.text.successDescriptionB)\( lastScore!)\(K.text.successDescriptionC)"
        default:
            successDescription.text = ""
        }
    }
    
    //MARK: - button selectors
    
    @objc func closeButtonPressed(_ button: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backButtonPressed(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func consultButtonPressed(_ button: UIButton) {
//        let destination = ConsultationFormViewController()
//        destination.delegate = self
//        self.present(destination, animated: true)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    //MARK: - inits
    
    init(success reason: FinishCondition, first score: Int? = nil, lastScore: Int? = nil) {
        self.finishCondition = reason
        self.firstScore = score
        self.lastScore = lastScore
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.finishCondition = .failDidNotHelp
        super.init(coder: aDecoder)
    }
}

extension SuccessViewController: ConsultationFormViewControllerDelegate {
    func didSuccessfullySendRequest() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
