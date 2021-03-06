//
//  ViewController.swift
//  SecurePassword
//
//  Created by TONY on 29/11/2017.
//  Copyright © 2017 TONY COMPANY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var num1Text: UITextField!
    @IBOutlet weak var num2Text: UITextField!
    @IBOutlet weak var num3Text: UITextField!
    @IBOutlet weak var resultText: UITextField!
    @IBOutlet weak var keywordText: UITextField!
    
    @IBOutlet weak var num1Label: UILabel!
    @IBOutlet weak var num2Label: UILabel!
    @IBOutlet weak var num3Label: UILabel!
    @IBOutlet weak var keyWordLabel: UILabel!
    
    @IBOutlet weak var generateButtom: UIButton!
    
    func powFast(x: UInt64, a: UInt64, n: UInt64) -> UInt64 {
        var result: UInt64 = 1
        var xFunc, aFunc: UInt64
        xFunc = x
        aFunc = a
        
        let max = UInt64(sqrt(Double(UInt64.max)))
        
        while (aFunc > 0) {
            
            if (aFunc > max || xFunc > max) {
                let alertController = UIAlertController(title: "Error", message: "Too large numbers", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(OKAction)
                self.present(alertController, animated: true)
                return 0
            }
            
            if (aFunc & 1 == 1) {
                    result = result * aFunc % n
                    aFunc -= 1
                } else {
                    xFunc = xFunc * xFunc % n
                    aFunc >>= 1
                }
        }
        return result % n
    }
    
    @IBAction func noKeyboardForResult(_ sender: UITextField) {
        
        view.endEditing(true)

    }
    
    @IBAction func generateAction(_ sender: UIButton) {
        
        view.endEditing(true)
        
        let num1, num2, num3: UInt64
        let keyword: String
        
        let text1 = num1Text.text
        let text2 = num2Text.text
        let text3 = num3Text.text

        
        if text1 == "" || text2 == "" || text3 == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Must write all 3 numbers", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            return
        }
        num1 = UInt64(text1!)!
        num2 = UInt64(text2!)!
        num3 = UInt64(text3!)!
        keyword = keywordText.text!
        
        let res = powFast(x: num1 * num2, a: num2 * num3, n: num3 * num1)
        
        var key: String = ""
        for scalar in keyword.unicodeScalars {
            var k:UInt64 = (UInt64(scalar) + res) % 26
            if UInt64(scalar) > 100 {
                k += 97
            } else {
                k += 65
            }
            
            key.unicodeScalars.append(UnicodeScalar(UInt32(k))!)
        }
        
        resultText.text = "\(key)\(res)";
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    func cleenAllTexts() {
        num1Text.text = ""
        num2Text.text = ""
        num3Text.text = ""
        keywordText.text = ""
        resultText.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([doneButton], animated: true)
        
        num1Text.inputAccessoryView = toolBar
        num2Text.inputAccessoryView = toolBar
        num3Text.inputAccessoryView = toolBar
        keywordText.inputAccessoryView = toolBar
        
        num1Label.text! += "\n(e.g. day of born)"
        num2Label.text! += "\n(e.g. month of born)"
        num3Label.text! += "\n(e.g. year of born)"
        keyWordLabel.text! += "\n(e.g. name)"
        
        num1Text.keyboardType = UIKeyboardType.numberPad
        num2Text.keyboardType = UIKeyboardType.numberPad
        num3Text.keyboardType = UIKeyboardType.numberPad
        keywordText.keyboardType = UIKeyboardType.asciiCapable
    }


}

