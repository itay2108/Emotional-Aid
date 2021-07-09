//
//  Exercise.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit

class Exercise {
    
    var title : String
    
    var isAnimationPresent: Bool
    var animationURLName: String?
    
    var isSliderPresent: Bool
    
    var shortDescription: String
    var description: String
    var audioGuides: [URL?]? = nil
    
    var isCurrentlySelected: Bool = false
    
    init(title: String = "Exercise Title", isAnimationPresent: Bool = false, animationURLName: String? = nil, isSliderPresent: Bool = false, shortDescription: String = "The what desc", description: String = "The why description", audioGuides: [URL?]? = nil) {
        self.title = title
        
        self.isAnimationPresent = isAnimationPresent
        self.animationURLName = animationURLName
        
        self.isSliderPresent = isSliderPresent
        
        self.shortDescription = shortDescription
        self.description = description
        
        self.audioGuides = audioGuides
    }
    
}

