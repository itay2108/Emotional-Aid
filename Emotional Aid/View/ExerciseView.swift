//
//  ExerciseView.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit

class ExerciseView: UIView {
    
    var exercise: Exercise = Exercise() {
        didSet {
            print("exercise set for view")
            refreshView()
        }
    }
    
    var scrollView: UIScrollView = {
       let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
       return view
    }()

    var contentView: UIView = UIView()

    lazy var questionLabel: UILabel = {
       let label = UILabel()
        label.text = "\(exercise.index). \(exercise.title)"
        label.numberOfLines = 0
        label.font = FontTypes.shared.h1
        label.textAlignment = .left
        label.textColor = K.colors.appText
       return label
    }()
    
    lazy var accessoryContainer: UIStackView = {
       let view = UIStackView()
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var accessoryAnimation: UIImageView = {
        let view = UIImageView()
        view.image = UIImage()
        return view
    }()
    
    lazy var accessorySlider: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 10
        slider.minimumValue = -10
        slider.value = 0
       return slider
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = exercise.description
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
    
    func refreshView() {
        print("refreshing view")
        questionLabel.text = "\(exercise.index). \(exercise.title)"
        descriptionLabel.text = "\(exercise.description)"
        
        self.layoutIfNeeded()
    }
    
    func layoutContainers() {
        
        self.addSubview(questionLabel)
        self.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        contentView.addSubview(accessoryContainer)
        
        accessoryContainer.addSubview(accessoryAnimation)
        accessoryContainer.addSubview(accessorySlider)
        
        contentView.addSubview(descriptionLabel)
    }
    
    func setConstraintsToContainers() {
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.66)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(16 * heightModifier)
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
            make.width.equalToSuperview()
            make.height.equalTo(84 * heightModifier)
            make.top.equalToSuperview().offset(16 * heightModifier)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(accessoryContainer.snp.bottom).offset(16 * heightModifier)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-64 * heightModifier)
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
