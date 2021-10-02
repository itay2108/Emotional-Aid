//
//  EASlider.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit
import SnapKit
import PaddingLabel

class EASlider: UISlider {
    
    var lastValue = 0
    
    private lazy var thumbView: UIView = {
        let thumb = UIImageView()
        thumb.image = UIImage(named: "slider-thumb")
        return thumb
    }()
    
    lazy var currentValueLabel: PaddingLabel = {
       let label = PaddingLabel()
        label.backgroundColor = .white
        label.roundCorners(.allCorners, radius: label.topInset * 1.3)
        label.font = FontTypes.shared.h3.withSize(22.5 * heightModifier)
        label.topInset = label.font.pointSize / 3
        label.bottomInset = label.font.pointSize / 3
        label.numberOfLines = 0
        label.textColor = K.colors.appText
        label.textAlignment = .center
        label.text = "0"
        label.isHidden = true
        return label
    }()
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width * 0.072815)
    }
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
            let originalRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
            let yOffset: CGFloat = 18 * heightModifier
            let newY = originalRect.origin.y + yOffset
        
        return CGRect(x: originalRect.origin.x, y: newY, width: originalRect.width, height: originalRect.height)
        }
    
    lazy var minimumValueLabel: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.h4.withSize(22.5 * heightModifier)
        label.text = "\(Int(self.minimumValue))"
        label.textColor = K.colors.appRed
        label.textAlignment = .left
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var medianValueLabel: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.h4.withSize(22.5 * heightModifier)
        
        let minMax = [Int(minimumValue), Int(maximumValue)]
        let medianValue = minMax.median()
        label.text = "\(Int(medianValue))"
        label.textColor = K.colors.appBlue
        label.textAlignment = .center
        label.layer.masksToBounds = false
        return label
    }()
    
    lazy var maximumValueLabel: UILabel = {
       let label = UILabel()
        label.font = FontTypes.shared.h4.withSize(22.5 * heightModifier)
        label.text = "\(Int(self.maximumValue))"
        label.textColor = K.colors.appRed
        label.textAlignment = .right
        label.layer.masksToBounds = false
        return label
    }()
    
    func setUpSlider() {
        self.minimumValue = -10
        self.maximumValue = 10
        
        self.setMaximumTrackImage(UIImage(named: "slider-track"), for: .normal)
        self.minimumTrackTintColor = .clear
        self.setMinimumTrackImage(UIImage(named: "slider-track"), for: .normal)
        
        self.setThumbImage(thumbImage(), for: .normal)
        
        self.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        
        addSubviews()
        setConstraints()
        
    }
    
    private func thumbImage() -> UIImage {

        thumbView.frame = CGRect(x: 0, y: 0, width: 33, height: 80)
        thumbView.layer.cornerRadius = 4
        thumbView.layer.masksToBounds = true
        thumbView.contentMode = .scaleAspectFit
        // Convert thumbView to UIImage
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
            return renderer.image { rendererContext in
                thumbView.layer.render(in: rendererContext.cgContext)
            }
        }
        
    }
    
    @objc func handleValueChange() {
        roundValue()
        
        currentValueLabel.text = "\(Int(self.value))"
        
        currentValueLabel.snp.remakeConstraints { make in
            //make.width.equalTo(44)
            //make.height.equalTo(22)
            make.centerY.equalTo(medianValueLabel)
            make.centerX.equalTo(medianValueLabel).offset(sliderValueOffsetFromCenter())
        }
        
        
        
        if Int(self.value) != Int(self.minimumValue) && Int(self.value) != Int(self.maximumValue) && Int(self.value) != Int([Int(minimumValue), Int(maximumValue)].median()) {
            currentValueLabel.isHidden = false
        } else {
            currentValueLabel.isHidden = true
        }
        
        
        if Int(self.value) == 0 && Int(self.value) != lastValue {
            Vibration.light.vibrate()
        }
        
        lastValue = Int(self.value)
    }
    
    func roundValue() {
        let step: Float = 1
        let roundedValue = round(self.value / step) * step
        self.value = roundedValue
    }
    
    func addSubviews() {
        self.addSubview(minimumValueLabel)
        self.addSubview(medianValueLabel)
        self.addSubview(maximumValueLabel)
        
        self.addSubview(currentValueLabel)
    }

    func setConstraints() {
        minimumValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY).offset(-(minimumValueLabel.font.pointSize * 2.75))
            make.left.equalToSuperview()//.offset(6)
            make.width.equalToSuperview().multipliedBy(0.14)
        }
        
        medianValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY).offset(-(minimumValueLabel.font.pointSize * 2.75))
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.14)
        }
        
        maximumValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.centerY).offset(-(minimumValueLabel.font.pointSize * 2.75))
            make.right.equalToSuperview()//.offset(-6 * widthModifier)
            make.width.equalToSuperview().multipliedBy(0.14)
        }
        
        currentValueLabel.snp.makeConstraints { make in
            //make.width.equalTo(44)
            //make.height.equalTo(22)
            make.centerY.equalTo(medianValueLabel).offset(-4 * heightModifier)
            make.centerX.equalTo(medianValueLabel)
        }
    }
    
    func centerPointForThumbLabel() -> CGPoint {
            let slidertTrack : CGRect = self.trackRect(forBounds: self.bounds)
            let sliderFrm : CGRect = self.thumbRect(forBounds: self.bounds, trackRect: slidertTrack, value: self.value)
            return CGPoint(x: sliderFrm.origin.x + self.frame.origin.x + 8, y: self.frame.origin.y - 20)
        }
    
    func sliderValueOffsetFromCenter() -> Double {
        let sliderWidth = self.trackRect(forBounds: self.bounds).width - (30 * widthModifier)
        let totalSteps = Double(Int(minimumValue).positiveValue() + Int(maximumValue).positiveValue())
        let stepsFromMedian = Double(self.value) - [Int(minimumValue), Int(maximumValue)].median()
        
        let offset = CGFloat(stepsFromMedian / totalSteps) * sliderWidth
        let roundedOffset = Double(offset).rounded(toPlaces: 2)

        return roundedOffset
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUpSlider()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUpSlider()
    }
}
