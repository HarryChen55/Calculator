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
    
    var display1Value: Double? {get {return Double(display1.text!)}}
    
    var userIsTyping = false
    var display1IsInUse = false
    
    let brain = CalculatorBrain()
    
    
    @IBAction func digitButton(sender: UIButton) {
        if display1IsInUse == false {
            ifLoop: if userIsTyping {
                if display1.text! == "0" && sender.currentTitle! == "0" {
                    break ifLoop
                } else if display1.text! == "-0" && sender.currentTitle! == "0" {
                    break ifLoop
                } else if display1.text! == "-0" && sender.currentTitle! == "." {
                    display1.text = "-0."
                } else if display1.text! == "-0" && sender.currentTitle! != "0" {
                    display1.text = "-" + sender.currentTitle!
                } else if (display1.text?.containsString("."))! && sender.currentTitle! == "." {
                    break ifLoop
                } else {
                    display1.text = display1.text! + sender.currentTitle!
                }
            } else {
                if sender.currentTitle! == "." {
                    display1.text = "0."
                } else {
                    display1.text = sender.currentTitle!
                }
                userIsTyping = true
            }
        } else {
            enter()
            if sender.currentTitle! == "." {
                display1.text = "0."
            } else {
                display1.text = sender.currentTitle!
            }
            display1IsInUse = false
            userIsTyping = true
        }
    }
    
    
    @IBAction func minusAndPlus() {
        if display1IsInUse == false {
            if (display1.text?.containsString("-"))! {
                display1.text?.removeAtIndex((display1.text?.startIndex)!)
            } else {
                display1.text = "-" + display1.text!
                userIsTyping = true
            }
        } else {
            enter()
            display1.text = "-0"
            display1IsInUse = false
            userIsTyping = true
        }
    }
    
    
    @IBAction func delButton() {
        if display1IsInUse == false && display1.text?.isEmpty != true {
            display1.text?.removeAtIndex((display1.text?.endIndex.predecessor())!)
            if display1.text?.isEmpty == true {
                display1.text = "0"
                userIsTyping = false
            }
        }
    }
    
    
    @IBAction func operators(sender: UIButton) {
        if sender.currentTitle! == "√" {
            if display1Value != nil && display1Value! >= 0 {
                
            } else {
                display2.text = "Can not perform √"
            }
        } else if sender.currentTitle! == "Binary" {
            
        } else if userIsTyping {
            userIsTyping = false
            enter()
            (display1.text!, display1IsInUse) = brain.operations(sender.currentTitle!)
        }
    }
    
    
    func enter() {
        if display1IsInUse == false {
            if display1Value != nil {
                brain.addNewNumberToStack(display1Value!)
            } else {
                display2.text = "display1Value is nil"
            }
        }
        display3.text = display2.text!
        display2.text = display1.text!
        display1.text = "0"
    }
    
    
    @IBAction func allClear() {
        brain.allClear()
        display1.text = "0"
        display2.text = ""
        display3.text = ""
        userIsTyping = false
        display1IsInUse = false
    }
    
}