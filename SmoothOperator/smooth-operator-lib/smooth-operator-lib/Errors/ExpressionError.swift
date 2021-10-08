//
//  ExpressionError.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/6/21.
//

import Foundation

enum ExpressionError: Error, LocalizedError {
    case invalidExpression(String)
    case divideByZero
    case invalidOperator(String)
    case invalidOperand(String)

    var errorDescription: String? {
        switch self {
        case .invalidExpression(let msg):
            return "Please supply expression in the format { operand operator operand }. E.g. 1/2 * 3_3/4 \(msg)"
        case .divideByZero:
            return "Unable to divide by zero."
        case .invalidOperand(let msg):
            return "Invalid operand supplied. Operands should be in the format of { whole_number (1) , fraction (1/4) , mixed_fraction (1_3/4) }. \(msg)"
        case .invalidOperator(let msg):
            return "Invalid operator supplied. Only { +,-,/,* } are allowed. \(msg)"
        }
    }
}
