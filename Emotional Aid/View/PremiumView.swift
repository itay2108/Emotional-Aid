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
    
//    var products = [SKProduct]()
//    var request: SKProductsRequest!
//
//    var premium: SKProduct?
    
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
        label.font = FontTypes.shared.ubuntu.withSize(15 * heightModifier)
        label.textColor = K.colors.appText
        label.text = "Для продолжения изучения курса и получения доступа к упражнениям требуется годовая подписка\n\nВ разделе «Практика» вы найдёте цикл последовательных упражнений в формате аудиогида и текста.\n\nОни разработаны нейробиологами специально для быстрого выхода из стресса и апатичных или депрессивных состояний.\n\nВесь цикл упражнений не займёт у вас больше 15 минут, но при регулярном повторении научит вашу нервную систему правильно восстанавливаться."
        return label
    }()
    
    lazy var mainButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(K.colors.appBlue ?? UIColor.systemTeal), for: .normal)
        
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
    
//    lazy var mainButtonActivityIndicator: UIActivityIndicatorView = {
//        let av = UIActivityIndicatorView()
//        av.style = .medium
//        av.tintColor = .white
//        av.hidesWhenStopped = true
//        av.startAnimating()
//        return av
//    }()
    
//    lazy var priceLabelActivityIndicator: UIActivityIndicatorView = {
//        let av = UIActivityIndicatorView()
//        av.style = .medium
//        av.hidesWhenStopped = true
//        av.startAnimating()
//        return av
//    }()
    
    //iap menu
    
    lazy var iapMenuContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        return view
    }()
    
    lazy var iapMenuStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.distribution = .equalSpacing
        view.spacing = 18 * heightModifier
        view.axis = .vertical
        return view
    }()
    
    lazy var iapItemPremium1: IAPInfoView = {
        let view = IAPInfoView()
        view.setTitle(to: "1 месяц")
        view.iapID = K.text.proVersionID1Month
        view.delegate = self
        view.snp.makeConstraints { make in
            make.height.equalTo(72 * heightModifier)
        }
        return view
    }()
    
    lazy var iapItemPremium3: IAPInfoView = {
        let view = IAPInfoView()
        view.setTitle(to: "3 месяца")
        view.iapID = K.text.proVersionID3Months
        view.delegate = self
        view.snp.makeConstraints { make in
            make.height.equalTo(72 * heightModifier)
        }
        return view
    }()
    
    lazy var iapItemPremium6: IAPInfoView = {
        let view = IAPInfoView()
        view.setTitle(to: "6 месяцев")
        view.iapID = K.text.proVersionID6Months
        view.delegate = self
        view.snp.makeConstraints { make in
            make.height.equalTo(72 * heightModifier)
        }
        return view
    }()
    
    lazy var iapItemPremium: IAPInfoView = {
        let view = IAPInfoView()
        view.setTitle(to: "1 год")
        view.iapID = K.text.proVersionID1Year
        view.delegate = self
        view.hidesBottomBorder = true
        view.snp.makeConstraints { make in
            make.height.equalTo(72 * heightModifier)
        }
        return view
    }()
    
    lazy var iapMenuDismissButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        //button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(K.colors.appText, for: .normal)
        
        button.addTarget(self, action: #selector(iapMenuDismissPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var iapPaymentProcessUIContainer: UIView = {
        let view = UIView()
         view.backgroundColor = .white
         view.isHidden = true
         return view
    }()
    
        lazy var iapPaymentProcessUIActivityIndicator: UIActivityIndicatorView = {
            let av = UIActivityIndicatorView()
            av.style = .medium
            av.color = K.colors.appText
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
//        requestPremiumIAPData()
    }
    
    private func addSubviews() {
        self.addSubview(closeButton)
        self.addSubview(icon)
        self.addSubview(mainTitle)
        self.addSubview(mainButton)
//        self.addSubview(priceLabel)
//        self.addSubview(mainButtonActivityIndicator)
//        self.addSubview(priceLabelActivityIndicator)
        
        self.addSubview(iapMenuContainer)
        iapMenuContainer.addSubview(iapMenuStackView)
        
        iapMenuStackView.addArrangedSubview(iapItemPremium1)
        iapMenuStackView.addArrangedSubview(iapItemPremium3)
        iapMenuStackView.addArrangedSubview(iapItemPremium6)
        iapMenuStackView.addArrangedSubview(iapItemPremium)
        
        iapMenuContainer.addSubview(iapMenuDismissButton)
        
        iapMenuContainer.addSubview(iapPaymentProcessUIContainer)
        iapPaymentProcessUIContainer.addSubview(iapPaymentProcessUIActivityIndicator)
        
    }
    
//    func requestPremiumIAPData() {
//        let request = SKProductsRequest(productIdentifiers: ["ru.letaem_bez_straha.emotional_aid.premium"])
//        request.delegate = self
//        request.start()
//    }
    
    private func addConstraintsToSubviews() {
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(icon).offset(-4)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.height.equalTo(16 * heightModifier)
            make.width.equalTo(16 * heightModifier)
        }
        
        icon.snp.makeConstraints { make in
            make.width.equalTo(36 * heightModifier)
            make.height.equalTo(icon.snp.width)
            make.top.equalToSuperview().offset(28 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(14 * heightModifier)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.bottom.equalTo(mainButton.snp.top).offset(-18 * heightModifier)
        }
        
        mainButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.82)
            make.centerX.equalToSuperview()
            make.height.equalTo(50 * heightModifier)
        }
        
//        priceLabel.snp.makeConstraints { make in
//            make.bottom.equalToSuperview().offset(-24 * heightModifier)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(mainButton).multipliedBy(0.8)
//        }
        
//        mainButtonActivityIndicator.snp.makeConstraints { make in
//            make.center.equalTo(mainButton)
//        }
        
//        priceLabelActivityIndicator.snp.makeConstraints { make in
//            make.center.equalTo(priceLabel)
//        }
        
        iapMenuContainer.snp.makeConstraints { make in
            make.top.equalTo(mainTitle)
            make.left.equalTo(mainButton)
            make.right.equalTo(mainButton)
            make.bottom.equalTo(mainButton).offset(8 * heightModifier)
        }
        
        iapMenuStackView.snp.makeConstraints { make in
            
            make.left.equalToSuperview().offset(18 * widthModifier)
            make.right.equalToSuperview().offset(-18 * widthModifier)
            make.centerY.equalToSuperview().offset(-12 * heightModifier)
        }
        
        iapMenuDismissButton.snp.makeConstraints { make in
            make.edges.equalTo(mainButton)
        }
        
        iapPaymentProcessUIContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(iapMenuDismissButton.snp.top)
        }
        
        iapPaymentProcessUIActivityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
        
        iapMenuContainer.isHidden = false
        
//        guard SKPaymentQueue.canMakePayments() else { textLog.write("can't make payments"); return }
//        guard premium != nil else { textLog.write("failed to fetch product before SKPayment request"); return }
//
//        mainButton.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.lightGray), for: .normal)
//        mainButton.setTitle("", for: .normal)
//        mainButtonActivityIndicator.startAnimating()
//
//        let paymentResuest = SKMutablePayment()
//        paymentResuest.productIdentifier = K.text.proVersionID1Year
//
//        SKPaymentQueue.default().add(paymentResuest)
    }
    
    @objc func iapMenuDismissPressed(_ button: UIButton) {
        iapMenuContainer.isHidden = true
    }
    
    @objc func closeButtonPressed(_ button: UIButton) {
        SKPaymentQueue.default().remove(self)
        delegate?.premiumViewShouldCloseFromXButton()
    }
    

}

extension PremiumView: IAPInfoViewDelegate {
    func iapInfoView(didTapPurchaseWith id: String) {
        guard SKPaymentQueue.canMakePayments() else { textLog.write("can't make payments"); return }
        print("selected purchase id:", id)
        
        iapPaymentProcessUIContainer.isHidden = false
        iapPaymentProcessUIActivityIndicator.startAnimating()
        let paymentResuest = SKMutablePayment()
        paymentResuest.productIdentifier = id
        
        SKPaymentQueue.default().add(paymentResuest)
    }
    
    
}

extension PremiumView: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                //purchased
                SKPaymentQueue.default().finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "premium")
                iapPaymentProcessUIContainer.isHidden = true
                iapPaymentProcessUIActivityIndicator.stopAnimating()
                textLog.write("purchase successful")

                
                DispatchQueue.main.async {
//                    self.mainButtonActivityIndicator.stopAnimating()
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
                    
                    textLog.write("error in transaction completion: \(safeError)")
                    self.delegate?.premiumViewShouldDismiss(withSuccess: false)

                }
            }
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        self.delegate?.premiumViewShouldDismiss(withSuccess: false)
        textLog.write("couldn't restore purchases: \(error)")
    }
}

//extension PremiumView: SKProductsRequestDelegate {
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        if !response.products.isEmpty {
//           products = response.products
//           premium = products.first
//
//            if let localPrice = premium?.localizedPrice {
//
//                DispatchQueue.main.async {
//
////                    self.priceLabelActivityIndicator.stopAnimating()
////                    self.mainButtonActivityIndicator.stopAnimating()
////                    self.priceLabel.isHidden = false
////                    self.priceLabel.text = "\(localPrice)/год"
//                    self.mainButton.setBackgroundImage(UIImage(named: "button-md"), for: .normal)
//
//                }
//
//            }
//
//        }
//
//        for invalidIdentifier in response.invalidProductIdentifiers {
//           // Handle any invalid product identifiers as appropriate.
//            textLog.write("invalid product identifier: \(invalidIdentifier)")
//        }
//    }
//}



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
