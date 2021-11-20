//
//  TheoryTableViewCell.swift
//  Emotional Aid
//
//  Created by itay gervash on 26/06/2021.
//

import UIKit

class TheoryTableViewCell: UITableViewCell {
    
    lazy var isFree: Bool = true
    
    private lazy var header: UIView = Container()
    
    private lazy var indexBadge: VideoCellIndexBadge = VideoCellIndexBadge()
    
    private lazy var premiumBadge: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = K.uikit.premiumIcon
        view.isHidden = true
        return view
    }()
    
    private lazy var mainContainer: UIView = {
        let view = Container()
        view.roundCorners(.allCorners, radius: 10 * heightModifier)
        return view
    }()
    
    private lazy var videoThumb: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .lightGray
        view.roundCorners(.allCorners, radius: 10)
        view.layer.borderWidth = 3
        view.layer.borderColor = K.colors.appBlue?.cgColor
        return view
    }()
    
    private lazy var thumbPlayButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "play-fill")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var videoTextContainer: UIView = Container()
    
    private lazy var videoTitle: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.ubuntu.withSize(16 * heightModifier)
        label.textColor = K.colors.appText
        label.text = "Video Title"
        return label
    }()
    
    private lazy var videoDescription: UILabel = {
        let label = UILabel()
        label.font = FontTypes.shared.ubuntuLight.withSize(11.6 * heightModifier)
        label.textColor = K.colors.appText
        label.numberOfLines = 4
        label.contentMode = .topLeft
        label.sizeToFit()
        label.text = "This is a dummy/ndescription. It is/nused to test stuff."
        return label
    }()
    
    private lazy var tapGR: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer()
        gr.cancelsTouchesInView = false
        gr.addTarget(self, action: #selector(handleTaps(_:)))
        return gr
    }()
    
    lazy var cellSeparator: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "tableview-separator")
    view.contentMode = .scaleAspectFit
    return view
}()
    
    func setUpUI() {
        
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        self.addGestureRecognizer(tapGR)
        self.addSubview(header)
        header.addSubview(indexBadge)
        header.addSubview(premiumBadge)
        
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
        
        premiumBadge.snp.makeConstraints { make in
            make.left.equalTo(indexBadge.snp.right).offset(12 * widthModifier)
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
//            make.top.equalToSuperview().offset(12 * heightModifier)
            make.centerY.equalToSuperview().offset(-4)
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
        self.videoDescription.text = data.subtitle
        
        if let thumbURL = data.thumbURL {
            if let imageData: NSData = NSData(contentsOf: thumbURL) {
                        self.videoThumb.image = UIImage(data: imageData as Data)
                    }
        }
        
        
        self.indexBadge.indexLabel.text = String(index+1)
        
        self.premiumBadge.isHidden = data.isFree || UIApplication.isPremiumAvailable() ? true : false
        
        setNeedsLayout()
    }
    
    @objc private func handleTaps(_ gestureRecognizer: UITapGestureRecognizer) {
        //recognize taps and tint cell accordingly
        if gestureRecognizer.state == .recognized {
            mainContainer.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1)
        }
        
        if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                self.mainContainer.backgroundColor = .white
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
