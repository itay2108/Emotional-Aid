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
        Exercise(   title: "Что вас беспокоит?",
                    isAnimationPresent: true,
                    animationURLName: "02",
                    isSliderPresent: false,
                    theWhat: "сформулируйте, что именно вас тревожит. Можете назвать вслух, можете - про себя.",
                    theWhy: "Вам может казаться, что ответ на вопрос \"что вас беспокоит?\" и так очевиден, но попробуйте произнести его вслух, и многое предстанет перед вами в новом свете. Навык формулировать то, что вас беспокоит, очень важен. Когда мы даем имя проблеме, мы в каком-то смысле обретаем над ней власть. Не пропускайте этот первый и важнейший этап работы над стрессом. Причиной стресса может быть конкретное событие, которое только что произошло, воспоминания о недавнем событии, ассоциация с событиями из прошлого, мысли о будущем. Расскажите, что сейчас стало причиной вашего стресса?",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //2
        Exercise(   title: "где вы на шкале?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    scoreIndex: 0,
                    theWhat: "Выставьте ползунок на экране в ту точку, в которой, как вам кажется, вы сейчас находитесь. Из теоретической части вам известно, что состояние нервной системы под знаком \"-\" - это состояние гиповозбуждения, подавленности и апатии, отсутствия реакций на внешние стимулы. \"+\" - гипервозбуждение нервной системы, чрезмерная активность всех эмоциональных процессов, тревога, злость, страх, лавинообразный поток мыслей, учащенное сердцебиение и прочие симптомы. Где вы находитесь? Насколько сильно сейчас проявляется ваш стресс, по вашему мнению? Когда вы выставите ползунок, озвучьте (если обстоятельства не позволяют, сделайте это про себя), в каком состоянии вы находитесь? Например, \"я нахожусь в состоянии гиповозбуждения нервной системы\".",
                    theWhy: "Когда вы самостоятельно оцениваете уровень своего стресса, вы приобретаете сразу несколько важных навыков. Во-первых, вы учитесь различать реальность и собственное состояние. Согласитесь, между утверждениями \"я в отчаянии, что делать, это все плохо закончится\" и \"я сейчас нахожусь в состоянии гипервозбуждения нервной системы\" огромная разница. Во-вторых, вы развиваете навык интрацепции: внутреннего самонаблюдения. Вы не просто сливаетесь со своими состояниями, пока они вами управляют, а наблюдаете за собой изнутри. В-третьих, сама по себе попытка оценить уровень своего стресса в цифрах снижает градус ваших эмоций. Когда вы произносите \"Я нахожусь в состоянии гипервозбуждения нервной системы\", вы транслируете собственной психике сигнал о том, что вы, ваша жизнь, ваша безопасность и состояние вашей нервной системы - это не одно и то же.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //3
        Exercise(   title: "Butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "03",
                    isSliderPresent: false,
                    theWhat: "похлопайте себя по плечам 25 раз - левой рукой правое плечо, а правой - левое, как бы обняв себя за плечи. Вы можете выбрать любой комфортный темп, не бейте себя слишком быстро или сильно. Когда закончите, просто скажите \"дальше\" или нажмите на экран и переходите к следующему упражнению. Если вы захотите повторить это упражнение, вернитесь к нему на экране либо скажите \"повторить\", если вы хотите остановиться, скажите \"стоп\".",
                    theWhy: "На первый взгляд это упражнение просто символизирует объятия и любовь к себе. На самом деле, все гораздо глубже. Благодаря попеременному постукиванию по плечам правой и левой рукой возникает билатеральная стимуляция: попеременная активация правого и левого полушарий мозга. Это позволяет ему завершить процессинг, то есть обработку эмоций и событий: прогоревать, проплакать, прожить. Если кровоточащую рану держать в грязи и влаге и не обработать, организм будет постоянно бороться с воспалительным процессом, а рана превратиться в абсцесс. Чтобы этого не произошло, ране надо вовремя помочь затянуться. Так и со стрессом: если процессинга не случается, он рискует превратиться в травму. При помощи билатеральной стимуляции с точки зрения нейробиологии стресс приобретает завершенную форму, и психика готова идти дальше. Еще один эффект от этого упражнения - это эффект самообъятие. Активация верхнего вагального нерва, который воспринимает объятия как сигнал к успокоению. \"Я у себя есть, я себя люблю, я себя поддерживаю\". Восприняв этот месседж, верхний вагальный нерв посылает мозгу сигнал, что вы в безопасности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //4
        Exercise(   title: "Точки соприкосновения",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Устройтесь так, чтобы вам было удобно. Можно сидеть, можно лежать. Ощутите ваши точки соприкосновения с полом, спинкой стула, поверхностью стула или кровати (если вы лежите). Почувствуйте их, сфокусируйте на них все своё внимание. Постарайтесь расслабить каждую из точек, примите более расслабленную позу. Пройдитесь по телу мысленным взором и расслабьте те мышцы, которые зажаты. ",
                    theWhy: "Все последние исследования в области нейробиологии гласят: не только мозг дает команды телу, но и тело даёт команды мозгу, а значит, тело может напрямую влиять на наше психоэмоциональное состояние. Поза - один из основополагающих источников команд для мозга, потому что в зависимости от позы активируется центр давления, и мозг регулирует нервную систему \"вверх\" или \"вниз\". Когда вы напрягаете зоны тела, которые контактируют с поверхностью, вы меняете позу с обессиленной на более собранную и готовую к действиям. Если вы их расслабляете, поза наоборот из зажатой и напряженной поменяется на спокойную. Смена позы транслирует нервной системе нужный сигнал: умиротвориться или взбодриться.",
                    theWhatNegative: "Устройтесь так, чтобы вам было удобно. Можно сидеть, можно лежать. Ощутите ваши точки соприкосновения с полом, спинкой стула, поверхностью стула или кровати (если вы лежите). Почувствуйте их, сфокусируйте на них все своё внимание. Постарайтесь слегка напрячь каждую из точек, примите более собранную и готовую к действиям позу. Пройдитесь по телу мысленным взором и \"соберите\" те мышцы, которые безжизненны и атрофированы, постарайтесь наполнить их энергией.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //5
        Exercise(   title: "Дыхание",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Сейчас мы с вами сделаем так, чтобы дыхание работало на нас, в нашу пользу. С дыханием тесно связана частота сердечных сокращений, поэтому она тоже стабилизируется. Ваша задача - привести темп дыхания к тому, чтобы вдох был вдвое короче выдоха. То есть вдыхайте так, как вам сейчас комфортно, и если ваш вдох занимает, например, одну секунду, то выдох должен занимать две.  Подышите так с минуту.",
                    theWhy: "В обычной жизни наш выдох длиннее вдоха примерно в полтора раза. Это позволяет поддерживать оптимальную концентрацию кислорода в крови в состоянии покоя. В состоянии гипервозбуждения нервной системы ваша кровь перенасыщена кислородом, сердце бьётся чаще, скорее всего дышите вы тоже чаще обычного. организм \"на взводе\", мозг гипервентилирован. Если вы будете вдыхать и выдыхать в пропорции 1 к 2 (то есть выдох будет вдвое длиннее вдоха), то концентрация кислорода в крови и частота сердечных сокращений снизятся. Это активирует вагальный тормоз и вернет вас из состояния гиперактивации в окно толерантности. В состоянии же гиповозбуждения нервной системы у вас мало сил и энергии. Если вы сравняете длительность вдоха и выдоха, то концентрация кислорода в крови и частота сердечных сокращений увеличатся. Это поможет снять стоп-кран с вашей нервной системы, и вы получите дополнительный внутренний ресурс для восстановления сил.",
                    theWhatNegative: "Сейчас мы с вами сделаем так, чтобы дыхание работало на нас, в нашу пользу. С дыханием тесно связана частота сердечных сокращений, поэтому она тоже стабилизируется. Ваша задача - привести темп дыхания к тому, чтобы вдох длился столько же, сколько выдох. Вдыхайте так, как вам сейчас комфортно, и если ваш вдох занимает, например, одну секунду, то выдох должен занимать тоже одну секунду, если две, то и выдох - две. Подышите так с минуту",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //6
        Exercise(   title: "Butterfly hug",
                    isAnimationPresent: true,
                    animationURLName: "03",
                    isSliderPresent: false,
                    theWhat: "похлопайте себя по плечам 25 раз - левой рукой правое плечо, а правой - левое, как бы обняв себя за плечи. Вы можете выбрать любой комфортный темп, не бейте себя слишком быстро или сильно. Когда закончите, просто скажите \"дальше\" или нажмите на экран и переходите к следующему упражнению. Если вы захотите повторить это упражнение, вернитесь к нему на экране либо скажите \"повторить\", если вы хотите остановиться, скажите \"стоп\".",
                    theWhy: "Может показаться, что это упражнение просто символизирует любовь к себе. На самом деле, это далеко не просто символ. Попеременное постукивание по плечам правой и левой рукой активирует билатеральную стимуляцию. Билатеральная стимуляция - это попеременная активация правого и левого полушарий мозга. Она позволяет ему завершить процессинг, то есть обработку эмоций и событий: прогоревать, проплакать, прожить. Если кровоточащую рану не обработать надлежащим образом и держать в грязи и влаге, она будет болеть и нарывать. Ей необходимо помочь затянуться. Если процессинга не случается, стресс может превратиться в травму. При помощи билатеральной стимуляции с точки зрения нейробиологии стресс приобретает завершенную форму, и психика готова идти дальше. Еще один эффект от этого упражнения - это эффект самообъятие. Активация верхнего вагального нерва, который воспринимает объятия как сигнал к успокоению. Я у себя есть, я себя люблю, я себя поддерживаю, и верхний вагальный нерв посылает вам сигнал, что вы в безопасности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //7
        Exercise(   title: "Покачайте себя, как младенца в люльке и положите руки на бёдра",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Останьтесь в позе, в которой вы похлопывали себя по плечам. Покачайте себя в ней так, как качают младенцев какое-то время. Через минуту я вернусь и продложим. Если вы хотите прервать сессию, скажите \"стоп\". Теперь положите руки себе на бёдра. Сделайте это легко, спокойно, нежно, передавая себе тепло. Почувствуйте тепло своих рук на бёдрах. Побудьте так с минуту.",
                    theWhy: "Когда вы качаете себя, обняв за плечи, вы успокаиваете вагальный нерв. Бёдра - это точка, которая напрямую с ним связана, и таким образом вы тоже транслируете сигнал безопасности вашей нервной системе. Это упражнение в целом активирует вашу связь с телом, которая активируется через тактильный контакт.",
                    theWhatNegative: "Останьтесь в позе, в которой вы похлопывали себя по плечам. Покачайте себя в ней так, как качают младенцев какое-то время. Через минуту я вернусь и продложим. Если вы хотите прервать сессию, скажите \"стоп\". Теперь положите руки себе на бёдра. Постарайтесь почувствовать давление, которое руки создают на бёдрах. Немного прижмите их. Побудьте так с минуту.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1, negative: K.audio.lesson1Negative)
        ),
        //8
        Exercise(   title: "Заземление",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Ощутите ваши ноги, твёрдо стоящие на полу. Если обстоятельства позволяют - снимите обувь. Представьте, что ваши ноги пустили глубокие, крепкие корни. Ощутиье свою спину, плотно прижатую к какому-либо твердому объекту. Сосредоточьтесь на ваших ягодицах, на их контакте с креслом или стулом (если сидите). Побудьте в этом ощущении",
                    theWhy: "В психологии эта техника называется \"заземление\". Наша симпатическая нервная система реагирует на стресс, и через заземление мы помогаем экологично дезактивировать её. А еще когда мы \"заземляемся\". Техника зазмеления позволяет быть в моменте и снять ногу с педали газа. Заземлившись, мы даём вагальному тормозу может справиться со своей работой. Нашему мозгу все равно, присходит что-то на самом деле, или мы себе это представляем. И то, и другое для него - набор картинок. Поэтому даже если вы просто представляете себе корни, проросшие от ваших ног в землю, мозг воспринимает эту ситуацию как сигнал к успокоению.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //9
        Exercise(   title: "Оцените ваше состояние. Где вы на шкале?",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    scoreIndex: 1,
                    theWhat: "В этом упражнении мы снова вернемся к тому, чтобы оценить уровень стресса. Где вы сейчас на нашей шкале? Отметьте для себя, что изменилось с момента, когда вы выставляли ползунок в прошлый раз. Как будете готовы - переходите к следующему упражнению. Можете сказать \"дальше\" или переключиться на экране.",
                    theWhy: "Повторная оценка состояния нервной системы позволяет укрепить навык интрацепции, снова направить взгляд внутрь себя. Если ваше состояние с момента начала сессии изменилось, вы сможете это зафиксировать для себя, посмотреть на себя со стороны без критики. Вы включаете вашего внутреннего наблюдателя и безоценочно отмечаете для себя, каков теперь статус вашей нервной системы.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //10
        Exercise(   title: "Рука на сердце и на животе",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Положите одну руку на сердце, а вторую - на живот. Почувствуйте тепло и связь, которая возникает и циркулирует между ними. Теперь вспомните ситуацию, в которой ваша рука давала кому-то добро и тепло. Может быть, другим людям или животным. Побудьте в этом ощущении. Направьте его на себя. Прислушайтесь к себе и оставайтесь так около минуты. ",
                    theWhy: "Если вам показалось, что цель упражнения - \"подумать о хорошем\", то всё снова куда глубже. Как вы помните, мозг не отличает вымысел от действительности. Когда вы направляете на себя тепло и заботу в воображении, ваш мозг активирует систему социальной интеграции.  Самомилосердие и тепло абсолютно необходимы для развития вагального тормоза. У большинства людей, не получавших милосердия и заботы с детского возраста, он не развит. Самое время дать себе то, чего не хватало.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //11
        Exercise(   title: "Назовите 10 разных предметов вокруг себя",
                    isAnimationPresent: false,
                    isSliderPresent: false,
                    theWhat: "А сейчас посмотрите по сторонам. Назовите, пожалуйста, 10 предметов разных цветов вокруг себя. Теперь найдите 10 предметов разной консистенции и фактуры. Хорошо, если вы будете называть словами, какая у них фактура.  Постарайтесь услышать хотя бы несколько разных звуков. Отметьте несколько запахов. Оглянитесь вокруг - есть ли в тех обстоятельствах, в которых вы находитесь, какой-то предмет или деталь, которые вы никогда не замечали?",
                    theWhy: "Мы уделяли много внимания навыку интрацепции - способности к самонаблюдению. Тем не менее, экстрацепция - наблюдение, направленное вовне, не менее важно. При помощи перечисления разных по цвету и структуре предметов вокруг себя, мы развиваем этот навык, перенаправляя взгляд изнутри наружу, вместо того, чтобы все глубже зависать на гипер- или гиповозбуждении нервной системы.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //12
        Exercise(   title: "Где в вашем теле остался стресс?",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Прислушайтесь к телу. Постарайтесь прочувствовать, есть ли в нем область, где до сих пор остался и живет стресс? Это может быть зажатое горло, ком в груди, боль внизу живота или пояснице. Просто обратите внимание на эту область, не критикуя себя и ничего не пытаясь изменить. Положите на эту область руку. Назовите словами, что вы чувствуете физически. Примите это чувство, не борясь с ним. Понаблюдайте минуту. Вы попытались принять ощущения в теле, скажите, они по-прежнему остались Если нет, можем переходить к следующему упражнению. Если ощущения сохранились, попробуйте помочь телу: спросите его, чего бы оно хотело? Что могло бы ему помочь и сделать хорошо? Представьте это в течение минуты. Ощущения по-прежнему остались? Если нет, можем переходить к следующему упражнению. Если да они по-прежнему сохраняются, постарайтесь сделать обратное тому, что чувствует ваше тело. Если у вас что-то зажато - расслабьте, откройте то, что закрыто. Через минуту поймем, что изменилось. Ощущения должны были уйти или значительно ослабнуть. Если часть из них сохраняется - примите это и переходите к следующему упражнению.",
                    theWhy: "Работа с телом - важнейшее звено цепи грамотного снятия стресса. Наблюдая за физическими ощущениями и принимая их, вы преследуете несколько целей. Одна из них - развить навык принятия. Оно абсолютно необходимо для регуляции нервной системы. Когда вы выходите из состояние борьбы, вы уже снимаете ногу с педали газа и снижаете активность симпатической нервной системы. Прислушиваясь к сигналам тела и работя с ними, вы высвобождаете энергию из зажатых зон. Психика вытесняет травмы - все невыплаканные слезы, невысказанные обиды, невыраженную боль - но тело помнит все. Ком в горле, сжатые кулаки, сдвинутые брови, напряженная поясница хранят память о травме. Если потребность в безопасности не была удовлетворена с детства, эта память будет жить с человеком всю жизнь, поэтому ее необходимо высвободить и обнулить. Кстати, есть один очень эффективный способ быстро снять зажимы в теле: выполнить известное упражнение \"whoo-sound\". Когда почувствуете ком в горле или в груди, издайте звук, который издавал бы огромный океанский лайнер, входящий в порт в густом тумане. Положите руку на грудь: вы должны почувствовать под рукой вибрацию, это работа грудных резонаторов. Это выглядит странно, но поверьте, это работает. Таким образом вы используете язык тела, чтобы снять блоки в вашем теле и вывести нервную систему из зависания в состоянии гипер- или гипоактивации.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //13
        Exercise(   title: "Подумайте о том, чем вы очень любите заниматься",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Вспомните, что делает вам хорошо на сердце. Что вы очень любите делать? Представьте себе, что вы это делаешь в деталях и подробностях. Что вы чувствуете?",
                    theWhy: "Выполняя это упражнение, вы обращаетесь к ресурсам. Под влиянием стресса у человека нет внутренних ресурсов, а про внешние он чаще всего забывает, поэтому надо притащить их извне. Для этого вы можете использовать нейропластичности: вы воссоздаете в голове картинку ресурса, а ваш мозг реагриует на неё по-настоящему, ведь он не различает воображение и действительность. То, что хранится у вас в памяти - набор картинок. Если вы собираетесь, например, ехать на море, и мысль о предстоящем отпуске радует вас - это тоже набор картинок, и мозг на языке гормонов и нейромедиаторов говорит в ответ: \"мне от этого хорошо\". В состоянии залипания педали газа или стоп-крана человеку могут помочь внутренние и внешние ресурсы. Они провоцируют выработку окситоцина - гормона удовольствия и близости - а он, в свою очередь, умеет воздействовать на систему умиротворения. Если мы представляем себе, как занимаемся тем, что нам действительно нравится, окситоцин возвращает нас к окну толерантности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //14
        Exercise(   title: "Продумайте желаемое развитие ситуации",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Попробуйте вернуться к источнику стресса. К той тревожной мысли или ситуации, которые стали его триггером. Что случилось - то уже случилось, мы не можем отыграть назад, но дальше ситуация может развиваться по-разному. Представьте себе ,что могло бы вам помочь в этой ситуации? Представьте, что это уже происходит. Если не получается, представьте позитивный сценарий развития тревожной ситуации и happy end от нынешнего момента. Что в идеале должно начать происходить сейчас, чтобы ситуация завершилась наилучшим образом для вас?",
                    theWhy: "Когда вы задаете себе вопрос: \"Что бы мне помогло в этой ситуации?\", исходите из того, что ситуация, которая вызвала стресс, уже случилась. Этот факт требует принятия: вы не можете повернуть колесо жизни вспять. Что могло бы помочь вам в развитии событий начиная с этой минуты?  Если от вас ушла жена, то нет смысла представлять себе, что она не ушла от вас: это уже случилось. Однако вы можете представить себе, что действительно помогло бы вам в дальнейшем: встреча с поддерживающими друзьями? Новая семья? Переезд в другую страну? Новая более перспективная работа, на которую теперь появится время? Таким образом вы вновь используете нейропластичность. Воображая позитивное развитие событий, вы создаёте новые нейронные связки и предлагаете мозгу параллельную историю. Он воспринимает ее как равносильную случившейся, дает сигнал железам вырабатывать соответствующие гормоны и нейромедиаторы. В конечном итоге всё это возвращает вас к окну толерантности.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //15
        Exercise(   title: "Подумайте о близком человеке и месте силы",
                    isAnimationPresent: true,
                    animationURLName: "relax",
                    isSliderPresent: false,
                    theWhat: "Есть ли в вашей жизни человек, который всегда поймет и поддержит? Который будет теплым, принимающим и не критичным по отношению к вам? Если да, вспомните какие-то яркие моменты общения с ним или с ней. Что вы чувствовали, как вас это успокаивало или дарило радость. Как прочна ваша связь, как она вас поддерживала, как она сформировалась. Представьте себе в деталях этого человека и ваше взаимодействие с ним.  Если есть какое-то место силы, где вам хорошо и безопасно - представьте себе его, что вы в нем. Что вы делаете, что чувствуете? Побудьте минуту с этими образами, мыслями и ощущениями.",
                    theWhy: "Мысли о ком-то, кто не критичен к вам, кто вас принимает и любит, стимулируют выработку окситоцина и активируют систему социальной интегрированности. Как вы уже знаете, и то, и другое - это составляющие вашей тормозной системы. Представляя себе место, в котором вам действительно хорошо, вы воздействуете на верхний отдел вагального нерва и даёте ему возможность экологично затормозить без необходимости дергать стоп-кран.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
        ),
        //16
        Exercise(   title: "Что изменилось в вашем состоянии? ",
                    isAnimationPresent: false,
                    isSliderPresent: true,
                    scoreIndex: 2,
                    theWhat: "Давайте снова оценим, в каком статусе сейчас находится наша нервная система. Мы проделали большой путь, что изменилось? Где вы теперь на шкале? Произнесите по возможности вслух название состояния вашей нервной системы. Стало ли вам лучше? Как будете готовы, нажмите \"завершить сессию\".",
                    theWhy: "Когда вы фиксируете свое состояние в конце сессии, вы снова обращаетесь к навыку самонаблюдения. Вы продолжаете систематично учить свой мозг тому, что гипер- или гипоактивация вашей нервной системы - это сигнал о том, что ей нужна адекватная помощь. Вы не обязаны срочно успокаиваться, но вы можете помогать нервной системе экологично выходить из стресса, используя безопасные механизмы. Положительная динамика придаст вам сил, мотивации и уверенности в себе.",
                    audioGuide: AudioGuide(positive: K.audio.lesson1, positiveShort: K.audio.lesson1)
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
