//
//  VideoCellIndexBadge.swift
//  Emotional Aid
//
//  Created by itay gervash on 26/06/2021.
//

import UIKit
import SnapKit

class VideoCellIndexBadge: UIView {

    private lazy var circleView: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "video-index-badge")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var indexLabel: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.h6.withSize(11)
        label.textColor = K.colors.appText
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    func setUpUI() {
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        self.addSubview(circleView)
        self.addSubview(indexLabel)
    }
    
    func addConstraintsToSubviews() {
        circleView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indexLabel.snp.makeConstraints { make in
            make.centerX.equalTo(circleView)
            make.centerY.equalToSuperview().offset(indexLabel.font.pointSize.percentage(30))
            make.width.equalTo(circleView)
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
