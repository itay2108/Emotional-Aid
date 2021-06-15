//
//  ViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let font = FontTypes()
    
    private lazy var navContainer:  UIView      = {
        return Container()
    }()
    
    private lazy var burger:        UIButton    = {
        let button = UIButton()
        button.setBackgroundImage(K.uikit.hamburgerMenuButton, for: .normal)
        return button
    }()
    
    private lazy var logoContainer: UIView      = {
        return Container()
    }()
    
    private lazy var logoView:      UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "logo")
        
        guard image != nil else { return UIImageView() }
        
        view.image = image
        return view
    }()
    
    private lazy var mainTitle:     UILabel     = {
       let title = UILabel()
        title.text = "Emotional\nAid"
        title.numberOfLines = 2
        title.textAlignment = .center
        title.textColor = K.colors.appText
        title.font = font.h1
        return title
    }()
    
    private lazy var ctaContainer:  UIView      = {
       return Container()
    }()
    
    private lazy var sosButton:     UIButton    = {
       let button = SOSButton()
        button.setTitle("SOS", for: .normal)
        button.addTextSpacing(10.0)
        button.addTarget(self, action: #selector(sosButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var ctaTitle:      UILabel     = {
        let label = UILabel()
        label.text = "Начать практику"
        label.font = font.h2.withSize(20)
        
        label.textAlignment = .center
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var slider: EASlider = {
        return EASlider()
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
        view.addSubview(navContainer)
        navContainer.addSubview(burger)
        
        view.addSubview(logoContainer)
        logoContainer.addSubview(logoView)
        logoContainer.addSubview(mainTitle)
        
        view.addSubview(ctaContainer)
        ctaContainer.addSubview(sosButton)
        ctaContainer.addSubview(ctaTitle)
        
        view.addSubview(slider)
    }
    
    private func setConstraints() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(64 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        burger.snp.makeConstraints  { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(36)
            make.width.equalTo(18 * widthModifier)
            make.height.equalTo(burger.snp.width)
        }
        
        logoContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.33)
            make.centerX.equalToSuperview()
            make.top.equalTo(navContainer.snp.bottom).offset(8 * heightModifier)
        }
    
        logoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
            make.width.equalTo(logoView.snp.height)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45).offset(-16 * heightModifier)
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).offset(16 * heightModifier)
        }
        
        ctaContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-self.view.safeAreaSize(from: .bottom))
            make.height.equalToSuperview().multipliedBy(0.33)
        }
        
        sosButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-36 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(sosButton.snp.width).multipliedBy(0.5)
            sosButton.contentEdgeInsets.top = self.view.frame.height / 45
            sosButton.contentEdgeInsets.left = 10
        }
        
        ctaTitle.snp.makeConstraints { make in
            make.bottom.equalTo(sosButton.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(sosButton)
        }
        
        slider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(128)
            make.width.equalToSuperview().multipliedBy(0.66)
        }
    }
    
    
    @objc func sosButtonPressed() {
        let destination = PracticeViewController()
        self.navigationController?.pushViewController(destination, animated: true)
    }

}

