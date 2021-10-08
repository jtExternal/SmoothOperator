//
//  FractionExpressionExtensionTests.swift
//  smooth-operator-libTests
//
//  Created by Justin Trantham on 10/8/21.
//

import XCTest
@testable import smooth_operator_lib

class FractionExpressionExtensionTests: XCTestCase {
    
    func testGCDWithZeroDenominator() throws {
        // Setup
        let fractionExpression = FractionExpression(numerator: 4500, denominator: 0)
        
        // Execute
        let result = fractionExpression.gcd(numerator: fractionExpression.numerator ?? 0, denominator: fractionExpression.denominator ?? 0)
        
        // Assert
        XCTAssertTrue(result == fractionExpression.numerator)
    }
    
    func testGCDWithValidValue() throws {
        // Setup
        let fractionExpression = FractionExpression(numerator: 457800, denominator: 4560)
        
        // Execute
        let result = fractionExpression.gcd(numerator: fractionExpression.numerator ?? 0, denominator: fractionExpression.denominator ?? 0)
        
        // Assert
        XCTAssertTrue(result == 120)
    }
    
    func testLowestReducedFractionWithValidValues() throws {
        // Setup
        let fractionExpression = FractionExpression(numerator: 457800, denominator: 4560)
        
        // Execute
        let result = fractionExpression.lowestReducedFraction()
        
        // Assert
        XCTAssertTrue(result == "3815/38")
    }

}
