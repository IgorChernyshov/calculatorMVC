//
//  CalculatorBrain.swift
//  calculatorMVC
//
//  Created by Igor Chernyshov on 05/11/2018.
//  Copyright © 2018 Igor Chernyshov. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
  return -operand
}

func multiply(op1: Double, op2: Double) -> Double {
  return op1 * op2
}

func divide(op1: Double, op2: Double) -> Double {
  guard op2 != 0.0 else { return 0.0 }
  return op1 / op2
}

func sum(op1: Double, op2: Double) -> Double {
  return op1 + op2
}

func substract(op1: Double, op2: Double) -> Double {
  return op1 - op2
}


struct CalculatorBrain {
  
  private enum Operation {
    case constant(Double)
    case unaryOperation((Double) -> Double)
    case binaryOperation((Double, Double) -> Double)
    case equals
  }
  
  private var accumulator: Double?
  
  private var operations: Dictionary<String, Operation> =
  [
    "π" : Operation.constant(Double.pi),
    "e" : Operation.constant(M_E),
    "C" : Operation.constant(0),
    "√" : Operation.unaryOperation(sqrt),
    "cos" : Operation.unaryOperation(cos),
    "±" : Operation.unaryOperation(changeSign),
    "×" : Operation.binaryOperation(multiply),
    "÷" : Operation.binaryOperation(divide),
    "+" : Operation.binaryOperation(sum),
    "-" : Operation.binaryOperation(substract),
    "=" : Operation.equals
  ]
  
  mutating func performOperation(_ symbol: String) {
    if let operation = operations[symbol] {
      switch operation {
      case .constant(let value):
        accumulator = value
      case .unaryOperation(let function):
        if accumulator != nil {
          accumulator = function(accumulator!)
        }
      case .binaryOperation(let function):
        if accumulator != nil {
          pbo = pendingBinaryOperation(function: function, firstOperand: accumulator!)
          accumulator = nil
        }
      case .equals:
        performPendingBinaryOperation()
      }
    }
  }
  
  private mutating func performPendingBinaryOperation() {
    if pbo != nil && accumulator != nil {
      accumulator = pbo!.perform(with: accumulator!)
      pbo = nil
    }
  }
  
  private var pbo: pendingBinaryOperation?
  
  private struct pendingBinaryOperation {
    let function: (Double, Double) -> Double
    let firstOperand: Double
    
    func perform(with secondOperand: Double) -> Double {
      return function(firstOperand, secondOperand)
    }
  }
  
  mutating func setOperand(_ operand: Double) {
    accumulator = operand
  }
  
  var result: Double? {
    get {
      return accumulator
    }
  }
}
