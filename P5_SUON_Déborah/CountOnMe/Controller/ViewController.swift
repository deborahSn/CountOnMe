//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    // NEWW: Instance of Calculator 
    var myCalculation = Calculator()
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        myCalculation.displayHandlerDelegate = self
    }
    
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        myCalculation.tappedNumber(numberText: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        myCalculation.addition()
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        myCalculation.substraction()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        myCalculation.equal()
    }

    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        myCalculation.multiplication()
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        myCalculation.division()
    }
    @IBAction func acButtonTapped(_ sender: Any) {
        myCalculation.resetCalcul()
    }
}

extension ViewController: DisplayHandler {
    func updateCalcul(calculText: String) {
        textView.text = calculText
    }
    // Method to show an alert 
    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
}
