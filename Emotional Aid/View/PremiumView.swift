//
//  PremiumView.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/11/2021.
//

import UIKit
import StoreKit
import FirebaseAuth
import FirebaseFirestore

class PremiumView: UIView {
    
    var delegate: PremiumViewDelegate?
    
    var products = [SKProduct]()
    var request: SKProductsRequest!
    
    var premium: SKProduct?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(K.uikit.xButton?.withTintColor(.lightGray), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var icon: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = K.uikit.premiumIcon
        return view
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.minimumScaleFactor = 2
        label.textAlignment = .center
        label.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        label.textColor = K.colors.appText
        label.text = "Для продолжения изучения курса и получения доступа к упражнениям требуется годовая подписка"
        return label
    }()
    
    lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.lightGray), for: .normal)
        
        button.setTitle("Подписаться", for: .normal)
        button.titleLabel?.font = FontTypes.shared.h3.withSize(18 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(mainButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var priceLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = FontTypes.shared.h3.withSize(14 * heightModifier)
        label.textColor = K.colors.appText
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.isHidden = true
        return label
    }()
    
    lazy var mainButtonActivityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .medium
        av.tintColor = .white
        av.hidesWhenStopped = true
        return av
    }()
    
    lazy var priceLabelActivityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .medium
        av.hidesWhenStopped = true
        av.startAnimating()
        return av
    }()
    
    private func setUpView() {
        self.roundCorners(.allCorners, radius: 7 * heightModifier)
        self.backgroundColor = .white
        
        addSubviews()
        addConstraintsToSubviews()
        
        SKPaymentQueue.default().add(self)
        requestPremiumIAPData()
    }
    
    private func addSubviews() {
        self.addSubview(closeButton)
        self.addSubview(icon)
        self.addSubview(mainTitle)
        self.addSubview(mainButton)
        self.addSubview(priceLabel)
        self.addSubview(mainButtonActivityIndicator)
        self.addSubview(priceLabelActivityIndicator)
    }
    
    func requestPremiumIAPData() {
        let request = SKProductsRequest(productIdentifiers: ["ru.letaem_bez_straha.emotional_aid.premium"])
        request.delegate = self
        request.start()
    }
    
    private func addConstraintsToSubviews() {
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(icon).offset(-8)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.height.equalTo(16 * heightModifier)
            make.width.equalTo(16 * heightModifier)
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(36 * heightModifier)
            make.height.equalTo(icon.snp.width)
            make.top.equalToSuperview().offset(24 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(18 * heightModifier)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(36 * widthModifier)
        }
        
        mainButton.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(28 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(50 * heightModifier)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainButton.snp.bottom).offset(16 * heightModifier)
            make.width.equalTo(mainButton).multipliedBy(0.8)
        }
        
        mainButtonActivityIndicator.snp.makeConstraints { make in
            make.center.equalTo(mainButton)
        }
        
        priceLabelActivityIndicator.snp.makeConstraints { make in
            make.center.equalTo(priceLabel)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUpView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUpView()
    }
    
    @objc func mainButtonPressed(_ button: UIButton) {
        guard SKPaymentQueue.canMakePayments() else { textLog.write("can't make payments"); return }
        guard premium != nil else { textLog.write("failed to fetch product before SKPayment request"); return }
        
        mainButton.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.lightGray), for: .normal)
        mainButton.setTitle("", for: .normal)
        mainButtonActivityIndicator.startAnimating()
        
        let paymentResuest = SKMutablePayment()
        paymentResuest.productIdentifier = K.text.proVersionID
        
        SKPaymentQueue.default().add(paymentResuest)
    }
    
    @objc func closeButtonPressed(_ button: UIButton) {
        SKPaymentQueue.default().remove(self)
        delegate?.premiumViewShouldDismiss(withSuccess: false)
    }
    

}

extension PremiumView: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased || transaction.transactionState == .restored {
                //purchased
                SKPaymentQueue.default().finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "premium")
                
                textLog.write("purchase successful")

                DispatchQueue.main.async {
                    self.mainButtonActivityIndicator.stopAnimating()
                    self.delegate?.premiumViewShouldDismiss(withSuccess: true)
                    
                    if let delegateAsVC = self.delegate as? UIViewController {
                        let successAlert = UIAlertController(title: "Покупка успешно завершена", message: "Теперь у вас есть доступ ко всем частям приложения", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Пропустить", style: .cancel) { (action) in
                        }
                        
                        successAlert.addAction(action)
                        delegateAsVC.present(successAlert, animated: true)
                    }
                }
                
            } else if transaction.transactionState == .failed || transaction.transactionState == .deferred {
                //failed
                if let safeError = transaction.error?.localizedDescription {

                    DispatchQueue.main.async {
                        self.mainButtonActivityIndicator.stopAnimating()
                        self.delegate?.premiumViewShouldDismiss(withSuccess: false)
                        
                        if let delegateAsVC = self.delegate as? UIViewController {
                            let errorAlert = UIAlertController(title: "Не удалось завершить процесс покупки./n/nЕсли вы уже приобретали подписку, попробуйте восстановить покупку", message: "\(safeError)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Пропустить", style: .cancel) { (action) in
                            }
                            
                            let restoreAction = UIAlertAction(title: "восстановить покупки", style: .default) { action in
                                SKPaymentQueue.default().restoreCompletedTransactions()
                            }
                            
                            errorAlert.addAction(action)
                            errorAlert.addAction(restoreAction)
                            delegateAsVC.present(errorAlert, animated: true)
                        }
                    }
                }
            }
        }
        
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("restore completed")
        self.delegate?.premiumViewShouldDismiss(withSuccess: true)
        
        if let delegateAsVC = self.delegate as? UIViewController {
            let successAlert = UIAlertController(title: "Покупка успешно восстановлена", message: "Теперь у вас есть доступ ко всем частям приложения", preferredStyle: .alert)
            let action = UIAlertAction(title: "Пропустить", style: .cancel) { (action) in
            }
            
            successAlert.addAction(action)
            delegateAsVC.present(successAlert, animated: true)
        }
    }
}

extension PremiumView: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if !response.products.isEmpty {
           products = response.products
           premium = products.first
            
            if let localPrice = premium?.localizedPrice {
                
                DispatchQueue.main.async {
                    
                    self.priceLabelActivityIndicator.stopAnimating()
                    self.priceLabel.isHidden = false
                    self.priceLabel.text = "\(localPrice)/год"
                    self.mainButton.setBackgroundImage(UIImage(named: "button-md"), for: .normal)
                    
                }
                DispatchQueue.main.async {
                    
                    //self.activityIndicator.stopAnimating()
                }
                
            }
           
        }

        for invalidIdentifier in response.invalidProductIdentifiers {
           // Handle any invalid product identifiers as appropriate.
            textLog.write("invalid product identifier: \(invalidIdentifier)")
        }
    }
}



extension SKProduct {
    fileprivate static var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }

    var localizedPrice: String {
        if self.price == 0.00 {
            return "Get"
        } else {
            let formatter = SKProduct.formatter
            formatter.locale = self.priceLocale

            guard let formattedPrice = formatter.string(from: self.price) else {
                return "Unknown Price"
            }

            return formattedPrice
        }
    }
}
