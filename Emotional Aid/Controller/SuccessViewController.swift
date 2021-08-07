//
//  SuccessViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 23/07/2021.
//

import UIKit
import SnapKit

class SuccessViewController: UIViewController {
    
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
        //button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
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
    
    private lazy var successDescription: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.ubuntu.withSize(13 * heightModifier)
        label.textColor = .white
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.textAlignment = .center
        label.sizeToFit()
        label.text = K.text.successDescriptionA
        return label
    }()
    
    private lazy var consultButton: UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.white), for: .normal)
        
        button.setTitle("Записаться на консультацию", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(K.colors.appText, for: .normal)
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
    }
    
    func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(closeButton)
        
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
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(navContainer.snp.bottom).offset(16 * heightModifier)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(64 * heightModifier)
            make.height.equalTo(72 * heightModifier)
        }
        
        mainArtwork.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.66)
            make.height.equalTo(mainArtwork.snp.width).multipliedBy(0.9)
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitle.snp.bottom).offset(48 * heightModifier)
        }
        
        consultButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(24 + view.safeAreaSize(from: .bottom)))
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.right.equalToSuperview().offset(-28 * widthModifier)
            make.height.equalTo(56 * heightModifier)
        }
        
        successDescription.snp.makeConstraints { make in
            make.top.equalTo(mainArtwork.snp.bottom).offset(56 * heightModifier)
            make.width.equalTo(mainArtwork)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(consultButton.snp.top).offset(-56 * heightModifier)
        }
        
    }
    
    func setContentAccordingToFinishCondition() {
        switch finishCondition {
        case .successBecamePositive:
            mainArtwork.image = K.uikit.successArt
            successDescription.text = K.text.successBecamePositiveDescription
        case .successBecameNegative:
            mainArtwork.image = K.uikit.successArt
            successDescription.text = K.text.successBecameNegativeDescription
        case .success:
            mainArtwork.image = K.uikit.successArt
            successDescription.text = "\(K.text.successDescriptionA)\(String(describing: firstScore))\(K.text.successDescriptionB)\(String(describing: lastScore))\(K.text.successDescriptionC)"
        default:
            mainArtwork.image = K.uikit.successArt
            successDescription.text = ""
        }
    }
    
    //MARK: - button selectors
    
    @objc func handleCloseButtonTapped(_ button: UIButton) {
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
