//
//  SmoothOperatorCLI.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/7/21.
//

import Foundation

@objc(SmoothOperatorCLI) public final class SmoothOperatorCLI: NSObject {
    
    /// This function parses a given string for operands and operators to evaulate an expression.
    ///
    /// ```
    /// print(try lib.evaluateExpression(str: "1/2 * 3_3/4")) // 1_7/8
    /// ```
    ///
    /// - Warning: Only supports operand, operate, operand - infix operation
    /// - Parameter expression: The string expression to be evaulated
    /// - Parameter precisionRoundingPlaces: Number of decimal places of precision. Defaults to 12
    /// - Returns: String
    public func evaluateExpression(expression: String, precisionRoundingPlaces: Int = 12) throws -> String {
        let fractionExpression = FractionExpression(expr: expression)
        let fractionExpressionEvaluator = FractionExpressionEvaluator(precisionRoundingPlaces: precisionRoundingPlaces)
        
        guard let doubleValue = try fractionExpressionEvaluator.evaluateExpression(expr: fractionExpression) else {
            throw ExpressionError.invalidExpression("Unable to determine value of \(expression)")
        }
        
        return fractionExpressionEvaluator.doubleToFraction(value: doubleValue)
    }
}
