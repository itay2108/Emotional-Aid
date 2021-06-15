//
//  Exercise.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import Foundation

class Exercise {
    
    var index: Int = 0
    
    var title : String
    var accessory: ExerciseAccesory?
    var description: String
    
    var score: Int = 0
    
    init(title: String = "", accessory: ExerciseAccesory? = nil, description: String = "") {
        self.title = title
        self.description = description
    }
    
}

enum ExerciseAccesory {
    case audio
    case animation
    case slider
}
