//
//  CalculatorViewController.swift
//  demoCalculatorMVC
//
//  Created by Igor Chernyshov on 01/11/2018.
//  Copyright © 2018 Igor Chernyshov. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
  
  var isUserInMiddleOfTyping: Bool = false

  @IBOutlet weak var displayLabel: UILabel!
  
  @IBAction func digitWasPressed(_ sender: UIButton) {
    guard let buttonValue = sender.currentTitle else { return }
    if (displayLabel.text == "0") && (buttonValue == "0") {
      return
    }
    if isUserInMiddleOfTyping {
      if displayLabel.text == "0" {
        displayLabel.text = ""
      }
      let textOnDisplay = displayLabel.text!
      displayLabel.text = textOnDisplay + buttonValue
    } else {
      displayLabel.text = buttonValue
      isUserInMiddleOfTyping = true
    }
  }
  
  var displayValue: Double {
    get {
      return Double(displayLabel.text!)!
    }
    set {
      let resultIsInteger = floor(newValue) == newValue
      if resultIsInteger {
        displayLabel.text = String(Int(newValue))
      } else {
        displayLabel.text = String(newValue)
      }
    }
  }
  
  private var brain = CalculatorBrain()
  
  @IBAction func performOperation(_ sender: UIButton) {
    if isUserInMiddleOfTyping {
      brain.setOperand(displayValue)
      isUserInMiddleOfTyping = false
    }
    if let buttonValue = sender.currentTitle {
      brain.performOperation(buttonValue)
    }
    if let result = brain.result {
      displayValue = result
    }
  }
  
}

