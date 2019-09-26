//
//  ViewController.swift
//  Calculator2
//
//  Created by Rebecca Urquhart on 26/09/2019.
//  Copyright © 2019 Rebecca Urquhart. All rights reserved.
//

import UIKit

enum modes {
    case notSet
    case addition
    case subtraction
    case multiplication
    case division
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    var labelString: String = "0"
    var currentMode: modes = .notSet
    var savedNum: Int = 0
    var lastButtonWasMode: Bool = false

    func updateText() {
        //converting labelString to an int
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error!"
            return
        }
        //stores the number(s) entered before the user presses an operator button
        if currentMode == .notSet {
            savedNum = labelInt
        }
        
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let num = NSNumber(value: labelInt)
        
        
        //setting the text inside the label textfield
        label.text = formatter.string(from: num)
    }
    
    func changeModes(newMode: modes) {
        if savedNum == 0 {
            return
        }
        //if user has entered numbers before pressing operator buttons currentMode will be set to newMode
        currentMode = newMode
        lastButtonWasMode = true
    }

    @IBAction func didPressPlus(_ sender: Any) {
        changeModes(newMode: .addition)
    }
    
    @IBAction func didPressMinus(_ sender: Any) {
        changeModes(newMode: .subtraction)
    }
    
    @IBAction func didPressMultiply(_ sender: Any) {
        changeModes(newMode: .multiplication)
    }
    
    @IBAction func didPressDivide(_ sender: Any) {
        changeModes(newMode: .division)
    }
    
    @IBAction func didPressEquals(_ sender: Any) {
        guard let labelInt: Int = Int(labelString) else {
            label.text = "Error!"
            return
        }
        //checks whether the mode is not set or the last button pressed was a mode button
        if currentMode == .notSet || lastButtonWasMode {
            return
        }
        
        if currentMode == .addition {
            savedNum += labelInt
        } else if currentMode == .subtraction {
            savedNum -= labelInt
        } else if currentMode == .multiplication {
            savedNum *= labelInt
        } else if currentMode == .division {
            savedNum /= labelInt
        }
        
        currentMode = .notSet
        labelString = "\(savedNum)"
        updateText()
        lastButtonWasMode = true
    }
    
    @IBAction func didPressClear(_ sender: Any) {
        labelString = "0"
        currentMode = .notSet
        savedNum = 0
        lastButtonWasMode = false
        label.text = "0"
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        //Making sure the button contains a value(text)
        //If there is text present, the stringValue will have a value
        guard let stringValue: String = sender.titleLabel?.text else {
            label.text = "Error!"
            return
        }
        
        //resetting the labelstring if the last button pressed before entering more numbers was mode
        if lastButtonWasMode {
            lastButtonWasMode = false
            labelString = "0"
        }
        
        //appending method allows us to append a string on to another string
        labelString = labelString.appending(stringValue)
        //calling on the updateText method to avoid appending 0's to the start of our text
        updateText()
    }
    
}

