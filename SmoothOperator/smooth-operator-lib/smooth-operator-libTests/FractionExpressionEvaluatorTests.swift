//
//  FractionExpressionEvaluatorTests.swift
//  smooth-operator-libTests
//
//  Created by Justin Trantham on 10/7/21.
//

import XCTest
@testable import smooth_operator_lib

class FractionExpressionEvaluatorTests: XCTestCase {
    let fractionExpressionEvaluator = FractionExpressionEvaluator()
    
    func testEvaluateExpressionWithValidValues() throws {
        for expression in TestHelper.sampleTestExpressionsWithDoubleValues {
            let testExpression = FractionExpression(expr: expression.key)
            let result = try! fractionExpressionEvaluator.evaluateExpression(expr: testExpression)
            
            // Assert
            XCTAssertTrue(result ?? 0.0 == expression.value, "{ \(expression.key) } - with expected output: { \(expression.value) }")
        }
    }
    
    func testEvaluateExpressionWithInvalidValues() throws {
        let testExpression = FractionExpression(expr: "1 * 4_")

        XCTAssertThrowsError(try fractionExpressionEvaluator.evaluateExpression(expr: testExpression)) { error in
            guard case ExpressionError.invalidOperand(_) = error else {
                return XCTFail()
            }
            
            assert(error.localizedDescription == "Invalid operand supplied. Operands should be in the format of { whole_number (1) , fraction (1/4) , mixed_fraction (1_3/4) }. At least two operands required. Only [1.0] supplied")
        }
        
        for expression in TestHelper.sampleTestExpressionsWithDoubleValues {
            let testExpression = FractionExpression(expr: expression.key)
            let result = try! fractionExpressionEvaluator.evaluateExpression(expr: testExpression)
            
            // Assert
            XCTAssertTrue(result ?? 0.0 == expression.value, "{ \(expression.key) } - with expected output: { \(expression.value) }")
        }
    }
    
    func testParseInputWithValidExpression() throws {
        // Setup
        let testExpression = FractionExpression(expr: "2 * 4_1/2")
        
        // Execute
        let result = try! fractionExpressionEvaluator.parseInput(expr: testExpression)
        
        // Verify
        XCTAssertTrue(result.operands.contains(where: {$0 == 2.0}) && result.operands.contains(where: {$0 == 4.5}))
        XCTAssertTrue(result.operators.contains(where: {$0 == .multiply}))
    }
    
    func testDoubleToFractionWithValidExpression() throws {
        for expression in TestHelper.sampleTestExpressionsWithStringValuesAndDoubleKeys {
            let result = fractionExpressionEvaluator.doubleToFraction(value: expression.key)
            
            // Assert
            XCTAssertTrue(result == expression.value, "{ \(expression.key) } - with expected output: { \(expression.value) }")
        }
    }
    
    func testPerformMathOperationWithDivideByZero() throws {
        // Setup
        
        // Execute
        
        // Verify
        XCTAssertThrowsError(try fractionExpressionEvaluator.performMathOperation(l: 0.5, r: 0.0, op: .divide)) { error in
            guard case ExpressionError.divideByZero = error else {
                return XCTFail()
            }
        }
    }
    
    func testPerformMathOperationWithMultiply() throws {
        // Setup
        
        // Execute
        let result = try! fractionExpressionEvaluator.performMathOperation(l: 0.5, r: 2, op: .multiply)
        
        // Verify
        XCTAssertTrue(result == 1, "0.5 * 2 should be 1")
    }

}
