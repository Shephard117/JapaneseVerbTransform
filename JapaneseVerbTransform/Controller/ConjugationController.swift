//
//  ViewController.swift
//  JapaneseVerbTransform
//
//  Created by Дмитрий Скоробогаты on 28.09.2021.
//

import UIKit

class ConjugationController: UIViewController {

    @IBOutlet weak var kanaTextfield: UITextField!
    @IBOutlet weak var conjugationLabel: UILabel!
    
    let conjugationBrain = VerbConjugationBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func defineConjugation(_ sender: UIButton) {
        
        if conjugationBrain.detectedLanguage(for: kanaTextfield.text!) == "Japanese" {
            if sender.currentTitle == "Узнать спряжение" {
                conjugationLabel.text = conjugationBrain.verbConjugation(kanaTextfield.text!) ? "Первое спряжение" : "Второе спряжение"
            } else if sender.currentTitle == "ます форма" {
                conjugationLabel.text = conjugationBrain.masuForm(kanaTextfield.text!)
            } else if sender.currentTitle == "なければ　なりません　форма" {
                
            }
        } else {
            conjugationLabel.text = "Введите глагол на японском хираганой или кандзи."
        }
    }
    
    
    
}
