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
        
        static let eyeFill = UIImage(systemName: "eye.fill")
        static let eyeFillWithSlash = UIImage(systemName: "eye.slash.fill")
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
        
        static let verificationDescription = "Мы отправили вам письмо на \(UserDefaults.standard.string(forKey: K.def.email) ?? "NaN@mail.co"), чтобы подтвердить ваш e-mail и активировать аккаунт."
        
        static let consultationFormDescription = "Заполните форму, если вы хотели бы записаться на консультацию в наш центр - и мы вам перезвоним"
        
        static let privacyAndTermsDescription: NSMutableAttributedString = {
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let attributedString = NSMutableAttributedString(string: "Регистрируясь, вы соглашаетесь с условиями пользовательского соглашения и политикой конфиденциальности", attributes: [.paragraphStyle: style])
            
            attributedString.addAttribute(.font, value: FontTypes.shared.ubuntuLight.withSize(11 * UIViewController().heightModifier), range: NSRange(location: 0, length: attributedString.length))
            
            attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 33, length: 38))
            attributedString.addAttribute(.font, value: FontTypes.shared.ubuntu.withSize(11 * UIViewController().heightModifier), range: NSRange(location: 33, length: 38))
            
            attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 74, length: 28))
            attributedString.addAttribute(.font, value: FontTypes.shared.ubuntu.withSize(11 * UIViewController().heightModifier), range: NSRange(location: 74, length: 28))
            
            return attributedString
        }()
        
        struct errorDescriptions {
            static let blankError = "Please enter"
            static let tooShort = "too short"
            static let nameRequirements = "Names must contain only letters of the alphabet"
            static let emailRequirements = "Invalid email format"
            static let passwordRequirements = "Passwords must be 4-32 characters long"
            static let passwordContainsSpaces = "Passwords must not contain spaces"
            static let phoneFormat = "Please input a valid phone format"
            
            static let signInGeneric = "Coldn't sign in - please try again"
            static let signUpGeneric = "Couldnt sign up - please try again"
            static let usernameExists = "A user with this email already exists"
            static let noSuchUser = "We couldn't find a user with this email"
            static let wrongPassword = "wrong password"
        }
        
    }
    
    struct def {
        static let email = "userEmail"
        static let password = "userPassword"
        static let name = "userName"
    }
    
    struct regEx {
        static let name = "^(([a-zA-Zא-תа-яА-Я]){2,}(\\ {1}([a-zA-Zא-תа-яА-Я]){1,}){0,4}?){1,32}[\\s]*$"
        static let email = "[a-zA-Z0-9._%+-]{1,64}\\@{1}[a-zA-Z0-9._%+-]{1,64}\\.{1}[a-zA-Z]{2,32}"
        static let password = "^(?=.*[A-Za-z])[A-Za-z\\d@$!%*?&]{4,64}$"
        static let phone = "^([\\d\\s-+]){8,}$"
    }
    
    struct locale {
        static let countryCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
    }
    
    struct speechTriggers {
        static let next: [TriggerWord] = [TriggerWord("Дальше", type: .next),
                                          TriggerWord("Дар Дар", type: .next),
                                          TriggerWord("Да Да", type: .next),
                                          TriggerWord("Дорогая", type: .next),
                                          TriggerWord("Дорогуша", type: .next),
                                          TriggerWord("Да Алишер", type: .next),
                                          TriggerWord("До Алишера", type: .next),
                                          TriggerWord("Дар алишера", type: .next),
                                          TriggerWord("Дорадо Шрек", type: .next),
                                          
                                          TriggerWord("Следующее", type: .next),
                                          TriggerWord("Следующие", type: .next),
                                          TriggerWord("Следующий", type: .next),
                                          
                                          TriggerWord("Продолжить", type: .next),
                                          
                                          TriggerWord("Далее", type: .next),
                                          TriggerWord("Да Лирик", type: .next),
                                          
                                          TriggerWord("Вперёд", type: .next),
                                          TriggerWord("Период", type: .next)
                                          ]
        
        static let rewind: [TriggerWord] = [TriggerWord("Повтор", type: .rewind),
                                            TriggerWord("Уруру", type: .rewind),
                                            TriggerWord("Туру", type: .rewind),
                                            TriggerWord("Пора", type: .rewind),
                                            
                                            TriggerWord("Назад", type: .rewind),
                                            TriggerWord("Надо", type: .rewind),
                                            TriggerWord("Арарат", type: .rewind),
                                            TriggerWord("Нора Зад", type: .rewind),
                                            
                                            TriggerWord("Вернуться", type: .rewind),
                                            TriggerWord("Вернут", type: .rewind),
                                            TriggerWord("Выбери", type: .rewind)]
    }
    
}
