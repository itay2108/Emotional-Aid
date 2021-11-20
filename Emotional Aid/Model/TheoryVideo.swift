//
//  TheoryVideo.swift
//  Emotional Aid
//
//  Created by itay gervash on 27/06/2021.
//

import UIKit

class TheoryVideo: NSObject {
    
    let url: URL?
    let thumbURL: URL?
    let title: String
    let subtitle: String
    var isFree: Bool = true

    init(url: URL?, thumbURL: URL?, title: String = "Video Title", subtitle: String = "Video description.", isFree: Bool = true) {
      self.url = url
      self.thumbURL = thumbURL
      self.title = title
      self.subtitle = subtitle
      self.isFree = isFree
      super.init()
    }
}
