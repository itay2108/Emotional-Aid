//
//  EASlider.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit

class EASlider: UIView {
    
    var sliderScale: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "slider")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    func setUpSlider() {
        
    }
    
    func addSubviews() {
        
    }

    func setConstraints() {
        
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
