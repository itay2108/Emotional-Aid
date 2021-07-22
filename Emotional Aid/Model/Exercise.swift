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
    
    var theWhat: String
    var theWhy: String
    
    var theWhatNegative: String?
    var theWhyNegative: String?
    
    var audioGuides: [URL?]? = nil
    
    var isCurrentlySelected: Bool = false
    
    init(title: String = "Exercise Title", isAnimationPresent: Bool = false, animationURLName: String? = nil, isSliderPresent: Bool = false,  theWhat: String = "The what description", theWhy: String = "The why desc", theWhatNegative: String? = nil, theWhyNegative: String? = nil, audioGuides: [URL?]? = nil) {
        self.title = title
        
        self.isAnimationPresent = isAnimationPresent
        self.animationURLName = animationURLName
        
        self.isSliderPresent = isSliderPresent
        
        self.theWhat = theWhat
        self.theWhy = theWhy
        
        self.theWhatNegative = theWhatNegative
        self.theWhyNegative = theWhyNegative
        
        self.audioGuides = audioGuides
    }
    
}

