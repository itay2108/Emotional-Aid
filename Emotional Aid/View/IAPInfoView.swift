//
//  IAPInfoView.swift
//  Emotional Aid
//
//  Created by itay gervash on 03/01/2022.
//

import UIKit
import SnapKit
import StoreKit

protocol IAPInfoViewDelegate {
    func iapInfoView(didTapPurchaseWith id: String)
}

class IAPInfoView: UIView {
    
    var delegate: IAPInfoViewDelegate?
    
    var iapID: String? {
        didSet {
            if iapID != nil {
                requestIAPPrice()
            }
        }
    }
    
    var hidesBottomBorder: Bool = false {
        didSet {
            bottomBorder.isHidden = hidesBottomBorder ? true : false
            self.layoutSubviews()
        }
    }
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.h2.withSize(18 * heightModifier)
        label.text = "title"
        label.textAlignment = .left
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(.lightGray), for: .normal)

        button.titleLabel?.font = FontTypes.shared.ubuntuMedium.withSize(12 * heightModifier)
        button.titleLabel?.textSpacing(of: 1.3)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var priceButtonActivityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView()
        av.style = .medium
        av.hidesWhenStopped = true
        av.startAnimating()
        return av
    }()
    
    private lazy var bottomBorder: UIView = {
        return Scribble().random()
    }()
    
    func setTitle(to text: String) {
        title.text = text.capitalized
        self.layoutSubviews()
    }
    
    private func setUpView() {
        self.backgroundColor = .white
        
        addSubviews()
        addConstraintsToSubviews()
        
        
    }
    
    private func addSubviews() {
        self.addSubview(title)
        self.addSubview(button)
        self.addSubview(priceButtonActivityIndicator)
        self.addSubview(bottomBorder)
    }
    
    private func addConstraintsToSubviews() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(36 * heightModifier)
            make.width.equalTo(96 * widthModifier)
        }
        
        priceButtonActivityIndicator.snp.makeConstraints { make in
            make.center.equalTo(button)
        }
        
        title.snp.makeConstraints { make in
            make.centerY.equalTo(button)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        bottomBorder.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-2 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(6 * heightModifier)
        }
    }
    
    private func requestIAPPrice() {
        guard iapID != nil else {
            button.setTitle("--", for: .normal)
            priceButtonActivityIndicator.stopAnimating()
            return
        }
        
        let request = SKProductsRequest(productIdentifiers: [iapID!])
        request.delegate = self
        request.start()
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        guard iapID != nil else { return }
        print("iap Info View button tapped")
        delegate?.iapInfoView(didTapPurchaseWith: iapID!)
    }
    
    init(iap id: String) {
        super.init(frame: .zero)
        iapID = id
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

}

extension IAPInfoView: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        DispatchQueue.main.async {
            if !response.products.isEmpty {
                let iap = response.products.first
                
                if let price = iap?.localizedPrice {
                    self.button.setTitle("\(price)", for: .normal)
                    self.button.setBackgroundImage(UIImage(named: "button-md")?.withTintColor(K.colors.appBlue ?? .systemTeal), for: .normal)
                    self.priceButtonActivityIndicator.stopAnimating()
                }
            }
        }

    }
    
    
}
