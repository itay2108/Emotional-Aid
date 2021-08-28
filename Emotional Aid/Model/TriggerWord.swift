//
//  TriggerWord.swift
//  Emotional Aid
//
//  Created by itay gervash on 28/08/2021.
//

import Foundation

class TriggerWord {
    var type: TriggerWordType
    var value: String
    
    init(_ value: String, type: TriggerWordType) {
        self.value = value
        self.type = type
    }
    
}

enum TriggerWordType {
    case next
    case rewind
}
