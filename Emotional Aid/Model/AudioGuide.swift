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
    
    var negative: URL? //intro + guide for when hypo has different guide
    var negativeShort: URL? //only guide for when hypo has different guide
    
    var additionalGuides: [URL?]?
    
    var currentPartIndex = 0
    var hasAdditionalParts: Bool {
        get { return additionalGuides?.count == 0 ? false : true }
    }
    
    var isNextPartAvailable: Bool {
        get {
            return currentPartIndex < (additionalGuides?.count ?? 0) ? true : false
        }
    }
    
    func nextPart() -> URL? {
        guard let extraParts = additionalGuides, extraParts.count > currentPartIndex else { return nil }
        currentPartIndex += 1
        textLog.write("setting audioguide to part \(currentPartIndex)")
        return extraParts[currentPartIndex - 1]
    }
    
    func part(_ partNumber: Int) -> URL? {
        guard partNumber > 0 else { textLog.write("cannot get audioguide part 0, please set to 0 using the mainAudioGuide variable which is stored in PracticeViewController"); return nil}
        guard let guideToPlay = additionalGuides?[partNumber - 1] else { return nil }
        currentPartIndex = partNumber
        textLog.write("setting audioguide to part \(currentPartIndex)")
        return guideToPlay
    }
    
    init(positive: URL?, positiveShort: URL?, negative: URL? = nil, negativeShort: URL? = nil, additionalGuides: [URL?]? = nil) {
        
        self.positive = positive
        self.positiveShort = positiveShort
        
        self.negative = negative
        self.negativeShort = negativeShort
        
        self.additionalGuides = additionalGuides
    }
}
