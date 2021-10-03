//
//  VerbConjugationBrain.swift
//  JapaneseVerbTransform
//
//  Created by Дмитрий Скоробогаты on 28.09.2021.
//

import Foundation
import NaturalLanguage

class VerbTransformBrain {
    
    private let verb2conjugationExeptionKanji = ["嘲る","焦る","弄る","入る","要る","限る","帰る","切る","軋る","蹴る","混じる","参る","詰る","握る","罵る","練る","茂る","湿る","知る","誹る","滑る","喋る","散る","照る","入る","走る","捻る","減る"]
    
    private let verb2conjugationExeptionKana = ["あざける","あせる","いじる","いる","せびる","かぎる","かじる","かえる","きる","きしる","ける","まじる","こんじる","まいる","むしる","なじる","にぎる","ののしる","ねる","しげる","しめる","しる","そしる","すべる","しゃべる","ちる","てる","はいる","はしる","ひねる","へる","ふける"]
    
    private let conjugation1Kana: [Character] = ["く","ぐ","う","す","ぬ","ふ","ぷ","つ","む"]
    
    
    //MARK:- Determine verb conjugation
    func verbConjugation(_ verb: String) -> Bool {
        
        let kanaVerb = verb.hiragana
        let romajiVerb = kanaVerb.applyingTransform(.toLatin, reverse: false)
  
        if verb2conjugationExeptionKana.contains(verb) || verb2conjugationExeptionKanji.contains(verb) {
            return true
        } else if verb == "寝る" {
            return false
        }
        if romajiVerb!.hasSuffix("iru") || romajiVerb!.hasSuffix("eru") {
            return false
        } else {
            return true
        }
    }
    

    //MARK:- Find all 5 base of verb
    func verbBase(_ verb: String, numberOfBase: Int) -> String{
        
        let verbRoot = verb.dropLast()
        var resultVerb = ""
        let verb1End = ["か","が","わ","さ","な","は","ば","た","ま","ら"]
        let verb2End = ["き","ぎ","い","し","に","ひ","び","ち","み","り"]
        let verb3End: [Character] = ["く","ぐ","う","す","ぬ","ふ","ぶ","つ","む"]
        let verb4End = ["け","げ","え","せ","ね","へ","べ","て","め","れ"]
        let verb5End = ["こう","ごう","おう","そう","のう","ほう","ぼう","とう","もう","ろう"]
        var endings: [String] {
            get {
                if numberOfBase == 1{
                    return verb1End
                } else if numberOfBase == 2 {
                    return verb2End
                } else if numberOfBase == 4 {
                    return verb4End
                } else if numberOfBase == 5 {
                    return verb5End
                } else {
                    return verb3End.map{String($0)}
                }
            }
        }
        var index = 0

        for char in verb3End {
            if char == verb.last! {
                break
            }
            index += 1
        }
        
        if numberOfBase == 1 || numberOfBase == 2 {
            if verbConjugation(verb) {                             //определяем спряжение глагола
                resultVerb = verbRoot + endings[index]
            } else {
                resultVerb = String(verbRoot)
            }
        } else {
            resultVerb = verbRoot + endings[index]                  //если нужна 4 или 5 форма глагола
        }
        
        if numberOfBase == 3 {
            resultVerb = verb                           //если вдруг нужна 3 (словарная форма)
        }
        
        return resultVerb
    }
    
    //MARK:- Create masu form
    func masuForm(_ verb: String) -> String {
        return verbBase(verb, numberOfBase: 2) + "ます"
    }
    
    //MARK:- Create nakereba narimasen form
    
    func nakerebaNarimasenForm(_ verb: String) -> String {
        return verbBase(verb, numberOfBase: 1) + "なければなりません"
    }
    
    //MARK:- Create te form
    
    func teForm(_ verb: String) -> String {
        
        var resultVerb = ""
        let verbRoot = verb.dropLast()
        let kana1: [Character] = ["う", "つ", "る"]
        let kana2: [Character] = ["ぶ", "む", "ぬ"]
        let kana3: [Character] = ["く", "ぐ",]
        
        if verbConjugation(verb) {
            if kana1.contains(verb.last!) || verb == "行く" {
                resultVerb = verbRoot + "って"
            } else if kana2.contains(verb.last!) {
                resultVerb = verbRoot + "んで"
            } else if verb.last! == kana3[0] {
                resultVerb = verbRoot + "いて"
            } else if verb.last! == kana3[1] {
                resultVerb = verbRoot + "いで"
            } else {
                resultVerb = verbRoot + "して"
            }
            
        } else {
            resultVerb = verbRoot + "て"
        }
        return resultVerb
    }
    
    //MARK:- Create ta form
    
    func taForm(_ verb: String) -> String {
        
        let teFormVerb = teForm(verb)
    
        if teFormVerb.last == "て" {
            return teFormVerb.dropLast() + "た"
        } else {
            return teFormVerb.dropLast() + "だ"
        }
    }
    
    //MARK:- Negative form
    func negativeForm(_ verb: String) -> String {
        let firstBase = verbBase(verb, numberOfBase: 1)
        return firstBase + "ない"
    }
    
    //MARK:- Potencial form
    func potencialForm(_ verb: String) -> String {
        if verbConjugation(verb) {
            return verbBase(verb, numberOfBase: 4) + "る"
        } else {
            return verb.dropLast() + "られる"
        }
    }
    //MARK:- Define input language
    func detectedLanguage(for string: String) -> String? {
        
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
        return detectedLanguage
        
    }
}
