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
    var scoreIndex: Int? = nil
    
    var theWhat: String
    var theWhy: String
    
    var theWhatNegative: String?
    var theWhyNegative: String?
    
    var audioGuide: AudioGuide?
    
    var isCurrentlySelected: Bool = false
    
    init(title: String = "Exercise Title", isAnimationPresent: Bool = false, animationURLName: String? = nil, isSliderPresent: Bool = false, scoreIndex: Int? = nil,  theWhat: String = "The what description", theWhy: String = "The why desc", theWhatNegative: String? = nil, theWhyNegative: String? = nil, audioGuide: AudioGuide? = nil) {
        self.title = title
        
        self.isAnimationPresent = isAnimationPresent
        self.animationURLName = animationURLName
        
        self.isSliderPresent = isSliderPresent
        self.scoreIndex = scoreIndex
        
        self.theWhat = theWhat
        self.theWhy = theWhy
        
        self.theWhatNegative = theWhatNegative
        self.theWhyNegative = theWhyNegative
        
        self.audioGuide = audioGuide
    }
    
}

