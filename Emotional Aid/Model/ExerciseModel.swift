//
//  ExerciseModel.swift
//  Emotional Aid
//
//  Created by itay gervash on 02/07/2021.
//

import UIKit

class ExerciseModel {
    
    var dataBase: [Exercise] = [
        
        //1
        Exercise(   title: "назовите, что вас беспокоит",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "сформулируйте, что именно вас тревожит. Можете назвать вслух, можете - про себя.",
                    theWhy: "В некотором смысле мы обретаем власть над тем, что нас беспокоит, когда произносим вслух и даем этому название. Как только вы сформулируете, что вас беспокоит, ваша психика получит конкретный и осязаемый материал для дальнейшей работы.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //2
        Exercise(   title: "где вы на шкале?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Когда вы оцениваете уровень своего стресса, вы учитесь, во-первых, отделять реальность от собственного состояния, во-вторых, развиваете навык интрацепции, в-третьих, сама попытка категоризировать уровень стресса уже его снижает",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //3
        Exercise(   title: "butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Билатеральная стимуляция позволяет нашему мозгу завершить процессинг, то есть дать ему возможность обработать эмоцию - прогоревать, проплакать, прожить эмоцию. Если этого не случается, стресс может превратиться в травму. Когда мы делаем движение крест-накрест происходит билатеральная стимуляция, мы позволяем мозгу полноценно обработать эмоцию, придать ей завершенный вид с точки зрения нейробиологии. Второй эффект от этого упражнение - самообъятие. Активация верхнего вагального нерва, который воспринимает объятия как сигнал к успокоению. Я у себя есть, я себя люблю, я себя поддерживаю, и верхний вагальный нерв посылает вам сигнал, что вы в безопасности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //4
        Exercise(   title: "contact points + дыхание",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Ощутите ваши точки соприкосновения с полом, спинкой стула, поверхностью стула или кровати (если вы лежите). Почувствуйте их. Напрягите их / Расслабьте их поочередно. Примите положение, которое тело будет более энергичным, готовым к действию / Примите положение более умиротворенное.",
                    theWhy: "Наша поза является основополагающим источником команд для мозга, потому что в зависимости от позы активируется центр давления. Мозг в зависимости от позы понимает - регулировать тебя вверх или вниз. Если мы напрягаем или, наоборот, расслабляем те зоны тела, которые контактируют со стулом или с диваном для того, чтобы тело приняло позу большей собранности, готовности к действию или наоборот расслабленности и транслировало этот сигнал мозгу. Одна только смена позы переводит нас в другое состояние, потому что тело дает команду мозгу, хотя еще недавно мы этого не знали. ",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //5
        Exercise(   title: "butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Дышите 1 к 1, сколько длится вдох, столько должен длиться выдох. Если +: дышите постепенно приближаясь к точке, чтобы вдох длился вдвое короче выдоха.",
                    theWhy: "Если -: дышим в пропорции 1к1. Это чуть увеличивает количество поступаемого кислорода в кровь и помогает выводить мозг из режима стоп-крана. Если +: с помощью дыхания 1 к 2 мы уменьшаем количество поступаемого в кровь кислорода и активируем вагальный тормоз и снижаем частоту сердечных сокращений. Возвращаемся из гиперактивации в окно толерантности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //6
        Exercise(   title: "руки на бёдрах",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //7
        Exercise(   title: "заземление",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //8
        Exercise(   title: "назовите состояние вашей нервной системы",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //9
        Exercise(   title: "Рука на сердце и на животе",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //10
        Exercise(   title: "ощути, где в твоём теле остался стресс",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //11
        Exercise(   title: "что делает вам хорошо на сердце?",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //12
        Exercise(   title: "прописываем желаемое развитие ситуации",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //13
        Exercise(   title: "человек/место силы",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        ),
        //14
        Exercise(   title: "что изменилось в вашем состоянии?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    theWhat: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    theWhy: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1)
        )
    
    ]
    
    var currentExercise: Int = 0 {
        didSet {
            if currentExercise > dataBase.count - 1 {
                currentExercise = currentExercise % dataBase.count
            }
            
            if currentExercise < 0 {
                currentExercise = currentExercise + dataBase.count
            }
        }
    }
    
    var scores: [Int] = []
    
    func deselectAllExercises() {
        for exercise in dataBase {
            exercise.isCurrentlySelected = false
        }
    }
    
}
