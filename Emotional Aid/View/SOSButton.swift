//
//  SOSButton.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//


import UIKit
import SnapKit
import SwiftFontName

class SOSButton: UIButton {

    let fontTypes = FontTypes()

    func layoutAccessories() {
        layoutSubviews()
        self.layer.masksToBounds = false
        
        self.setBackgroundImage(UIImage(named: "sos_button"), for: .normal)
        self.titleLabel?.font = fontTypes.xl.withSize(64)
        self.setTitleColor(.white, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        layoutAccessories()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        layoutAccessories()
    }

}
