//
//  Scribble.swift
//  Emotional Aid
//
//  Created by itay gervash on 04/09/2021.
//

import UIKit

class Scribble: UIImageView {
    
    let lines = [K.uikit.lineScribble1?.withRenderingMode(.alwaysTemplate),
                 K.uikit.lineScribble2?.withRenderingMode(.alwaysTemplate),
                 K.uikit.lineScribble3?.withRenderingMode(.alwaysTemplate)]
    
    func random() -> UIImageView {
        let rand = Int.random(in: 0...2)
        
        if rand < lines.count {
            self.image = lines[rand]
        }
        
        self.contentMode = .scaleAspectFit
        self.tintColor = K.colors.appBlue
        
        return self
    }
    
    func setUp() {
        self.image = K.uikit.lineScribble1?.withRenderingMode(.alwaysTemplate)
        self.contentMode = .scaleAspectFit
        self.tintColor = K.colors.appBlue
    }
    
    init() {
        super.init(frame: .zero)
        setNeedsLayout()
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setNeedsLayout()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsLayout()
        setUp()
    }
    
    
}
