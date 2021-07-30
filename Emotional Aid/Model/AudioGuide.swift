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
    
    init(positive: URL?, negative: URL? = nil) {
        self.positive = positive
        self.negative = negative
    }
}
