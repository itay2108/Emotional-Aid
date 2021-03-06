//
//  PremiumPrompt.swift
//  Emotional Aid
//
//  Created by itay gervash on 15/11/2021.
//

import UIKit
import SnapKit
import StoreKit

protocol PremiumViewDelegate {
    func premiumViewShouldDismiss(withSuccess transactionSuccess: Bool)
    
    func premiumViewShouldCloseFromXButton()
}

extension UIViewController: PremiumViewDelegate {
    
    @objc func premiumViewShouldDismiss(withSuccess transactionSuccess: Bool) {
        premiumDismiss(success: transactionSuccess)
    }
    
    func premiumViewShouldCloseFromXButton() {
        for view in self.view.subviews {
            if view.tag == 363 {
                if let premiumView = view as? SKPaymentTransactionObserver {
                    SKPaymentQueue.default().remove(premiumView)
                }
                view.removeFromSuperview()
            }
        }
    }
    
    var isPremiumDisplayed: Bool {
        get {
            for view in self.view.subviews {
                if view.tag == 363 { return true }
            }
            return false
        }
    }
    
    func premiumDisplay() {
        
        lazy var premiumTinter: UIView = {
           let view = UIView()
            view.backgroundColor = .black.withAlphaComponent(0.4)
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(premiumDismiss)))
            view.tag = 363
            return view
        }()
        
        lazy var premium: PremiumView = {
            let view = PremiumView()
            view.delegate = self
            view.priceLabel.text = "---/год"
            view.tag = 363
            return view
        }()
        
        self.view.addSubview(premiumTinter)
        self.view.addSubview(premium)
        
        premiumTinter.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        premium.snp.makeConstraints { make in
            make.width.equalTo(332 * widthModifier)
            make.height.equalTo(558 * heightModifier) 
            make.center.equalToSuperview()
        }
    }
    
    @objc func premiumDismiss(success: Bool) {
        guard isPremiumDisplayed else { textLog.write("failed to dismiss premium as it is not currently shown"); return }
        
        for view in self.view.subviews {
            if view.tag == 363 {
                if let premiumView = view as? SKPaymentTransactionObserver {
                    SKPaymentQueue.default().remove(premiumView)
                }
                view.removeFromSuperview()
            }
        }
        
        if !success {
            handleTransactionFail()
        }
        
    }
    
    @objc func handleTransactionFail() {
        let errorAlert = UIAlertController(title: "Не удалось завершить процесс покупки. Если вы уже приобретали подписку, попробуйте восстановить покупку", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Пропустить", style: .cancel) { (action) in
        }

        let restoreAction = UIAlertAction(title: "восстановить покупки", style: .default) { action in
            SKPaymentQueue.default().restoreCompletedTransactions()
        }

        errorAlert.addAction(action)
        errorAlert.addAction(restoreAction)
        self.present(errorAlert, animated: true)
    }
    
}
