//
//  ViewController.swift
//  retro-calcultor
//
//  Created by Kishore Rao on 3/3/16.
//  Copyright © 2016 informed-planet.com. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    enum Operation: String {
       case Divide = "/"
       case Multiply = "*"
       case Subtract = "-"
       case Add = "+"
   
       case Empty = "Empty"
    
    }
    
    var currentOperation: Operation = Operation.Empty
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
    let soundURL = NSURL(fileURLWithPath: path!)
    
        
        do {
        
    try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
          print (err.debugDescription)
            
        }
        
    }
    
        
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
        
    }
    
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
        
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        playSound()
        runningNumber=""
        leftValStr=""
        rightValStr=""
        outputLbl.text = "0"
        result = ""
        currentOperation = Operation.Empty
        
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run math operations
            
            if runningNumber != "" {
                
            //Handle condition where user selected one operator and another operator consecutively
                
            rightValStr = runningNumber
            runningNumber = ""
            
              if currentOperation == Operation.Multiply {
                  result = "\(Double(leftValStr)!  * Double(rightValStr)!)"
                
              } else
              
              if currentOperation == Operation.Divide {
                  result = "\(Double(leftValStr)! / Double(rightValStr)!)"
              } else
            
              if currentOperation == Operation.Subtract {
                 result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                
              } else
            
              if currentOperation == Operation.Add {
                 result = "\(Double(leftValStr)! + Double(rightValStr)!)"
              }
       
          }
            
            leftValStr = result
            outputLbl.text = result
            
            currentOperation = op
            
            
            
            
            
        
        } else {
            //This is the first time operator is pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
            
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
            
        }
        btnSound.play()
        
    }
}

