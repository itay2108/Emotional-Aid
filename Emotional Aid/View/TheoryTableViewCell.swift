//
//  TheoryTableViewCell.swift
//  Emotional Aid
//
//  Created by itay gervash on 26/06/2021.
//

import UIKit

class TheoryTableViewCell: UITableViewCell {
    
    private lazy var header: UIView = Container()
    
    private lazy var indexBadge: VideoCellIndexBadge = VideoCellIndexBadge()
    
    private lazy var mainContainer: UIView = Container()
    
    private lazy var videoThumb: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .lightGray
        view.roundCorners(.allCorners, radius: 10)
        return view
    }()
    
    private lazy var thumbPlayButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "video-play")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var videoTextContainer: UIView = Container()
    
    private lazy var videoTitle: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        label.text = "Video Title"
        return label
    }()
    
    private lazy var videoDescription: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntuLight.withSize(11.6 * heightModifier)
        label.numberOfLines = 3
        label.contentMode = .topLeft
        label.sizeToFit()
        label.text = "This is a dummy/ndescription. It is/nused to test stuff."
        return label
    }()
    
    lazy var cellSeparator: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "tableview-separator")
    view.contentMode = .scaleAspectFit
    return view
}()
    
    func setUpUI() {
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        self.addSubview(header)
        header.addSubview(indexBadge)
        
        self.addSubview(mainContainer)
        mainContainer.addSubview(videoThumb)
        videoThumb.addSubview(thumbPlayButton)
        
        mainContainer.addSubview(videoTextContainer)
        
        videoTextContainer.addSubview(videoTitle)
        videoTextContainer.addSubview(videoDescription)
        
        self.addSubview(cellSeparator)
    }
    
    func addConstraintsToSubviews() {
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8 * heightModifier)
            make.left.equalToSuperview().offset(16 * widthModifier)
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.height.equalToSuperview().multipliedBy(0.16)
        }
        
        indexBadge.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
            make.width.equalTo(header.snp.height).multipliedBy(0.85)
        }
        
        mainContainer.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        videoThumb.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16 * widthModifier)
            make.top.equalToSuperview().offset(12 * heightModifier)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(videoThumb.snp.width).multipliedBy(0.5625)
            
        }
        
        thumbPlayButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.38)
            make.width.equalTo(thumbPlayButton.snp.height)
            make.center.equalToSuperview()
        }
        
        videoTextContainer.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        videoTitle.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.top.equalToSuperview().offset(16 * widthModifier)
            make.height.equalTo(videoTitle.font.pointSize.percentage(125))
        }
        
        videoDescription.snp.makeConstraints { make in
            make.top.equalTo(videoTitle.snp.bottom).offset(8 * heightModifier)
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.left.equalToSuperview()
            //make.bottom.equalToSuperview().offset(-16 * widthModifier)
        }
        
        cellSeparator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(24 * widthModifier)
            make.height.equalTo(6 * heightModifier)
        }
    }
    
    func setCell(with data: TheoryVideo, index: Int) {
        self.videoTitle.text = data.title
        self.videoDescription.text = data.description
        self.videoThumb.image = data.thumb
        self.indexBadge.indexLabel.text = String(index+1)
        
        setNeedsLayout()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
