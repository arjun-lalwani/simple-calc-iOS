//
//  ViewController.swift
//  simple-calc
//
//  Created by Arjun Lalwani on 23/10/16.
//  Copyright © 2016 Arjun Lalwani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var subtract: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var count: UIButton!
    @IBOutlet weak var avg: UIButton!
    @IBOutlet weak var fact: UIButton!
    
    var operations: [String] = ["+", "-", "x","/","=","Count","Average"]
    var firstNumber : String = ""
    var currentOperation: String = ""
    var currentNumber : String = ""
    var factorial : Double = 0.0
    var total: Double = 0.0
    var countNumbers : Int  = 0
    var fistNumberPressed : Bool = false
    var countOperation : Bool = false
    var avgOperation: Bool = false

    
    // all numbers from 0 to 9 are connected and user gets
    // to pick a number of any size, which is then stored
    @IBAction func showNumber(_ sender: AnyObject) {
        let numberPressed = sender.titleLabel!!.text
        currentNumber += numberPressed!
        textField.text = currentNumber
    }

    
    // clears and resets the entire app to defaults stage
    @IBAction func clearAll(_ sender: AnyObject) {
        reset()
        textField.text = String(total)
    }
    
    // calculates factorial of number when button is pressed
    @IBAction func calcFact(_ sender: AnyObject) {
        
        if (countNumbers != 0) {
            textField.text = "Error, Press Clear to Reset"
        } else {
            var totalFact : Double = 1.0
            var currentNum : Double = Double(currentNumber)!
            while(currentNum != 1.0) {
                totalFact *= currentNum
                currentNum = currentNum - 1
            }
            factorial = totalFact
            textField.text = String(factorial)
            reset()
        }
    }
    
    // records the action entered by user and does appropriate calculations requested
    // by user
    @IBAction func recordOperation(_ sender: AnyObject) {
        
        // changing total of first time to the first number entered
        if (!fistNumberPressed) {
            countNumbers = 1
            fistNumberPressed = true
            if (currentNumber == "") {
                textField.text = "Error! Press Clear to Reset"
            }
            total = Double(currentNumber)!
        }
        
        // checks which was the last operation and uses that to perform a function with 
        // the new number
        switch currentOperation {
            
            case "+" : total += Double(currentNumber)!;
                
            case "-" : total -= Double(currentNumber)!
                
            case "x" : total *= Double(currentNumber)!
                
            case "/" : total /= Double(currentNumber)!
                
            case "Count": countNumbers = countNumbers + 1; countOperation = true
                
            case "Average": countNumbers = countNumbers + 1;
            total += Double(currentNumber)!
            avgOperation = true
                
            default : textField.text = "Enter a valid command"; break
        }
        
        // stores operation pressed by user and displays on screen
        let operationPressed = sender.titleLabel!!.text
        for operation in operations {
            if operationPressed == operation {
                currentOperation = operationPressed!
                if (currentOperation != "=") {
                    textField.text = currentOperation
                }
            }
        }

        // resets current Number to empty string, allowing variable to record new number 
        // entered by user
        currentNumber = ""
        
        // displays result and resets everything to default value
        if (currentOperation == "=") {
            if (countOperation) {
                textField.text = String(countNumbers)
            } else if (avgOperation) {
                textField.text = String(total / Double(countNumbers))
            } else {
                textField.text = String(total)
            }
            reset()
        }
    }
    
    // default settings
    func reset() {
        countOperation = false
        avgOperation = false
        fistNumberPressed = false
        firstNumber = ""
        currentOperation = ""
        currentNumber = ""
        total = 0.0
        factorial = 0.0
        countNumbers = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
