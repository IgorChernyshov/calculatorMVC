//
//  ViewController.swift
//  demoCalculatorMVC
//
//  Created by Igor Chernyshov on 01/11/2018.
//  Copyright © 2018 Igor Chernyshov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var isUserInMiddleOfTyping: Bool = false

  @IBOutlet weak var displayLabel: UILabel!
  
  @IBAction func digitWasPressed(_ sender: UIButton) {
    guard let buttonValue = sender.currentTitle else { return }
    if isUserInMiddleOfTyping {
      let textOnDisplay = displayLabel.text!
      displayLabel.text = textOnDisplay + buttonValue
    } else {
      displayLabel.text = buttonValue
      isUserInMiddleOfTyping = true
    }
  }
  
  @IBAction func performOperation(_ sender: UIButton) {
    guard let operation = sender.currentTitle else { return }
    isUserInMiddleOfTyping = false
    switch operation {
    case "π":
      displayLabel.text = String(Double.pi)
    default:
      break
    }
  }
  
}

