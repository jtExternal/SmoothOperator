//
//  FractionExpressionEvaluator.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/7/21.
//

import Foundation

internal class FractionExpressionEvaluator {
    private var precisionRoundingPlaces: Int
    
    init(precisionRoundingPlaces: Int = 12) {
        self.precisionRoundingPlaces = 12
    }
    
    /// This function will attempt to parse a user's expression and perform the
    /// arithmitic operation and return result back in Double precision
    ///
    /// - Parameter expr: Expression string
    /// - Returns: Double
    ///
    func evaluateExpression(expr: FractionExpression) throws -> Double? {
        let parsedInput = try parseInput(expr: expr)
        
        if let firstOperand = parsedInput.operands.first, let secondOperand = parsedInput.operands.last, let op = parsedInput.operators.first {
            return try performMathOperation(l: firstOperand, r: secondOperand, op: op)
        }
        
        throw ExpressionError.invalidExpression("Invalid number of arguments found within expression \(expr.expressionString)")
    }
    
    
    /// This function will attempt to parse a user's expression string to get extract
    ///  operands and operator
    ///
    /// - Parameter expr: Expression string
    /// - Returns: FractionExpression containg extracted operators and operands
    ///
    func parseInput(expr: FractionExpression) throws -> FractionExpression {
        var expression = FractionExpression(expr: expr.expressionString)
        let delimittedInput = expression.expressionString.split(separator: " ")
        
        try delimittedInput.forEach { token in
            if let legalOperator = LegalOperator.getLegalOperator(str: String(token)) {
                expression.operators.append(legalOperator)
            }
            
            if let resolvedNumber = try fractionToDouble(expr: FractionExpression(expr: String(token))) {
                expression.operands.append(resolvedNumber)
            }
        }
        
        guard expression.operators.count >= 1 else {
            throw ExpressionError.invalidOperator("At least one operator required. Only \(expression.operators) supplied")
        }
        
        guard expression.operands.count >= 2 else {
            throw ExpressionError.invalidOperand("At least two operands required. Only \(expression.operands) supplied")
        }
        
        return expression
    }
    
  
    /// Convert a given string to a Double if possible
    /// Acceptable formats { fraction (3/4), mixed_fraction (3_3/4), whole_number (23) }
    ///
    /// - Parameter expr: The portion of expression string to convert string to Double
    ///
    func fractionToDouble(expr: FractionExpression) throws -> Double? {
        let trimmed = expr.expressionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmed.count >= 1 else {
            throw ExpressionError.invalidExpression("Invalid expression provided while parsing \(trimmed). Count less than 1")
        }
        
        if trimmed.isWholeNumber() {
            return Double(trimmed)
        }
        
        if trimmed.isFraction() {
            return try trimmed.getFractionFromString()
        }
        
        if trimmed.isMixedFraction() {
            if let mixedFractionValue = try trimmed.getMixedFractionValue() {
                return mixedFractionValue
            }
        }
        
        return nil
    }
    
    
    /// This function given a Double will return a fraction in string form
    ///
    /// - Parameter value: The Double to be converted to fraction
    /// - Returns: String value of fractionalized version of the Double value provided
    ///
    func doubleToFraction(value: Double) -> String {
        let splitAtDecimal = String(value).split(separator: ".")
        let wholeNumberPortion = String(splitAtDecimal.first ?? "")
        let remainderPortion = String(splitAtDecimal.last ?? "")
        let isNegativeNumber = wholeNumberPortion.first == "-"
        let wholeNumberHasValue = !(Double(wholeNumberPortion)?.isZero ?? false)
        
        // Handle case for when just a whole number e.g. 1.0
        if !(wholeNumberHasValue) && (Double(remainderPortion)?.isZero ?? false) {
            return "\(wholeNumberPortion)"
        }
        
        // Value after decimal
        let remainderValue = round(pow(10.0, Double(remainderPortion.count)) * Double(precisionRoundingPlaces)) / Double(precisionRoundingPlaces)
        
        let denominator = (Int)(remainderValue)
        let numerator = FractionExpression.getFinalNumerator(numerator: (Int)(value * remainderValue), denominator: denominator)
        let fractionExpression = FractionExpression(numerator: numerator, denominator: denominator)
        let reducedFraction = fractionExpression.lowestReducedFraction()
        
        // Default to format of e.g. 1_3/4
        var format = "%@%@_%@"
        let formattedNegative = isNegativeNumber ? "" : ""
        
        // 1
        if wholeNumberHasValue && !(numerator > 0) {
            format = "%@%@"
            return String(format: "\(format)", formattedNegative, wholeNumberPortion)
        }
        
        // 1/2
        if !wholeNumberHasValue && (numerator > 0){
            format = "%@%@"
            return String(format: "\(format)", formattedNegative, reducedFraction)
        }
        
        return String(format: "\(format)", formattedNegative, wholeNumberPortion, reducedFraction)
    }
    
    /// This function given two operands and a operator will return result of operation
    ///
    /// - Parameter l: Left operand
    /// - Parameter r: Right operand
    /// - Parameter op: Operator
    /// - Returns: Double of arithmitic operation
    ///
    func performMathOperation(l: Double, r: Double, op: LegalOperator) throws -> Double? {
        switch op {
        case .multiply:
            return l * r
        case .divide:
            guard r != 0 else { throw ExpressionError.divideByZero }
            return l / r
        case .plus:
            return l + r
        case .minus:
            return l - r
        case .none:
            return nil
        }
    }
}
