//
//  ExerciseQueueTableViewCell.swift
//  Emotional Aid
//
//  Created by itay gervash on 05/07/2021.
//

import UIKit

class ExerciseQueueTableViewCell: UITableViewCell {
    
    lazy var headTitle: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntuLight.withSize(14 * heightModifier)
        label.textColor = K.colors.appText
        label.numberOfLines = 1
        return label
    }()
    
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        label.textColor = K.colors.appText
        label.numberOfLines = 1
        return label
    }()
    
    lazy var selectorView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "exercise-cell-selector")
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()
    
    private lazy var tapGR: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer()
        gr.addTarget(self, action: #selector(handleTaps(_:)))
        gr.cancelsTouchesInView = false
        return gr
    }()
    
    private func setUpUI() {
        
        self.backgroundColor = K.colors.appOffWhite
        self.selectionStyle = .none
        
        addSubviews()
        addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.addGestureRecognizer(tapGR)
        
        self.addSubview(headTitle)
        self.addSubview(mainTitle)
        self.addSubview(selectorView)
    }
    
    private func addConstraintsToSubviews() {
        
        headTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24 * widthModifier)
            make.bottom.equalTo(self.snp.centerY).offset(-2 * heightModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(headTitle.font.pointSize.percentage(125))
        }
        
        mainTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24 * widthModifier)
            make.top.equalTo(self.snp.centerY).offset(2 * heightModifier)
            make.centerX.equalToSuperview()
            make.height.equalTo(headTitle.font.pointSize.percentage(125))
        }
        
        selectorView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(4 * heightModifier)
        }
    
    }
    
    func setCell(with data: Exercise, index: Int) {
        
        headTitle.text = "Exercise \(index + 1)"
        mainTitle.text = data.title.capitalized
        
        if data.isCurrentlySelected { selectorView.isHidden = false }
        else { selectorView.isHidden = true }
        
        setNeedsLayout()
    }
    
    @objc private func handleTaps(_ gestureRecognizer: UITapGestureRecognizer) {
        //recognize taps generate "tint animation"
        if gestureRecognizer.state == .recognized {
            self.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        }
        
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                self.backgroundColor = K.colors.appOffWhite
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


