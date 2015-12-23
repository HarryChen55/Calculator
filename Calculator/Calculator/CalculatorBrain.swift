//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Harry on 15/12/13.
//  Copyright © 2015 Harry Chen. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var operandStack = [Double]()
    private var operatorsPressedBefore = ""
    
    private enum InputStack {
        case operand(Array<Double>)
        case binaryOperation((Double, Double) -> Double)
        case unaryOperation((Double) -> Double)
    }

    
    func operations(operatorPressed: String) -> (result: String, displayOccupied: Bool) {
        var result = "0"
        var displayOccupied = false
        ifloop: if operatorsPressedBefore.isEmpty != true {
            switch operatorsPressedBefore {
            case "+":
                result = performOperation({$0 + $1})
            case "−":
                result = performOperation({$0 - $1})
            case "×":
                result = performOperation({$0 * $1})
            case "÷":
                result = performOperation({$0 / $1})
            case "MOD":
                result = performOperation({$0 % $1})
            case "√":
                result = performOperation({sqrt($0)})
            case "Binary":
                result = convertToBinary(operandStack.last!)
            case "=":
                result = ""
            default:
                break ifloop
            }
            displayOccupied = true
            operatorsPressedBefore = operatorPressed
        } else {
            switch operatorPressed {
            case "√":
                result = performOperation({sqrt($0)})
                displayOccupied = true
            case "Binary":
                result = convertToBinary(operandStack.last!)
                displayOccupied = true
            default:
                operatorsPressedBefore = operatorPressed
            }
        }
        return (result, displayOccupied)
    }
    
    
    private func performOperation(operation: (Double, Double) -> Double) -> String {
        let result = operation(operandStack.removeFirst(), operandStack.removeFirst())
        operandStack.append(result)
        return "\(result)"
    }
    
    
    private func performOperation(operation: (Double) -> Double) -> String {
        let result = operation(operandStack.removeFirst())
        operandStack.append(result)
        return "\(result)"
    }

    
    private func convertToBinary(numberToBeConverted: Double) -> String {
        
        return ""
    }
    
    
    func addNewNumberToStack(newNumber: Double) {
        operandStack.append(newNumber)
    }
    
    
    func allClear() {
        operandStack.removeAll()
        operatorsPressedBefore = ""
    }
    
    
}