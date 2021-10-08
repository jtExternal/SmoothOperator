//
//  StringExtensionTests.swift
//  smooth-operator-libTests
//
//  Created by Justin Trantham on 10/7/21.
//

import XCTest
@testable import smooth_operator_lib

class StringExtensionTests: XCTestCase {
    func testIsWholeNumber_nonNegativeWholeNumber() throws {
        // Setup
        let testString = "-1.254"
        
        // Execute
        let result = testString.isWholeNumber()
        
        // Assert
        XCTAssertFalse(result)
    }
    
    func testIsWholeNumber_validWholeNumber() throws {
        // Setup
        let testString = "1"
        let testString2 = "-1"
        
        // Execute
        let result = testString.isWholeNumber()
        let resul2 = testString2.isWholeNumber()
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertTrue(resul2)
    }
    
    func testIsMixedFraction() throws {
        // Setup
        let validMixedFraction = "1_3/4"
        let invalidMixedFraction = "1"
        
        // Execute
        let result = validMixedFraction.isMixedFraction()
        let resul2 = invalidMixedFraction.isMixedFraction()
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertFalse(resul2)
    }
    
    func testIsFraction() throws {
        // Setup
        let validFraction = "3/4"
        let invalidFraction = "1"
        
        // Execute
        let result = validFraction.isFraction()
        let resul2 = invalidFraction.isFraction()
        
        // Assert
        XCTAssertTrue(result)
        XCTAssertFalse(resul2)
    }
    
    func testGetMixedFractionValue() throws {
        // Setup
        let validFraction = "1_3/4"
        let invalidFraction = "1"
        
        // Execute
        let result = try! validFraction.getMixedFractionValue()
        
        // Assert
        XCTAssertTrue(result == 1.75)
        
        XCTAssertThrowsError(try invalidFraction.getMixedFractionValue()) { error in
            guard case ExpressionError.invalidExpression(_) = error else {
                return XCTFail()
            }
            
        }
    }
    
    func testGetFractionFromString() throws {
        // Setup
        let validFraction = "3/4"
        let invalidFraction = "1"
        
        // Execute
        let result = try! validFraction.getFractionFromString()
        
        // Assert
        XCTAssertTrue(result == 0.75)
        
        XCTAssertThrowsError(try invalidFraction.getFractionFromString()) { error in
            guard case ExpressionError.invalidExpression(_ ) = error else {
                return XCTFail()
            }
            
        }
    }
}
