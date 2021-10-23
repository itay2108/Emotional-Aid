//
//  RecommendationViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 20/10/2021.
//

import UIKit
import SnapKit
import Gifu

class RecommendationViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
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
    
    private lazy var mainLogo: GIFImageView = {
       let view = GIFImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Пара советов"
        label.font = FontTypes.shared.h2.withSize(30 * heightModifier)
        label.textColor = K.colors.appText
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mainDescription: UITextView = {
        let textView = UITextView()
        textView.font = FontTypes.shared.ubuntu.withSize(13 * heightModifier)
        textView.textColor = K.colors.appText ?? .darkGray
        textView.backgroundColor = .black.withAlphaComponent(0.04)
        textView.roundCorners(.allCorners, radius: 15)
        textView.textAlignment = .center
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        textView.isScrollEnabled = true
        textView.text = K.text.recommendationDescription
        return textView
    }()
    
    private lazy var mainButton: UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(K.colors.appBlue ?? .systemTeal), for: .normal)
        
        button.setTitle("Понятно, давайте начнем", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(mainButtonPressed(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        
        addSubviews()
        setConstraints()
        
        mainLogo.animate(withGIFNamed: "reco")

    }
    
    func addSubviews() {
        
        view.addSubview(navContainer)
        navContainer.addSubview(backButton)
        
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
        view.addSubview(mainDescription)
        view.addSubview(mainButton)
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
            make.width.equalTo(128 * widthModifier)
            make.height.equalTo(mainLogo.snp.width)
            make.centerX.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainLogo.snp.bottom).offset(18 * heightModifier)
            make.left.equalToSuperview().offset(64 * widthModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(mainTitle.font.pointSize.percentage(110))
        }
        
        mainButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-(24 + view.safeAreaSize(from: .bottom)))
            make.left.equalToSuperview().offset(28 * widthModifier)
            make.right.equalToSuperview().offset(-28 * widthModifier)
            make.height.equalTo(56 * heightModifier)
        }
        
        mainDescription.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(36 * heightModifier)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mainButton.snp.top).offset(-56 * heightModifier)
        }

    }
    
    @objc private func mainButtonPressed(_ button: UIButton) {
        let destination = PracticeViewController()
        destination.hidesBottomBarWhenPushed = true
        destination.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(destination, animated: true)
        
        UserDefaults.standard.set(true, forKey: K.def.recommendationsHaveBeenShown)
        self.mainLogo.stopAnimating()
        
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }

}
