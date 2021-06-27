//
//  TheoryVideo.swift
//  Emotional Aid
//
//  Created by itay gervash on 27/06/2021.
//

import UIKit

class TheoryVideo {
    
    var title: String
    var description: String
    
    var thumb: UIImage?
    
    init(title: String = "Video Title", description: String = "The quick brown fox jumps over the lazy dog./nThe quick brown fox jumps over the lazy dog.", thumb: UIImage? = nil) {
        self.title = title
        self.description = description
        self.thumb = thumb
    }
}
