//
//  ExerciseQueueController.swift
//  Emotional Aid
//
//  Created by itay gervash on 04/07/2021.
//

import UIKit
import AVFoundation
import MediaPlayer

class ExerciseQueueController: UIViewController {
    
    var exerciseModel: ExerciseModel?
    var delegate: ExerciseSelectorDelegate?
    
    private lazy var handle: UIView = {
        let view = UIView()
         view.backgroundColor = .lightGray
         view.layer.cornerRadius = 2
         return view
    }()
    
    private lazy var currentExerciseTitleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.font = FontTypes.shared.h1
        label.textAlignment = .left
        label.textColor = K.colors.appText
        
        label.text = exerciseModel != nil ? "\(exerciseModel!.currentExercise + 1). \(exerciseModel!.dataBase[exerciseModel!.currentExercise].title)" : "1. Lorem Ipsum"
        
       return label
    }()
    
    lazy var queueTableView: UITableView = {
        let tableView = UITableView()
         tableView.delegate = self
         tableView.dataSource = self
         tableView.register(ExerciseQueueTableViewCell.self, forCellReuseIdentifier: "queueCell")
         tableView.rowHeight = 73 * heightModifier
         tableView.separatorStyle = .none
         tableView.separatorColor = .clear
         tableView.showsVerticalScrollIndicator = false
         tableView.backgroundColor = K.colors.appOffWhite
         tableView.allowsMultipleSelection = false
         return tableView
    }()
    
    private lazy var audioControlsSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    
    lazy var playPauseButton: MediaButton = {
        let button = MediaButton()
        button.setImage(UIImage(named: "play-clear")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(playPauseButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var goForwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-forward")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    lazy var goBackwardsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "go-backwards")?.withTintColor(K.colors.appBlue ?? .black), for: .normal)
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    lazy var volumeSlider: MPVolumeView = {
        let slider = MPVolumeView()
        slider.showsVolumeSlider = true
        return slider
    }()
    
    lazy var audioProgressSlider: UISlider = {
       let slider = UISlider()
       return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        queueTableView.scrollToRow(at: IndexPath(row: exerciseModel?.currentExercise ?? 0, section: 0), at: .top, animated: false)
        super.viewDidAppear(animated)
    }
    
    private func setUpUI() {
        
        self.view.backgroundColor = K.colors.appOffWhite
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
        
        addSubviews()
        addConstraintsToSubviews()
        
    }
    
    private func addSubviews() {
        view.addSubview(handle)
        
        view.addSubview(currentExerciseTitleLabel)
        view.addSubview(queueTableView)
        view.addSubview(audioControlsSV)
        
        view.addSubview(audioProgressSlider)
        
        audioControlsSV.addArrangedSubview(goBackwardsButton)
        audioControlsSV.addArrangedSubview(playPauseButton)
        audioControlsSV.addArrangedSubview(goForwardButton)
        
        view.addSubview(volumeSlider)
    }
    
    private func addConstraintsToSubviews() {
        
        handle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * heightModifier)
            make.height.equalTo(4 * heightModifier)
            make.width.equalTo(36 * heightModifier)
            make.centerX.equalToSuperview()
        }
        
        currentExerciseTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(handle.snp.bottom).offset(42 * heightModifier)
            make.left.equalToSuperview().offset(36 * widthModifier)
            make.right.equalToSuperview().offset(-36 * widthModifier)
            make.height.equalTo(currentExerciseTitleLabel.font.pointSize.percentage(233))
        }
        
        volumeSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42 * widthModifier)
            make.right.equalToSuperview().offset(-42 * widthModifier)
            make.bottom.equalToSuperview().offset(-(28 * heightModifier + safeAreaSize(from: .bottom)))
            make.height.equalTo(16 * heightModifier)
        }
        
        audioControlsSV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(volumeSlider.snp.top).offset(-36 * heightModifier)
            make.height.equalTo(64 * heightModifier)
            make.width.equalTo(audioControlsSV.snp.height).multipliedBy(4)
        }
        
        goBackwardsButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.44)
        }
        
        playPauseButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.88)
        }
        
        goForwardButton.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.44)
        }
        
        audioProgressSlider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(42 * widthModifier)
            make.right.equalToSuperview().offset(-42 * widthModifier)
            make.bottom.equalTo(audioControlsSV.snp.top).offset(-36 * heightModifier)
            make.height.equalTo(16 * heightModifier)
        }
        
        queueTableView.snp.makeConstraints { make in
            make.top.equalTo(currentExerciseTitleLabel.snp.bottom).offset(24 * heightModifier)
            make.left.equalToSuperview().offset(12 * widthModifier)
            make.right.equalToSuperview().offset(-12 * widthModifier)
            make.bottom.equalTo(audioProgressSlider.snp.top).offset(-36 * heightModifier)
        }
        
    }
    
    //MARK: - button targets
    
    @objc func playPauseButtonPressed(_ button: MediaButton) {
        button.isPlaying = !button.isPlaying
    }

}

extension ExerciseQueueController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseModel?.dataBase.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard exerciseModel != nil else { return UITableViewCell() }
        
        let cell = queueTableView.dequeueReusableCell(withIdentifier: "queueCell", for: indexPath) as! ExerciseQueueTableViewCell
        
        cell.setCell(with: exerciseModel?.dataBase[indexPath.row] ?? Exercise(), index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard exerciseModel != nil else { return }
        
        //update current exercise in exercise model
        exerciseModel!.currentExercise = indexPath.row
        
        //update current exercise label
        self.currentExerciseTitleLabel.text = "\(indexPath.row + 1). \(exerciseModel!.dataBase[indexPath.row].title)"
        
        //set selected exercise in function
        let selectedExercise = exerciseModel!.dataBase[indexPath.row]
        
        //deselect all exercises in model and set isSelected to the currently selected one - this is done to display
        //the red ring only around the selected cell.
        exerciseModel!.deselectAllExercises()
        selectedExercise.isCurrentlySelected = true
        
        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(row: exerciseModel!.currentExercise, section: 0), at: .middle, animated: true)
 
        //update selected exercise also in practiceVC
        delegate?.set(exerciseTo: indexPath.row)
    }

    //set header title design in tableview
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = FontTypes.shared.ubuntuMedium.withSize(18 * heightModifier)
        header.textLabel?.textColor = K.colors.appText
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36 * heightModifier
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: tableView.sectionHeaderHeight))
        view.contentView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        view.contentView.backgroundColor = K.colors.appOffWhite
        view.textLabel?.text = "Exercises"
        return view
    }

}
