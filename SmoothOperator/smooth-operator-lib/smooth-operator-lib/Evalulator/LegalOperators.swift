//
//  LegalOperator.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/5/21.
//

import Foundation

internal enum LegalOperator: String {
    case multiply = "*"
    case divide = "/"
    case plus = "+"
    case minus = "-"
    case none
    
    static func getLegalOperator(str: String) -> LegalOperator? {
        switch str.trimmingCharacters(in: .whitespacesAndNewlines) {
        case "*": return .multiply
        case "/": return .divide
        case "+": return .plus
        case "-": return .minus
        default:
            return nil
        }
    }
}
