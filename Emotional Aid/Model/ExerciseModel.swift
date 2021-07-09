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
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //2
        Exercise(   title: "где вы на шкале?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //3
        Exercise(   title: "butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //4
        Exercise(   title: "contact points + дыхание",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //5
        Exercise(   title: "butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //6
        Exercise(   title: "руки на бёдрах",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //7
        Exercise(   title: "заземление",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //8
        Exercise(   title: "назовите состояние вашей нервной системы",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //9
        Exercise(   title: "Рука на сердце и на животе",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //10
        Exercise(   title: "ощути, где в твоём теле остался стресс",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //11
        Exercise(   title: "что делает вам хорошо на сердце?",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //12
        Exercise(   title: "прописываем желаемое развитие ситуации",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //13
        Exercise(   title: "человек/место силы",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
        ),
        //14
        Exercise(   title: "что изменилось в вашем состоянии?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus.",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor, magna ut laoreet vehicula, orci erat vestibulum arcu, at facilisis nibh lacus in purus. Nulla porta risus quis mi ultricies, ut gravida nulla pharetra. Donec id nunc non dolor maximus luctus. Cras id leo sed lacus pretium pretium. Aenean commodo lectus sed hendrerit auctor.",
                    audioGuides: [K.audio.lesson1]
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
