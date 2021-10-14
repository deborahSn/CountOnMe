//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Déborah Suon on 25/05/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    func testAdditionMethod_WhenCalculIsCorrect_ThenShouldReturnACorrectResult() {
      let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.addition()
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "1 + 1 = 2.0")
    }
    func testAdditionMethod_WhenCalculIsIncorrect_ThenShouldReturnIncorrectResult() {
      let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.addition()
        calculator.addition()
        XCTAssertEqual(calculator.calculatorText, "1 + ")
    }
    func testTappedNumberMethod_WhenCalculIsIncorrect_ThenShouldResetTheCalcul() {
      let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.addition()
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        calculator.tappedNumber(numberText: "1")
        XCTAssertEqual(calculator.calculatorText, "1")
    }
    func testSubstractionMethod_WhenCalculIsCorrect_ThenShouldReturnCorrectResult() {
      let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.substraction()
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "2 - 1 = 1.0")
    }
    func testSubstractionMethod_WhenCalculIsIncorrect_ThenShouldReturnIncorrectResult() {
      let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.substraction()
        calculator.substraction()
        XCTAssertEqual(calculator.calculatorText, "1 - ")
    }
    func testEqualMethod_WhenExpressionIsIncorrect_ThenShouldResetTheCalcul(){
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.addition()
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "1 + ")
    }
    func testEqualMethod_WhenExpressionHaveEnoughElements_ThenShouldResetTheCalcul(){
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "1")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "1")
    }
    func testMultiplicationMethod_WhenCalculIsCorrect_ThenShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.multiplication()
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "2 * 2 = 4.0")
    }
    func testMultiplicationMethod_WhenCalculIsIncorrect_ThenShouldReturnIncorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.multiplication()
        calculator.multiplication()
        XCTAssertEqual(calculator.calculatorText, "2 * ")
    }
    func testDivisionMethod_WhenCalculIsIncorrect_ThenShouldReturnIncorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.division()
        calculator.division()
        XCTAssertEqual(calculator.calculatorText, "2 / ")
    }
    func testDivisionMethod_WhenCalculIsCorrect_ThenShouldReturnCorrectResult() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "4")
        calculator.division()
        calculator.tappedNumber(numberText: "2")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "4 / 2 = 2.0")
    }
    func testDivisionByZero_WhenCalculIsCorrect_ThenShouldResetTheCalcul() {
        let calculator = Calculator()
        calculator.tappedNumber(numberText: "2")
        calculator.division()
        calculator.tappedNumber(numberText: "0")
        calculator.equal()
        XCTAssertEqual(calculator.calculatorText, "2 / 0")
    }
}
