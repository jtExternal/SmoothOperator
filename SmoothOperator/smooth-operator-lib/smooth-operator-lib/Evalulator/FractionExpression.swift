//
//  FractionExpression.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/7/21.
//

import Foundation

internal struct FractionExpression {
    var expressionString: String = ""
    var operands = [Double]()
    var operators = [LegalOperator]()
    var numerator: Int?
    var denominator: Int?
    
    init(expr: String) {
        self.expressionString = expr
    }
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    init(operands: [Double], operators: [LegalOperator]) {
        self.operands = operands
        self.operators = operators
    }
}

