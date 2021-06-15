//
//  Container.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit

class Container: UIView {
    
    func setUpView() {
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setUpView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
    }
    
}

