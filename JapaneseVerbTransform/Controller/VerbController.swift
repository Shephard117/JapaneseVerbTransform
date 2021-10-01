//
//  ViewController.swift
//  JapaneseVerbTransform
//
//  Created by Дмитрий Скоробогаты on 28.09.2021.
//

import UIKit

class VerbController: UIViewController {

    @IBOutlet weak var kanaTextfield: UITextField!
    @IBOutlet weak var conjugationLabel: UILabel!
    
    let conjugationBrain = VerbConjugationBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func defineConjugation(_ sender: UIButton) {
    
        if conjugationBrain.detectedLanguage(for: kanaTextfield.text!) == "Japanese" {
            
            switch sender.currentTitle {
            case "Узнать спряжение":
                conjugationLabel.text = conjugationBrain.verbConjugation(kanaTextfield.text!) ? "Первое спряжение" : "Второе спряжение"
            case "ます форма":
                conjugationLabel.text = conjugationBrain.masuForm(kanaTextfield.text!)
            case "なければ　なりません　форма":
                conjugationLabel.text = conjugationBrain.nakerebaNarimasenForm(kanaTextfield.text!)
            case "て форма":
                conjugationLabel.text = conjugationBrain.teForm(kanaTextfield.text!)
            case "た форма":
                conjugationLabel.text = conjugationBrain.taForm(conjugationBrain.teForm(kanaTextfield.text!))
            default:
                conjugationLabel.text = "Что-то пошло не так"
            }
            
        } else {
            conjugationLabel.text = "Введите глагол на японском хираганой или кандзи."
        }
    }
    
    
    
}
