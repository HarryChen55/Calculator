//
//  ViewController.swift
//  Calculator
//
//  Created by Harry on 15/12/7.
//  Copyright © 2015 Harry Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display1: UILabel!
    @IBOutlet weak var display2: UILabel!
    @IBOutlet weak var display3: UILabel!
    
    var userIsTyping = false
    var operatorPressed = "none"
    var inputStack = [Double]()
    
    @IBAction func AllClear(sender: UIButton) {
        userIsTyping = false
        operatorPressed = "none"
        inputStack.removeAll()
        display1.text = ""
        display2.text = ""
        display3.text = "0"
    }
    
    
    @IBAction func DigitButton(sender: UIButton) {
        if (display1.text?.isEmpty)! != true {
            display1.text = ""
        }
        if userIsTyping {
            if display3.text == "0" && sender.currentTitle! == "0" {
                display3.text = sender.currentTitle!
                userIsTyping = false
            } else {
                display3.text = display3.text! + sender.currentTitle!
            }
        } else {
            if sender.currentTitle == "." {
                display3.text = "0" + sender.currentTitle!
                userIsTyping = true
            } else {
                display3.text = sender.currentTitle
                userIsTyping = true
            }
        }
    }
    
    
    @IBAction func Operate(sender: UIButton) {
        if operatorPressed == "none" {
            switch sender.currentTitle! {
            case "+":
                operatorPressed = "+"
                inputStack.append(Double(display3.text!)!)
                display2.text = display3.text! + " +"
                display3.text = "0"
                userIsTyping = false
            case "−":
                operatorPressed = "−"
                inputStack.append(Double(display3.text!)!)
                display2.text = display3.text! + " −"
                display3.text = "0"
                userIsTyping = false
            case "×":
                operatorPressed = "×"
                inputStack.append(Double(display3.text!)!)
                display2.text = display3.text! + " ×"
                display3.text = "0"
                userIsTyping = false
            case "÷":
                operatorPressed = "÷"
                inputStack.append(Double(display3.text!)!)
                display2.text = display3.text! + " ÷"
                display3.text = "0"
                userIsTyping = false
            case "=":
                break
            default:
                break
            }
        } else {
            switch operatorPressed {
            case "+":
                inputStack.append(Double(display3.text!)!)
                display2.text = "\(inputStack[0])" + " + " + "\(inputStack[1])"
                display3.text = "\(inputStack[0] + inputStack[1])"
                inputStack.append((inputStack[0] + inputStack[1]))
                inputStack.removeFirst()
                inputStack.removeFirst()
                operatorPressed = sender.currentTitle!
                userIsTyping = false
            case "−":
                inputStack.append(Double(display3.text!)!)
                display2.text = "\(inputStack[0])" + " − " + "\(inputStack[1])"
                display3.text = "\(inputStack[0] - inputStack[1])"
                inputStack.append((inputStack[0] - inputStack[1]))
                inputStack.removeFirst()
                inputStack.removeFirst()
                operatorPressed = sender.currentTitle!
                userIsTyping = false
            case "×":
                inputStack.append(Double(display3.text!)!)
                display2.text = "\(inputStack[0])" + " × " + "\(inputStack[1])"
                display3.text = "\(inputStack[0] * inputStack[1])"
                inputStack.append((inputStack[0] * inputStack[1]))
                inputStack.removeFirst()
                inputStack.removeFirst()
                operatorPressed = sender.currentTitle!
                userIsTyping = false
            case "÷":
                inputStack.append(Double(display3.text!)!)
                display2.text = "\(inputStack[0])" + " ÷ " + "\(inputStack[1])"
                display3.text = "\(inputStack[0] / inputStack[1])"
                inputStack.append((inputStack[0] / inputStack[1]))
                inputStack.removeFirst()
                inputStack.removeFirst()
                operatorPressed = sender.currentTitle!
                userIsTyping = false
            case "=":
                switch operatorPressed {
                case "+":
                    inputStack.append(Double(display3.text!)!)
                    display2.text = "\(inputStack[0])" + " + " + "\(inputStack[1])"
                    display3.text = "\(inputStack[0] + inputStack[1])"
                    inputStack.append((inputStack[0] + inputStack[1]))
                    inputStack.removeAll()
                    operatorPressed = "none"
                    userIsTyping = false
                case "−":
                    inputStack.append(Double(display3.text!)!)
                    display2.text = "\(inputStack[0])" + " − " + "\(inputStack[1])"
                    display3.text = "\(inputStack[0] - inputStack[1])"
                    inputStack.append((inputStack[0] - inputStack[1]))
                    inputStack.removeAll()
                    operatorPressed = "none"
                    userIsTyping = false
                case "×":
                    inputStack.append(Double(display3.text!)!)
                    display2.text = "\(inputStack[0])" + " × " + "\(inputStack[1])"
                    display3.text = "\(inputStack[0] * inputStack[1])"
                    inputStack.append((inputStack[0] * inputStack[1]))
                    inputStack.removeAll()
                    operatorPressed = "none"
                    userIsTyping = false
                case "÷":
                    inputStack.append(Double(display3.text!)!)
                    display2.text = "\(inputStack[0])" + " ÷ " + "\(inputStack[1])"
                    display3.text = "\(inputStack[0] / inputStack[1])"
                    inputStack.append((inputStack[0] / inputStack[1]))
                    inputStack.removeAll()
                    operatorPressed = "none"
                    userIsTyping = false
                default:
                    break
                }
//            case "mod":
//                modOperate()
            default:
                break
            }
        }
    }
    
    
    @IBAction func modOperate() {
        ifLoop: if operatorPressed == "mod" {
            if display3.text == "0." || Double(display3.text!)! == 0 {
                display1.text = "Invalid input"
                display3.text = "0"
                userIsTyping = false
                break ifLoop
            } else {
                let modResult: Double
                display1.text = ""
                inputStack.append(Double(display3.text!)!)
                modResult = inputStack[0] % inputStack[1]
                display2.text = display2.text! + " " + display3.text!
                display3.text = "\(Int(modResult))"
                inputStack.removeAll()
                userIsTyping = false
                operatorPressed = "none"
            }
        } else {
            inputStack.append(Double(display3.text!)!)
            display2.text = display3.text! + " MOD"
            display3.text = "0"
            userIsTyping = false
            operatorPressed = "mod"
        }
    }
    
    
    @IBAction func ToBinary() {
        var convertedInt = ""
        var convertedDec = ""
        
        let intToBeCount = String(Int(Double(display3.text!)!))
        
        ifLoop1: if intToBeCount == "0" {
            convertedInt = "0"
            break ifLoop1
        } else {
            var numberToBeConvertedInt = Int(Double(display3.text!)!)
            repeat {
                convertedInt = "\(numberToBeConvertedInt % 2)" + convertedInt
                numberToBeConvertedInt = Int(numberToBeConvertedInt / 2)
            } while numberToBeConvertedInt >= 1
        }
        
        ifLoop2: if intToBeCount.characters.count == display3.text?.characters.count {
            break ifLoop2
        } else {
            var numberToBeConvertedDec = display3.text!
            if numberToBeConvertedDec == "0." {
                break ifLoop2
            }
            for (var i = 1; i <= (intToBeCount.characters.count + 1); ++i) {
                numberToBeConvertedDec.removeAtIndex(numberToBeConvertedDec.startIndex)
            }
            let originalCount = numberToBeConvertedDec.characters.count
            var numberOfDec = 0
            whileLoop: repeat {
                numberToBeConvertedDec = "\(Int(numberToBeConvertedDec)! * 2)"
                if numberToBeConvertedDec.characters.count > originalCount {
                    convertedDec = convertedDec + String(numberToBeConvertedDec.removeAtIndex(numberToBeConvertedDec.startIndex))
                } else {
                    convertedDec = convertedDec + "0"
                }
                ++numberOfDec
                if numberOfDec == 15 {
                    convertedDec = convertedDec + "..."
                    break whileLoop
                }
            } while Int(numberToBeConvertedDec) != 0
            convertedDec = "." + convertedDec
        }
        
        display2.text = display3.text! + " to Binary"
        display3.text = convertedInt + convertedDec
        inputStack.removeAll()
        userIsTyping = false
        operatorPressed = "none"
    }
    
    
}

