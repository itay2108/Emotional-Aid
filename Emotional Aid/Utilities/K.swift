//
//  K.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit

    struct K {
        
        struct colors {
            static let appRed = UIColor(named: "ea_red")
            static let appBlue = UIColor(named: "ea_blue")
            static let appText = UIColor(named: "ea_text")
            static let appOffWhite = UIColor(named: "ea_offwhite")
        }
        
        struct uikit {
            static let hamburgerMenuButton = UIImage(named: "menu_button")
            static let backButton = UIImage(named: "back_button")
            static let logo = UIImage(named: "logo")
            static let demobar = UIImage(named: "bar_1")
        }
        
        struct audio {
            static let lesson1 = Bundle.main.url(forResource: "lesson", withExtension: "wav")
        }
        
    }
