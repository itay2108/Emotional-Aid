//
//  TheoryViewController.swift
//  Emotional Aid
//
//  Created by itay gervash on 25/06/2021.
//

import UIKit

class TheoryViewController: UIViewController{
    
    private lazy var navContainer:  UIView      = {
        return Container()
    }()
    
    private lazy var profileButton: UIButton    = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "profile-button"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    private lazy var logo: UIImageView          = {
       let view = UIImageView()
        view.image = UIImage(named: "logo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var logoTitle: UILabel         = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = FontTypes.shared.h4.withSize(22)
        label.text = "Emotional Aid"
        label.textSpacing(of: 2)
        label.textColor = K.colors.appText
        return label
    }()
    
    private lazy var videoTableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TheoryTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 156 * heightModifier
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var videoDatabase: TheoryVideoDB = TheoryVideoDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setUpUI()

    }
    
    func setUpUI() {
        addSubviews()
        addConstraintsToSubviews()
    }
    
    func addSubviews() {
        view.addSubview(navContainer)
        navContainer.addSubview(profileButton)
        navContainer.addSubview(logo)
        navContainer.addSubview(logoTitle)
        
        view.addSubview(videoTableView)
    }
    
    func addConstraintsToSubviews() {
        
        navContainer.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(84 * heightModifier)
            make.top.equalToSuperview().offset(view.safeAreaSize(from: .top))
            make.centerX.equalToSuperview()
        }
        
        profileButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-24 * widthModifier)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.65)
            make.width.equalTo(navContainer.snp.height).multipliedBy(0.65)
        }
        
        logo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16 * widthModifier)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(navContainer.snp.height)
        }
        
        logoTitle.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right)
            make.centerY.equalToSuperview().offset(logoTitle.font.pointSize.percentage(10))
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        videoTableView.snp.makeConstraints { make in
            make.top.equalTo(navContainer.snp.bottom).offset(16 * heightModifier)
            make.left.equalToSuperview().offset(16 * widthModifier)
            make.right.equalToSuperview().offset(-16 * widthModifier)
            make.bottom.equalToSuperview()
        }
        
        
    }
}

extension TheoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoDatabase.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TheoryTableViewCell
        
        cell.setCell(with: videoDatabase.database[indexPath.row], index: indexPath.row)
        
        if indexPath.row == videoDatabase.database.count - 1 {
            cell.cellSeparator.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = FontTypes.shared.ubuntu.withSize(18 * heightModifier)
        header.textLabel?.textColor = K.colors.appText
        
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42 * heightModifier
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: tableView.sectionHeaderHeight))
        view.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.contentView.backgroundColor = .white
        view.textLabel?.text = "Видео уроки"
        return view
    }
    

    
    

    
}
