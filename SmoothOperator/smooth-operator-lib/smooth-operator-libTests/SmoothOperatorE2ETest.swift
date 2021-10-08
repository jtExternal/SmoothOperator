//
//  SmoothOperatorE2ETest.swift
//  smooth-operator-libTests
//
//  Created by Justin Trantham on 10/7/21.
//

import XCTest
@testable import smooth_operator_lib

class SmoothOperatorE2ETest: XCTestCase {
    let smoothOperatorCLILib = SmoothOperatorCLI()
    
    func testEvaluateExpressionWithValidValues() throws {
        
        for expression in TestHelper.sampleTestExpressionsWithStringValues {
            // Setup
            
            // Execute
            let result = try! smoothOperatorCLILib.evaluateExpression(expression: expression.key)
            
            // Assert
            XCTAssertTrue(result == expression.value, "{ \(expression.key) } - with expected output: { \(expression.value) }")
        }
    }
    
    func testEvaluateExpressionWithInvalidExpression_invalidOperand() {
        XCTAssertThrowsError(try smoothOperatorCLILib.evaluateExpression(expression: "* 2")) { error in
            guard case ExpressionError.invalidOperand(_) = error else {
                return XCTFail()
            }
            
            XCTAssertTrue(error.localizedDescription.contains("At least two operands required."), "Two operands should be required")
        }
    }
    
    func testEvaluateExpressionWithInvalidExpression_invalidMissingOperator() {
        XCTAssertThrowsError(try smoothOperatorCLILib.evaluateExpression(expression: "2")) { error in
            guard case ExpressionError.invalidOperator(_) = error else {
                return XCTFail()
            }
            
            XCTAssertTrue(error.localizedDescription.contains("At least one operator required"))
        }
    }
    
    func testEvaluateExpressionWithInvalidExpression_invalidMissingOperatorNonLegalOperator() {
        XCTAssertThrowsError(try smoothOperatorCLILib.evaluateExpression(expression: "2_1/3 ^ 2")) { error in
            guard case ExpressionError.invalidOperator(_) = error else {
                return XCTFail()
            }
            
            XCTAssertTrue(error.localizedDescription.contains("At least one operator required"))
        }
    }
    
    func testEvaluateExpressionWithInvalidExpression_invalidMissingExpression() {
        XCTAssertThrowsError(try smoothOperatorCLILib.evaluateExpression(expression: "")) { error in
            guard case ExpressionError.invalidOperator(_) = error else {
                return XCTFail()
            }
            
            XCTAssertTrue(error.localizedDescription.contains("At least one operator required"))
        }
    }
    
    func testEvaluateExpressionWithInvalidExpression_invalidMixedFractionDivideByZero() {
        XCTAssertThrowsError(try smoothOperatorCLILib.evaluateExpression(expression: "1_3/4 * 1_4/0")) { error in
            guard case ExpressionError.invalidExpression(_) = error else {
                return XCTFail()
            }
            
            XCTAssertTrue(error.localizedDescription.contains("Invalid mixed fraction while parsing 1_4/0"))
        }
    }
}
