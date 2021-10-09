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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    func initOnboardingObject() {
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        onboarding.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
