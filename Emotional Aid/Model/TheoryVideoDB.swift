//
//  TheoryVideoDB.swift
//  Emotional Aid
//
//  Created by itay gervash on 27/06/2021.
//

import UIKit

class TheoryVideoDB {
    var database: [TheoryVideo] =
        [ TheoryVideo(
            url: Bundle.main.url(forResource: "theory1", withExtension: "mp4"),
            thumbURL: Bundle.main.url(forResource: "videoLesson1Thumb", withExtension: "png"),
            title: "video1",
            subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli.")
        ]
}

