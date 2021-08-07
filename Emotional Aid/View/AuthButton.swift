//
//  AuthButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 07/08/2021.
//

import UIKit
import SnapKit

class AuthButton: UIButton {
    
    var cornerRadius: CGFloat = 18 {
        didSet {
            self.roundCorners(.allCorners, radius: cornerRadius)
        }
    }
    
    var authTitle: String = "Authoriztion" {
        didSet {
            authLabel.text = authTitle
            layoutSubviews()
        }
    }
    
    private lazy var authLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16 * heightModifier, weight: UIFont.Weight.medium)
        label.text = authTitle
        label.textColor = titleColor(for: .normal)
        return label
    }()
    
    var authImage: UIImage? = nil {
        didSet {
            authImageView.image = authImage
            layoutSubviews()
        }
    }
    
    var authImageWidth: CGFloat = 16 {
        didSet {
            authLabel.snp.remakeConstraints { make in
                make.centerY.equalToSuperview().offset(-1)
                make.centerX.equalToSuperview().offset(authImageWidth / 2 + 2)
            }

            authImageView.snp.remakeConstraints { make in
                make.height.equalTo(authImageWidth)
                make.width.equalTo(authImageWidth)
                make.right.equalTo(authLabel.snp.left).offset(-authImageWidth / 2)
                make.centerY.equalToSuperview().offset(-1)
            }
        }
    }
    
    lazy var authImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = authImage
        return view
    }()
    
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        authLabel.textColor = color
    }
    
    //MARK: view set up
    

    func setUpView() {
        
        self.imageView?.image = nil
        self.setTitle(nil, for: .normal)
        
        self.roundCorners(.allCorners, radius: cornerRadius)
        self.titleLabel?.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        
        self.addSubview(authLabel)
        self.addSubview(authImageView)

    }
    
    func addConstraintsToSubviews() {
        
        authLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-1)
            make.centerX.equalToSuperview().offset(authImageWidth / 2 + 2)
        }

        authImageView.snp.makeConstraints { make in
            make.height.equalTo(authImageWidth)
            make.width.equalTo(authImageWidth)
            make.right.equalTo(authLabel.snp.left).offset(-authImageWidth / 2)
            make.centerY.equalToSuperview().offset(-1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUpView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUpView()
    }

}
