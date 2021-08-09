//
//  TheoryVideoDB.swift
//  Emotional Aid
//
//  Created by itay gervash on 27/06/2021.
//

import UIKit

class TheoryVideoDB {
    var database: [TheoryVideo] =
        [
            //1
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/1.mp4?alt=media&token=12334673-d5d1-4462-85bb-4c12b7475607"),
            thumbURL: Bundle.main.url(forResource: "videoLesson1Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //2
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/2.mp4?alt=media&token=25d677bd-e111-4515-aad0-f14b66390e07"),
            thumbURL: Bundle.main.url(forResource: "videoLesson2Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //3
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/3.mp4?alt=media&token=7eac1351-e734-400c-9c5e-96c5afcbb796"),
            thumbURL: Bundle.main.url(forResource: "videoLesson3Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //4
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/4.mp4?alt=media&token=7fa09661-0d74-40b7-b2ea-6415d3406af4"),
            thumbURL: Bundle.main.url(forResource: "videoLesson4Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //5
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/5.mp4?alt=media&token=2a98cfdf-6885-4485-9d4d-f0cb5ed919e9"),
            thumbURL: Bundle.main.url(forResource: "videoLesson5Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //6
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/6.mp4?alt=media&token=7d2ae141-c564-43c2-ab97-9b410747ecfb"),
            thumbURL: Bundle.main.url(forResource: "videoLesson6Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
            
            //7
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid.appspot.com/o/7.mp4?alt=media&token=3c5a9383-8310-4feb-9025-0570021d7aeb"),
            thumbURL: Bundle.main.url(forResource: "videoLesson7Thumb", withExtension: "png"),
            title: "video1",
                subtitle: "The quick brown fox jumps over the lazy dog. Ganan gidelle dagan baggan. Ravioli ravioli give me the formuloli."),
        ]
}

