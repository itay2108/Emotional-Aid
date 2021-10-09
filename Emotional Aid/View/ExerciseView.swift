//
//  ExerciseView.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit
import Gifu

class ExerciseView: UIView {
    
    var defaultAnimationHeight: CGFloat = 196
    var defaultSliderHeight: CGFloat = 89
    
    var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
       return view
    }()

    var contentView: UIView = UIView()

    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = FontTypes.shared.h1
        label.textAlignment = .left
        label.textColor = K.colors.appText
       return label
    }()
    
    lazy var accessoryContainer: UIStackView = {
       let view = UIStackView()
        view.distribution = .equalCentering
        view.axis = .vertical
        view.alignment = .center
        view.backgroundColor = .clear
        view.isLayoutMarginsRelativeArrangement = true
        //view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 48, leading: 0, bottom: 0, trailing: 0)
        return view
    }()
    
    lazy var accessoryAnimation: GIFImageView = {
        let view = GIFImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var accessorySlider: EASlider = {
        let slider = EASlider()
        slider.addTarget(self, action: #selector(sliderValueHasChanged(_:)), for: .valueChanged)
       return slider
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = FontTypes.shared.p
        label.textAlignment = .left
        label.textColor = K.colors.appText
       return label
    }()
    
    func setUpView() {
        layoutContainers()
        setConstraintsToContainers()
    }
    
    func layoutContainers() {
        
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(accessoryContainer)
        
        accessoryContainer.addArrangedSubview(accessoryAnimation)
        accessoryContainer.addArrangedSubview(accessorySlider)
        
        contentView.addSubview(descriptionLabel)
    }
    
    func setConstraintsToContainers() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-24 * widthModifier)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        accessoryContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        accessoryAnimation.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(defaultAnimationHeight * heightModifier)
        }
        
        accessorySlider.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(89 * heightModifier)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(accessoryContainer.snp.bottom).offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-128 * heightModifier)
        }
        
    }
    
    func changeviewState(of view: UIView, to state: viewState, with height: CGFloat = 96) {
        if state == .expanded {
            view.snp.updateConstraints { update in
                update.height.equalTo(height * heightModifier)
            }
        } else if state == .collapsed {
            view.snp.updateConstraints { update in
                update.height.equalTo(0)
            }
        }
    }
    
    @objc func sliderValueHasChanged(_ slider: UISlider) {
        NotificationCenter.default.post(name: Notification.Name.exerciseSliderValueHasChanged, object: nil, userInfo: ["value" : slider.value])
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

enum viewState {
    case expanded
    case collapsed
}
