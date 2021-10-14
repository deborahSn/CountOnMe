//
//  Calculator.swift
//  CountOnMe
//
//  Created by Déborah Suon on 30/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol DisplayHandler {
    func updateCalcul(calculText: String)
    func showAlert(message: String)
}

class Calculator {
    var displayHandlerDelegate: DisplayHandler?
    var calculatorText: String = "" {
        didSet{
            displayHandlerDelegate?.updateCalcul(calculText: calculatorText)
        }
    }
    var elements: [String] {
        return calculatorText.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    // Method to check if the expression has enough element
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    // Method to check if is it possible to add an operator
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/" && elements.count != 0
    }
    
    var expressionHaveResult: Bool {
        return calculatorText.firstIndex(of: "=") != nil
    }

    var haveDivisionByZero: Bool = false
    
    //Method for tapped number
    func tappedNumber(numberText: String) {
        if expressionHaveResult {
            calculatorText = ""
        }
        calculatorText.append(numberText)
    }
    
    //Method for addition
    func addition(){
        if canAddOperator {
            calculatorText.append(" + ")
        } else {
            displayHandlerDelegate?.showAlert(message: "Un operateur est déjà mis !")
        }
    }
    //Method for substraction
    func substraction(){
        if canAddOperator {
            calculatorText.append(" - ")
        } else {
            displayHandlerDelegate?.showAlert(message: "Un operateur est déjà mis !")
        }
    }
    //Method for multiplication
    func multiplication() {
        if canAddOperator{
            calculatorText.append(" * ")
        } else {
            displayHandlerDelegate?.showAlert(message: "Un operateur est déjà mis !")
        }
    }
    
    //Method for division
    func division() {
        if canAddOperator{
            calculatorText.append(" / ")
        } else {
            displayHandlerDelegate?.showAlert(message: "Un operateur est déjà mis !")
        }
    }
    // Method for AC
    func resetCalcul(){
        calculatorText.removeAll()
    }
    // Method to have an alert if the expression doesn't have the good criteria
    func equal(){
        // if the expression isn't correct -> return the alert with a notification
        guard expressionIsCorrect else {
            displayHandlerDelegate?.showAlert(message: "Entrez une expression correcte !")
            return
        }
        // if the expression haven't enough elements -> return the alert with a notification
        guard expressionHaveEnoughElement else {
            displayHandlerDelegate?.showAlert(message: "Demarrez un nouveau calcul !")
            return
        }
         // Check if division by zero is in the expression
        guard !haveDivisionByZero else {
            displayHandlerDelegate?.showAlert(message: "Division par zéro impossible !")
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = priorityCalcul(expression: elements)
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            guard let left = Double(operationsToReduce[0]) else {return}
            let operand = operationsToReduce[1]
            guard let right = Double(operationsToReduce[2]) else {return}
            
            let result: Double
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: return
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        guard let result = operationsToReduce.first else{ return }
        calculatorText.append(" = \(result)")
        
     
    }
    // Method for the priority calcul with the multiplication and the division
    func priorityCalcul(expression: [String]) -> [String]{
        var tempExpression = expression
        while tempExpression.contains("*") || tempExpression.contains("/") {
            if let index = tempExpression.firstIndex(where: {$0 == "*" || $0 == "/"}) {
                let mathOperator = tempExpression[index]
                guard let left = Double(tempExpression[index-1]) else { return [] }
                guard let right = Double(tempExpression[index+1]) else { return [] }
                let result : Double
                if mathOperator == "*" {
                    result = left * right
                } else {
                    result = left / right
                    
                }
                tempExpression[index-1] = String(result)
                tempExpression.remove(at: index+1)
                tempExpression.remove(at: index)
            }
        }
        return tempExpression
       
    }
    
    // Method to check if division by zero is in the expression
    private func zeroDivision(){
        for i in 0...(elements.count-1) {
            if i > 1 && i <= elements.count-1 {
                if elements[i-1] == "/" && elements[i] == "0" {
                    //print("division impossible")
                    calculatorText = ""
                    haveDivisionByZero = true
                } else {
                    haveDivisionByZero = false
                }
            }
        }
    }
}

