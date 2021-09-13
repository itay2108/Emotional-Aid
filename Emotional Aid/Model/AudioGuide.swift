//
//  AudioGuide.swift
//  Emotional Aid
//
//  Created by itay gervash on 30/07/2021.
//

import Foundation

class AudioGuide {
    
    var positive: URL? //intro + guide for default state
    var positiveShort: URL? //only guide for default state
    
    var negative: URL? //intro + guide for when hypo has differend guide
    var negativeShort: URL? //only guide for when hypo has differend guide
    
    var part2: URL? = nil
    
    init(positive: URL?, positiveShort: URL?, negative: URL? = nil, negativeShort: URL? = nil, part2: URL? = nil) {
        
        self.positive = positive
        self.positiveShort = positiveShort
        
        self.negative = negative
        self.negativeShort = negativeShort
        
        self.part2 = part2
    }
}

enum AudioGuidePlaybackPart {
    case intro
    case main
    case extra
}
