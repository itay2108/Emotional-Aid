//
//  Personality.swift
//  Emotional Aid
//
//  Created by itay gervash on 17/07/2021.
//

import Foundation

class Personality {
    
    static let main = Personality()
    
    var emotionalState: EmotionalState = .neutral
    
    var practiceScores: [Int?] = [nil, nil, nil]
}

enum EmotionalState {
    case negative
    case neutral
    case positive
}

enum Sex {
    case male
    case female
}
