//
//  AudioGuide.swift
//  Emotional Aid
//
//  Created by itay gervash on 30/07/2021.
//

import Foundation

class AudioGuide {
    var positive: URL?
    var negative: URL?
    
    var part2: URL? = nil
    var part3: URL? = nil
    
    init(positive: URL?, negative: URL? = nil, part2: URL? = nil, part3: URL? = nil) {
        self.positive = positive
        self.negative = negative
        
        self.part2 = part2
        self.part3 = part3
    }
}
