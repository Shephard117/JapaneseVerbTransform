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
        
        conjugationLabel.text = verbConjugation(kanaTextfield.text!)
        
    }
    
    func verbConjugation(_ verb: String) -> String {
        
        guard let romajiVerb = verb.applyingTransform(.toLatin, reverse: false) else { return "Убедитесь в правильности написания."}
  
        if verb2conjugationExeptionKana.contains(verb) || verb2conjugationExeptionKanji.contains(verb) {
            return "Первое спряжение"
        } else if verb == "寝る" {
            return "Второе спряжение"
        }
        if romajiVerb.hasSuffix("iru") || romajiVerb.hasSuffix("eru") {
            return "Второе спряжение"
        } else {
            return "Первое спряжение"
        }
    }
}

