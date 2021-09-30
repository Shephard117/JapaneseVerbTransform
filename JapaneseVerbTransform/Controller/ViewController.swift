//
//  ViewController.swift
//  JapaneseVerbTransform
//
//  Created by Дмитрий Скоробогаты on 28.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kanaTextfield: UITextField!
    @IBOutlet weak var conjugationLabel: UILabel!
    
    let verb2conjugationExeptionKanji = ["嘲る","焦る","弄る","入る","要る","限る","帰る","切る","軋る","蹴る","混じる","参る","詰る","握る","罵る","練る","茂る","湿る","知る","誹る","滑る","喋る","散る","照る","入る","走る","捻る","減る"]
    
    let verb2conjugationExeptionKana = ["あざける","あせる","いじる","いる","せびる","かぎる","かじる","かえる","きる","きしる","ける","まじる","こんじる","まいる","むしる","なじる","にぎる","ののしる","ねる","しげる","しめる","しる","そしる","すべる","しゃべる","ちる","てる","はいる","はしる","ひねる","へる","ふける"]
    
    let conjugation1Kana: [Character] = ["く","ぐ","う","す","ぬ","ふ","ぷ","つ","む"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func defineConjugation(_ sender: UIButton) {
        
        if sender.currentTitle == "Узнать спряжение" {
            conjugationLabel.text = verbConjugation(kanaTextfield.text!) ? "Первое спряжение" : "Второе спряжение"
        } else if sender.currentTitle == "ます форма" {
            conjugationLabel.text = masuForm(kanaTextfield.text!)
        }
    }
    
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
    
    func masuForm(_ verb: String) -> String {
        return verbForm(verb, numberOfForm: 2) + "ます"
    }
    
    func verbForm(_ verb: String, numberOfForm: Int) -> String{
        
        let verbRoot = verb.dropLast()
        var resultVerb = ""
        let verb1End = ["か","が","わ","さ","な","は","ば","た","ま","ら"]
        let verb2End = ["き","ぎ","い","し","に","ひ","び","ち","み","り"]
        let verb3End: [Character] = ["く","ぐ","う","す","ぬ","ふ","ぷ","つ","む"]
        let verb4End = ["け","げ","え","せ","ね","へ","べ","て","め","れ"]
        let verb5End = ["こ","ご","お","そ","の","ほ","ぼ","と","も","ろ"]
        var endings: [String] {
            get {
                if numberOfForm == 1{
                    return verb1End
                } else if numberOfForm == 2 {
                    return verb2End
                } else if numberOfForm == 4 {
                    return verb4End
                } else if numberOfForm == 5 {
                    return verb5End
                } else {
                    return verb3End.map{String($0)}
                }
            }
        }
        
        var index = 0
        
        for char in verb3End {
            if char == verb.last {
                break
            }
            index += 1
        }
        
        if numberOfForm == 1 || numberOfForm == 2 {
            if verbConjugation(verb) {                             //определяем спряжение глагола
                resultVerb = verbRoot + endings[index]
            } else {
                resultVerb = String(verbRoot)
            }
        } else {
            resultVerb = verbRoot + endings[index]                  //если нужна 4 или 5 форма глагола
        }
        
        if numberOfForm == 3 {
            resultVerb = String(verbRoot)                           //если вдруг нужна 3 (словарная форма)
        }
        
        return resultVerb
    }
}
