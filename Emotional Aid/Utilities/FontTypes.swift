//
//  FontTypes.swift
//  Emotional Aid
//
//  Created by itay gervash on 13/06/2021.
//

import UIKit
import SwiftFontName

public class FontTypes {
    
    private let sizeModifier: CGFloat!
    
    static let shared = FontTypes()
    
    var h1 = UIFont.systemFont(ofSize: 48)
    var h2 = UIFont.systemFont(ofSize: 24)
    var h3 = UIFont.systemFont(ofSize: 17)
    var h4 = UIFont.systemFont(ofSize: 14)
    var h5 = UIFont.systemFont(ofSize: 12)
    var h6 = UIFont.systemFont(ofSize: 11)
    var xl = UIFont.systemFont(ofSize: 64)
    var p  = UIFont.systemFont(ofSize: 14)
    
    var ubuntu = UIFont.systemFont(ofSize: 18)
    var ubuntuLight = UIFont.systemFont(ofSize: 18)
    
    init() {
        sizeModifier = UIScreen.main.bounds.size.height / 812
        
        guard
            let neucha: UIFont = UIFont(name: "neucha", size: 18),
            let ubuntu: UIFont = UIFont(name: "Ubuntu-Regular", size: 18),
            let ubuntuLight: UIFont = UIFont(name: "Ubuntu-Light", size: 18)
        else { print("could not set extra fonts"); return }
        
        
        h1 = neucha.withSize(36 * sizeModifier)
        h2 = neucha.withSize(24 * sizeModifier)
        h3 = neucha.withSize(17 * sizeModifier)
        h4 = neucha.withSize(16 * sizeModifier)
        h5 = neucha.withSize(14 * sizeModifier)
        h6 = neucha.withSize(12 * sizeModifier)
        
        xl = neucha.withSize(72 * sizeModifier)
        p  = ubuntu.withSize(13 * sizeModifier)
        self.ubuntu = ubuntu
        self.ubuntuLight = ubuntuLight
    }
    
}
