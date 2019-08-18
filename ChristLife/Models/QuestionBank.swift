//
//  QuestionBank.swift
//  ChristLife
//
//  Created by Kirlos Yousef on 2019. 08. 05..
//  Copyright © 2019. Kirlos Yousef. All rights reserved.
//

import Foundation

class QuestionBank{
    var list = [Question]()
    
    init() {
        list.append(Question(question: "خلقنا الله", optionA: "لكى نسبحه", optionB: "لنعيش فى الفردوس", optionC: "لانه احبنا", correctAnswer: 3))
        
        list.append(Question(question: "من مرض في رجلة؟", optionA: "بعشا", optionB: "يهوشافاط", optionC: "اّسا", correctAnswer: 3))
        
        list.append(Question(question: "من مات خنقا؟", optionA: "احشويروش", optionB: "بنهدد", optionC: "بيلاطس", correctAnswer: 2))
        
        list.append(Question(question: "من حفر قبرة بنفسة ؟", optionA: "يعقوب", optionB: "يهوذا", optionC: "يوسف", correctAnswer: 1))
        
        list.append(Question(question: "ترشيش هو اسم", optionA: "نهر", optionB: "سيدة", optionC: "مدينة", correctAnswer: 3))
        
        list.append(Question(question: "القديس الانبا بيشوى كان", optionA: "أسقف", optionB: "راهب", optionC: "سائح", correctAnswer: 2))
        
        list.append(Question(question: "تحنن الرب على أرملة نايين وقال لها", optionA: "لا تخافى", optionB: "لا تبكى", optionC: "إفرحى", correctAnswer: 2))
        
        list.append(Question(question: "ترك لوط سدوم عندما", optionA: "أحس بشر المدينة", optionB: "أرشده الله", optionC: "أخذ الملاكان بيده", correctAnswer: 3))
        
        list.append(Question(question: "قاد يشوع شعب إسرائيل فى عبور", optionA: "النيل", optionB: "البحر الأحمر", optionC: "نهر الاردن", correctAnswer: 3))
        
        list.append(Question(question: "إثبات محبتى الكاملة إلى الله", optionA: "اطلبه فى الضيقات", optionB: "أصلى له فى الكنيسة", optionC: "أتحدث معه فى كل وقت", correctAnswer: 3))
        
        list.append(Question(question: "عندما نحضر القداس نركز تفكيرنا فى", optionA: "جمال الكنيسة", optionB: "أعمال الخير", optionC: "صلاة القداس", correctAnswer: 3))
        
        list.append(Question(question: "أعظم أعيادنا المسيحية هو عيد", optionA: "القيامة", optionB: "الغطاس", optionC: "الميلاد", correctAnswer: 1))
        
        list.append(Question(question: "قال السيد المسيح : أليس العشرة قد طهروا أين", optionA: "اهلهم", optionB: "ذهبوا", optionC: "التسعة", correctAnswer: 3))
        
        list.append(Question(question: "تعجب معلموا اليهود بيسوع من فهمه وأجوبته وهو عمره", optionA: "8", optionB: "12", optionC: "15", correctAnswer: 2))
        
        list.append(Question(question: "حياة التوبة يمكن أن تكون فى", optionA: "لحظة واحدة", optionB: "طول الحياة", optionC: "قبل الاعتراف مباشرة", correctAnswer: 2))
        
        list.append(Question(question: "فى نهاية التجربة كان أيوب", optionA: "صار مسيحيا", optionB: "أحب الله أكثر", optionC: "ترك الله", correctAnswer: 2))
        
        list.append(Question(question: "عندما ذهبت المجدلية للقبر ظنت الرب", optionA: "البستانى", optionB: "أحد الجنود", optionC: "راعى", correctAnswer: 1))
        
        list.append(Question(question: "قبل الله توبة بطرس لأنه", optionA: "كان يحبه أكثر من يهوذا", optionB: "ندم وتاب", optionC: "لم ينتحر", correctAnswer: 2))
        
        list.append(Question(question: "مرض البرص كان يرمز إلى", optionA: "الضعف", optionB: "الفقر", optionC: "النجاسة", correctAnswer: 3))
        
        list.append(Question(question: "لم يخف الثلاث فتية من أتون النار", optionA: "ليأسهم", optionB: "لأن الله كان معهم", optionC: "لتوقعهم الهرب", correctAnswer: 2))
        
        list.append(Question(question: "كانت نتيجة شهادة المعمدان بالحق", optionA: "مكافأته", optionB: "جلده", optionC: "قطع رأسه", correctAnswer: 3))
        
        list.append(Question(question: "عند الصليب إعترف ..... بأن يسوع هو ابن الله", optionA: "قائد المائة", optionB: "اللص اليمين", optionC: "الشعب", correctAnswer: 1))
        
        list.append(Question(question: "عندما نصلى نطلب اولاً", optionA: "شفاء المرضى", optionB: "ملكوت الله وبره", optionC: "لأجل الفقراء", correctAnswer: 2))
        
        list.append(Question(question: "نحصل على مسحة الروح القدس فى سر", optionA: "مسحة المرضى", optionB: "الميرون", optionC: "التناول", correctAnswer: 2))
        
        list.append(Question(question: "أعظم إحترام للكتاب المقدس هو", optionA: "حفظ آياته", optionB: "قراءته كل يوم", optionC: "تنفيذ ما جاء به", correctAnswer: 3))
        
        list.append(Question(question: "خطية آدم الأولى هى", optionA: "الكبرياء", optionB: "الهروب من الله", optionC: "القاء الخطاء على حواء", correctAnswer: 1))
        
        list.append(Question(question: "ظهرت الملائكة للرعاة لأنهم كانوا", optionA: "قرب بيت لحم", optionB: "بسطاء", optionC: "ساهرين", correctAnswer: 3))
        
        list.append(Question(question: "أحب القديس أثناسيوس المسيحية لأنه", optionA: "قرأ عنها كثيرًا", optionB: "له أصدقاء مسيحيين", optionC: "كره الوثنية", correctAnswer: 2))
        
        list.append(Question(question: "كان السيد المسيح يصنع الخير مع", optionA: "الأبرار", optionB: "كل الناس", optionC: "الأشرار", correctAnswer: 2))
        
        list.append(Question(question: "نحن نقدس يوم الأحد لأن فيه", optionA: "نصلى", optionB: "دخل الرب أورشليم", optionC: "تذكار القيامة", correctAnswer: 3))
        
        list.append(Question(question: "أشبع السيد المسيح الجموع لأنه", optionA: "بارك أكل السمك", optionB: "رأى الوقت أمسى", optionC: "تحنن عليهم", correctAnswer: 3))
        
        list.append(Question(question: "يمكننى أن أعيش فى السماء", optionA: "فى الكنيسة", optionB: "بعد الانتقال من العالم", optionC: "بالتفكير فيها", correctAnswer: 1))
        
        list.append(Question(question: "واجه داود جليات بدلاً من", optionA: "هيرودس", optionB: "شمشون", optionC: "شاول", correctAnswer: 3))
        
        list.append(Question(question: "يعتبر ..... الذى عاش 969 سنة أطول من عاش عمرًا", optionA: "أخنوخ", optionB: "متوشالح", optionC: "قايين", correctAnswer: 2))
        
        list.append(Question(question: "تجتمع صفات ملك ونبى وشاعر وموسيقار فى", optionA: "صموئيل", optionB: "داود", optionC: "بولس", correctAnswer: 2))
        
        list.append(Question(question: "طمع الملك آخاب فى كرم ..... اليزراعيلى ثم أخذه", optionA: "نابال", optionB: "ناحوم", optionC: "نابوت", correctAnswer: 3))
        
        list.append(Question(question: "قال الغنى ..... اقوم واهدم مخازنى وابنى اكبر منها", optionA: "لابراهيم", optionB: "للعازر", optionC: "لنفسه", correctAnswer: 3))
        
        list.append(Question(question: "التلميذ الذى اتبع السيد المسيح من لحظة القبض علية حتى المحاكمة", optionA: "متياس", optionB: "يوحنا", optionC: "توما", correctAnswer: 2))
        
        list.append(Question(question: "كانت أرملة ..... تعول ايليا النبى وقت الجفاف", optionA: "لوط", optionB: "نايين", optionC: "صرفة صيدا", correctAnswer: 3))
        
        list.append(Question(question: "عاش فى سبى بابل أنبياء معروفين مثل ..... النبى", optionA: "موسى", optionB: "دانيال", optionC: "داود", correctAnswer: 2))
        
        list.append(Question(question: "أخذ ..... الرامى جسد الرب يسوع وكفنه", optionA: "يوسف", optionB: "سمعان", optionC: "إسحق", correctAnswer: 1))
        
        list.append(Question(question: "أبراء السيد المسيح أذن عبد رئيس", optionA: "الكهنة", optionB: "الكتبة", optionC: "المئة", correctAnswer: 1))
        
        list.append(Question(question: "القديس الذى اصبحنا بفضله مسيحيين هو مار", optionA: "مرقس", optionB: "متى", optionC: "بولس", correctAnswer: 1))
        
        list.append(Question(question: "القديسة ..... لها شرف العثور على خشبة الصليب المقدسة", optionA: "هيلانة", optionB: "رفقة", optionC: "صوفيا", correctAnswer: 1))
        
        list.append(Question(question: "الوحيد الذى جاء اسمه فى أمثال الرب يسوع", optionA: "لعازر", optionB: "ديماس", optionC: "نيقوديموس", correctAnswer: 1))
        
        list.append(Question(question: "استشهد مار جرجس فى عصر الملك", optionA: "قسطنطين", optionB: "هيرودس", optionC: "دقلديانوس", correctAnswer: 3))
        
        list.append(Question(question: "ابرز من كان فى مجمع نيقية هو القديس", optionA: "كيرلس", optionB: "شنودة", optionC: "أثناسيوس", correctAnswer: 3))
        
        list.append(Question(question: "سالموا ..... الناس", optionA: "بعض", optionB: "جميع", optionC: "أحب", correctAnswer: 2))
        
        list.append(Question(question: "لتستقيم صلاتى ..... قدامك", optionA: "يارب", optionB: "كالبخور", optionC: "سريعًا", correctAnswer: 2))
        
        list.append(Question(question: "ثقوا انا قد غلبت", optionA: "الأشرار", optionB: "الأقوياء", optionC: "العالم", correctAnswer: 3))
        
        list.append(Question(question: "إدخلوا من الباب", optionA: "الواسع", optionB: "الضيق", optionC: "السهل", correctAnswer: 2))
        
        list.append(Question(question: "واظبوا على ..... ساهرين فيها بالشكر", optionA: "الصلاة", optionB: "الصدقة", optionC: "الصوم", correctAnswer: 1))
        
        list.append(Question(question: "ينبغى أن يطاع الله اكثر من", optionA: "القديسين", optionB: "الملائكة", optionC: "الناس", correctAnswer: 3))
        
        list.append(Question(question: "يا ابنى اعطنى قلبك ولتلاحظ عيناك", optionA: "العالم", optionB: "طرقى", optionC: "الإنجيل", correctAnswer: 2))
        
        list.append(Question(question: "إن كل من يعمل الخطية هو ..... للخطية", optionA: "عبد", optionB: "محب", optionC: "مطيع", correctAnswer: 1))
        
        list.append(Question(question: "..... لأجل معاصينا مسحوق لأجل آثامنا", optionA: "مجروح", optionB: "أهين", optionC: "دفن", correctAnswer: 1))
        
        list.append(Question(question: "المساير الحكماء يصير ..... مرفيق الجهال يضر", optionA: "هادئًا", optionB: "غنيًا", optionC: "حكيمًا", correctAnswer: 3))
        
        list.append(Question(question: "من يأكل ..... ويشرب دمى فله حياة أبدية", optionA: "جسدى", optionB: "هذا", optionC: "ذلك", correctAnswer: 1))
        
        list.append(Question(question: "لا يغلبنك الشر بل إغلب الشر", optionA: "بالهروب", optionB: "بالهجوم", optionC: "بالخير", correctAnswer: 3))
    }
}
