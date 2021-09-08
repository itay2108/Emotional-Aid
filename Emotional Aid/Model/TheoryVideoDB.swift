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
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/1.mp4?alt=media&token=7319ce6d-8163-4c86-9433-51081205635c"),
            thumbURL: Bundle.main.url(forResource: "videoLesson1Thumb", withExtension: "png"),
            title: "Первый урок",
                subtitle: "Анатомия главного управляющего нашей нервной системы - вагального нерва. Мозг дает команды телу или наоборот?"),
            
            //2
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/2.mp4?alt=media&token=8989cbbc-a02a-4a83-8b79-f3eeebb89f88"),
            thumbURL: Bundle.main.url(forResource: "videoLesson2Thumb", withExtension: "png"),
            title: "Второй урок",
                subtitle: "Нормальная работа автономной нервной системы. Как на нее влияет психотравма?"),
            
            //3
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/3.mp4?alt=media&token=bfdcdbfc-0ce8-436b-9709-d80be26cfe16"),
            thumbURL: Bundle.main.url(forResource: "videoLesson3Thumb", withExtension: "png"),
            title: "Третий урок",
                subtitle: "что такое стресс? что такое вагальный тормоз и для чего он нужен?"),
            
            //4
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/4.mp4?alt=media&token=2a5e4e8e-26f9-46ed-86ed-fca853dcc5a8"),
            thumbURL: Bundle.main.url(forResource: "videoLesson4Thumb", withExtension: "png"),
            title: "Четвретый урок",
                subtitle: "Как получить доступ к вагальному нерву? Дыхание. Регулирование нервной системы."),
            
            //5
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/5.mp4?alt=media&token=f2491da5-9048-42d1-ab4a-2174ad66f8a0"),
            thumbURL: Bundle.main.url(forResource: "videoLesson5Thumb", withExtension: "png"),
            title: "Пятый урок",
                subtitle: "Интроцепция, экстрацепция, окно толерантности. Модель мозга на примере руки"),
            
            //6
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/6.mp4?alt=media&token=e3dd8615-60ec-49b9-aa4b-b72df4fba9cd"),
            thumbURL: Bundle.main.url(forResource: "videoLesson6Thumb", withExtension: "png"),
            title: "Шестой урок",
                subtitle: "3 зоны регуляции, безопасная и опасная неподвижность. Как перейти из желтой зоны в зеленую?"),
            
            //7
            TheoryVideo(
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/emotional-aid-8de3a.appspot.com/o/7.mp4?alt=media&token=c88d8e84-8904-47ee-98a8-236292f04177"),
            thumbURL: Bundle.main.url(forResource: "videoLesson7Thumb", withExtension: "png"),
            title: "Седьмой урок",
                subtitle: "Верхний и нижний вагальный нерв"),
        ]
}

