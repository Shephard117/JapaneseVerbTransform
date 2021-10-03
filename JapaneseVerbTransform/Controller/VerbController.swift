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
    
    let transformBrain = VerbTransformBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func defineConjugation(_ sender: UIButton) {
       
       updateUI(sender, conjugationLabel, kanaTextfield)
    }
    
    func updateUI(_ button: UIButton, _ label: UILabel, _ textField: UITextField){
        
        if transformBrain.detectedLanguage(for: textField.text!) == "Japanese" {
            
            switch button.tag {
            case 0:
                label.text = transformBrain.verbConjugation(textField.text!) ? "Первое спряжение" : "Второе спряжение"
            case 1:
                label.text = transformBrain.masuForm(textField.text!)
            case 2:
                label.text = transformBrain.nakerebaNarimasenForm(textField.text!)
            case 3:
                label.text = transformBrain.teForm(textField.text!)
            case 4:
                label.text = transformBrain.taForm(textField.text!)
            case 5:
                label.text = transformBrain.negativeForm(textField.text!)
            case 6:
                label.text = transformBrain.potencialForm(textField.text!)
            default:
                label.text = "Что-то пошло не так"
            }
            
        } else {
            label.text = "Введите глагол на японском хираганой или кандзи."
        }
    }
    
}
