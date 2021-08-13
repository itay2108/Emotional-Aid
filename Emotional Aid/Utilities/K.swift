//
//  K.swift
//  Emotional Aid
//
//  Created by itay gervash on 14/06/2021.
//

import UIKit

    struct K {
        
        struct colors {
            static let appRed = UIColor(named: "ea_red")
            static let appRedLight = UIColor(named: "ea_red_light")
            static let appBlue = UIColor(named: "ea_blue")
            static let appBlueDark = UIColor(named: "ea_blue_dark")
            static let appText = UIColor(named: "ea_text")
            static let appOffWhite = UIColor(named: "ea_offwhite")
        }
        
        struct uikit {
            static let hamburgerMenuButton = UIImage(named: "menu_button")
            static let backButton = UIImage(named: "back_button")
            static let xButton = UIImage(named: "x_button")
            static let logo = UIImage(named: "logo")
            static let demobar = UIImage(named: "bar_1")
            static let successArt = UIImage(named: "success-art")
            static let failArt = UIImage(named: "fail-art")
            
            static let lineScribble1 = UIImage(named: "line-scribble-1")
            static let lineScribble2 = UIImage(named: "line-scribble-2")
            static let lineScribble3 = UIImage(named: "line-scribble-3")
        }
        
        struct audio {
            static let lesson1 = Bundle.main.url(forResource: "lesson", withExtension: "wav")
            static let lesson1Negative = Bundle.main.url(forResource: "lessonNegative", withExtension: "wav")
        }
        
        struct text {
            
            static let failDidNotHelpDescription = "Вы прошли весь цикл упражнений и проделали большую работу. Мы видим, что состояние вашей нервной системы не улучшилось: видимо, на этот раз, стресс оказался сильнее. Если вы не уверены в том, что выполняли все упражнения с целью позаботиться о себе и помочь себе, ругали себя в процессе или выполнили не все упражнения, попробуйте начать заново. Если вы все сделали, но состояние не изменилось, вполне вероятно, вам мешает психотравма, которая активируется во время стресса и не дает с ним справиться. Больше информации о психотравме и наш видеокурс можно посмотреть здесь"
            
            static let warningBecamePositiveDescription = "Вам удалось значительно изменить состояние нервной системы, это значит, все работает. Кажется, в процессе выполнения упражнений ваше состояние перешло из гиповозбуждения нервной системы в гипервозбуждение. Может быть, перфекционизм не давал вам расслабиться и вы боялись выполнить упражнения неправильно или боялись неуспеха. В любом случае, пока мы только учимся навыкам саморегуляции, и на первых порах иногда бывает довольно трудно калибровать свои состояния, это абсолютно нормально. Если есть возможность, попробуйте пройти цикл еще раз, указав во втором упражнении текущее состояние вашей нервной системы."
            static let warningBecameNegativeDescription = "Вам удалось значительно изменить состояние нервной системы, значит, все работает. Кажется, в процессе выполнения упражнений ваше состояние перешло из гипервозбуждения нервной системы в гиповозбуждение. Может быть, гипервозбуждение было слишком сильным, и в процессе привычным образом включился стоп-кран. В любом случае, пока мы только учимся навыкам саморегуляции, и на первых порах иногда бывает довольно трудно калибровать свои состояния, это абсолютно нормально. Если есть возможность, попробуйте пройти цикл еще раз, указав во втором упражнении текущее состояние вашей нервной системы."
            
            static let successBecamePositiveDescription = "Вам удалось значительно изменить состояние нервной системы, это значит, все работает. Кажется, в процессе выполнения упражнений ваше состояние трансформировалось из гиповозбуждения нервной системы в гипервозбуждение. Может быть, перфекционизм не давал вам расслабиться и вы боялись выполнить упражнения неправильно или боялись неуспеха. В любом случае, пока мы только учимся навыкам саморегуляции, и на первых порах иногда бывает довольно трудно калибровать их. Мы рядом!"
            static let successBecameNegativeDescription = "Вам удалось значительно изменить состояние нервной системы, значит, все работает. Кажется, в процессе выполнения упражнений ваше состояние немного трансформировалось из гипервозбуждения нервной системы в гиповозбуждение. Может быть, гипервозбуждение было слишком сильным, и в процессе привычным образом включился стоп-кран. В любом случае, пока мы только учимся навыкам саморегуляции, и на первых порах иногда бывает довольно трудно калибровать свои состояния, это абсолютно нормально. Мы рядом!"
            
            static let successDescriptionA = "Поздравляем, вы  проделали огромную работу и помогли себе справиться со стрессом! Перед тем, как начать сессию, вы оценили своё состояние "
            static let successDescriptionB = ", сейчас оно "
            static let successDescriptionC = ". Рады, что вам удалось приблизиться к балансу! С каждым разом ваша нервная система будет всё увереннее овладевать навыком саморегуляции. Если что, мы рядом!"
            
            static let authDescription = "Зарегистрируйтесь, чтобы получить возможность просматривать видеоматериалы, выполнять упражнения, редактировать личную информацию или назначать консультации."
            
            struct errorDescriptions {
                static let blankError = "Please enter"
                static let tooShort = "too short"
                static let nameRequirements = "Names must contain only letters of the alphabet"
                static let emailRequirements = "Invalid email format"
                static let passwordRequirements = "Passwords must be 4-32 characters long"
                static let passwordContainsSpaces = "Passwords must not contain spaces"
                
                static let signInGeneric = "Coldn't sign in - please try again"
                static let noSuchUser = "We couldn't find a user with this email"
                static let wrongPassword = "wrong password"
            }

        }
        
        struct regEx {
            static let name = "^(([a-zA-Z]){2,}(\\ {1}([a-zA-Z]){1,}){0,4}?){2,64}$"
            static let email = "[a-zA-Z0-9._%+-]{1,64}\\@{1}[a-zA-Z0-9._%+-]{1,64}\\.{1}[a-zA-Z]{2,32}"
            static let password = "^(?=.*[A-Za-z])[A-Za-z\\d@$!%*?&]{4,32}$"
        }
        
    }
