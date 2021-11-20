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
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/1.mp4?alt=media&token=00ffce13-28cd-4259-86f1-831e59ef984f"),
            thumbURL: Bundle.main.url(forResource: "videoLesson1Thumb", withExtension: "png"),
            title: "Первый урок",
                subtitle: "Анатомия главного управляющего нашей нервной системы - вагального нерва."),
            
            //2
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/2.mp4?alt=media&token=dfb8e194-a9df-4d6b-b0ce-a2a45a1bb33f"),
            thumbURL: Bundle.main.url(forResource: "videoLesson2Thumb", withExtension: "png"),
            title: "Второй урок",
                subtitle: "Нормальная работа автономной нервной системы. Как на нее влияет психотравма?"),
            
            //3
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/3.mp4?alt=media&token=73f4eb81-ff7c-4b0d-a59d-c5ff0a649d26"),
            thumbURL: Bundle.main.url(forResource: "videoLesson3Thumb", withExtension: "png"),
            title: "Третий урок",
                subtitle: "что такое стресс? что такое вагальный тормоз и для чего он нужен?"),
            
            //4
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/4.mp4?alt=media&token=b5784426-9073-4fc1-99a1-eed04e3485d6"),
            thumbURL: Bundle.main.url(forResource: "videoLesson4Thumb", withExtension: "png"),
            title: "Четвретый урок",
                subtitle: "Как получить доступ к вагальному нерву? Дыхание. Регулирование нервной системы."),
            
            //5
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/5.mp4?alt=media&token=90983c65-90aa-4b2f-98b9-b4fd54fe55c0"),
            thumbURL: Bundle.main.url(forResource: "videoLesson5Thumb", withExtension: "png"),
            title: "Пятый урок",
                subtitle: "Интроцепция, экстрацепция, окно толерантности. Модель мозга на примере руки"),
            
            //6
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/6.mp4?alt=media&token=26e6a1a2-d68c-4743-a5b5-890342817dd6"),
            thumbURL: Bundle.main.url(forResource: "videoLesson6Thumb", withExtension: "png"),
            title: "Шестой урок",
                subtitle: "3 зоны регуляции, безопасная и опасная неподвижность.",
            isFree: false),
            
            //7
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/7.mp4?alt=media&token=ea67f86b-ced8-467c-96a4-381cd86acc45"),
            thumbURL: Bundle.main.url(forResource: "videoLesson7Thumb", withExtension: "png"),
            title: "Седьмой урок",
                subtitle: "Верхний и нижний вагальный нерв",
            isFree: false),
        ]
}

