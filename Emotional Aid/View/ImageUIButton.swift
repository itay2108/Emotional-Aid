//
//  ImageUIButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 02/07/2021.
//

import UIKit
import SnapKit

class ImageUIButton: UIButton {
    
    
    lazy var label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18 * heightModifier)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var imageContainer: UIImageView = UIImageView()
    
    lazy var image: UIImage? = UIImage() {
        didSet {
            imageContainer.image = image
            layoutSubviews()
        }
    }
    
    func addSubiews() {
        self.addSubview(label)
        self.addSubview(imageContainer)
    }
    
    func addConstraintsToSubviews() {
        
        print(self.frameHeight)
        imageContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(self.frameWidth.percentage(16))
            make.top.equalToSuperview().offset(self.frameWidth.percentage(16))
            make.bottom.equalToSuperview().offset(-self.frameWidth.percentage(16))
            make.width.equalTo(imageContainer.snp.height)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(imageContainer.snp.right).offset(16 * widthModifier)
            make.top.equalToSuperview().offset(self.frameWidth.percentage(8))
            make.bottom.equalToSuperview().offset(-self.frameWidth.percentage(8))
            make.right.equalToSuperview().offset(-self.frameWidth.percentage(8))
        }
    }
    
    func setUpView() {
        self.titleLabel?.text = ""
        self.imageView?.tintColor = .clear
        
        addSubiews()
        addConstraintsToSubviews()
        
        layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUpView()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpView()
        }

}
