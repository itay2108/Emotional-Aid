//
//  OnboardingViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 09/10/2021.
//

import UIKit
import paper_onboarding
import SnapKit

class OnboardingViewController: UIViewController {
    
    private var currentPage = 0
    private var totalPages = 0
    
    var onboarding: PaperOnboarding?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private var onboardingPages: Int?
    
    private lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = K.uikit.logo
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Давайте Начнем", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(UIImage(named: "button-md"), for: .normal)
        button.isHidden = true
        
        button.addTarget(self, action: #selector(finishButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        initOnboardingObject()
        layoutLogo()
        layoutFinishButton()

    }

    
    func initOnboardingObject() {
        onboarding = PaperOnboarding()
        guard onboarding != nil else { return }
        onboarding!.dataSource = self
        onboarding!.delegate = self
        onboarding!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding!)
        
        onboarding!.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(safeAreaSize(from: .top) + 24 * heightModifier)
            make.left.equalToSuperview().offset(16 * widthModifier)
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.bottom.equalToSuperview().offset(-safeAreaSize(from: .bottom))
        }
        
    }
    
    func layoutLogo() {
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(81 * heightModifier)
            make.width.equalTo(40 * widthModifier)
            make.height.equalTo(logoView.snp.width)
            make.centerX.equalToSuperview()
        }
    }
    
    func layoutFinishButton() {
        self.view.addSubview(finishButton)
        
        finishButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.66)
            make.height.equalTo(finishButton.snp.width).multipliedBy(0.21)
            make.bottom.equalToSuperview().offset(-(safeAreaSize(from: .bottom) + 24) * heightModifier)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func finishButtonPressed() {
        
        SpeechRecognitionManager.main.authorizeSpeechRecognition { success in
            if success {
                print("speech recognition authorized")
            }
            
            AudioManager.shared.requestMicrophoneUsage { success in
                if success {
                    print("microphone usage authorized")
                }
                else {
                    print("microphone usage denied")
                }
                
                DispatchQueue.main.async {
                    let destination = AuthViewController()
                    
                    destination.modalPresentationStyle = .fullScreen
                    destination.modalTransitionStyle = .coverVertical
                    
                    self.navigationController?.pushViewController(destination, animated: true)

                }

            }
        }
    }

}

extension OnboardingViewController: PaperOnboardingDataSource {
    func onboardingItemsCount() -> Int {
        totalPages = 5
        return 5
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let items = [
            OnboardingItemInfo(informationImage: UIImage.gifImageWithName("000") ?? UIImage(),
                               title: "Добро пожаловать!",
                               description: "Свайпеите влево чтобы начать",
                               pageIcon: UIImage(systemName: "arrow.right.circle.fill") ?? UIImage(),
                               color: .white,
                               titleColor: K.colors.appText ?? .darkGray,
                               descriptionColor: K.colors.appText ?? .darkGray,
                               titleFont: FontTypes.shared.h2.withSize(36 * heightModifier),
                               descriptionFont: FontTypes.shared.ubuntu.withSize(14 * heightModifier)),
            
            OnboardingItemInfo(informationImage: UIImage.gifImageWithName("001") ?? UIImage(),
                               title: /*"Добро пожаловать!"*/"Дорогой друг",
                               description: K.text.onboard1,
                               pageIcon: UIImage(systemName: "arrow.right.circle.fill") ?? UIImage(),
                               color: .white,
                               titleColor: K.colors.appBlue ?? .darkGray,
                               descriptionColor: K.colors.appText ?? .darkGray,
                               titleFont: FontTypes.shared.h2.withSize(24 * heightModifier),
                               descriptionFont: FontTypes.shared.ubuntu.withSize(14 * heightModifier)),
            
            OnboardingItemInfo(informationImage: UIImage.gifImageWithName("002") ?? UIImage(),
                               title: "С нами вы получите теоретические и практические знания",
                               description: K.text.onboard2,
                               pageIcon: UIImage(systemName: "arrow.right.circle.fill") ?? UIImage(),
                               color: .white,
                               titleColor: K.colors.appBlue ?? .darkGray,
                               descriptionColor: K.colors.appText ?? .darkGray,
                               titleFont: FontTypes.shared.h2.withSize(24 * heightModifier),
                               descriptionFont: FontTypes.shared.ubuntu.withSize(14 * heightModifier)),
            
            OnboardingItemInfo(informationImage: UIImage.gifImageWithName("003") ?? UIImage(),
                               title: "С нами помощь всегда под рукой",
                               description: K.text.onboard3,
                               pageIcon: UIImage(systemName: "arrow.right.circle.fill") ?? UIImage(),
                               color: .white,
                               titleColor: K.colors.appBlue ?? .darkGray,
                               descriptionColor: K.colors.appText ?? .darkGray,
                               titleFont: FontTypes.shared.h2.withSize(24 * heightModifier),
                               descriptionFont: FontTypes.shared.ubuntu.withSize(14 * heightModifier)),
            
            OnboardingItemInfo(informationImage: UIImage.gifImageWithName("004") ?? UIImage(),
                               title: "С нами вы в безопасности",
                               description: K.text.onboard4,
                               pageIcon: UIImage(systemName: "arrow.right.circle.fill") ?? UIImage(),
                               color: .white,
                               titleColor: K.colors.appBlue ?? .darkGray,
                               descriptionColor: K.colors.appText ?? .darkGray,
                               titleFont: FontTypes.shared.h2.withSize(24 * heightModifier),
                               descriptionFont: FontTypes.shared.ubuntu.withSize(14 * heightModifier)),
        ]
        onboardingPages = items.count
        return items[index]
            
    }
    
}

extension OnboardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        //print(onboardingPages, index)
        if onboardingPages != nil {
            if index == onboardingPages! - 1 {
                finishButton.isHidden = false
            } else {
                finishButton.isHidden = true
            }
        }
        
        currentPage = index
    }
    
}
