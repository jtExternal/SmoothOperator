//
//  String+Extension.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/6/21.
//

import Foundation

internal extension String {
    var isInteger: Bool { return Int(self) != nil }
    var isFloat: Bool { return Float(self) != nil }
    var isDouble: Bool { return Double(self) != nil }
    
    // Is the string in the format {number} ?
    func isWholeNumber() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let wholeNumberPattern = #"^[0-9-]+$"#
        
        let wholeNumberRegexMatch = trimmed.range(
            of: wholeNumberPattern,
            options: .regularExpression
        )
        
        return wholeNumberRegexMatch != nil
    }
    
    // Is the string in the format {number}_{number}/{number} ?
    func isMixedFraction() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.split(separator: "_").count == 2
    }
    
    // Is the string in the format {number}/{number} ?
    func isFraction() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let fractionPattern = #"^(-?)*(?:(\d+)\s)?(\d+)\/(\d+)$"#
        
        let fractionRegexMatch = trimmed.range(
            of: fractionPattern,
            options: .regularExpression
        )
        
        return fractionRegexMatch != nil
    }
    
    // Convert string in the format of {number}_{number}/{number} to a Double if possible
    // e.g. 2_3/4 -> 2.75
    func getMixedFractionValue() throws -> Double? {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let mixedFraction = trimmed.split(separator: "_")
        
        guard mixedFraction.count == 2 else {
            throw ExpressionError.invalidExpression("Invalid mixed fraction while parsing \(trimmed)")
        }
        
        let wholeNumberPortion = mixedFraction.first ?? ""
        let fractionPortion = String(mixedFraction.last ?? "")
        let isNegativeNumber = wholeNumberPortion.first == "-"
        
        // Check to see if number has negative sign
        let stringWithoutNegative = isNegativeNumber ? String(wholeNumberPortion.dropFirst()) : String(wholeNumberPortion)
        
        if let first = Double(stringWithoutNegative), let second = try fractionPortion.getFractionFromString() {
            return isNegativeNumber ? (-1) * (first + second) : first + second
        }
        
        throw ExpressionError.invalidExpression("Invalid mixed fraction while parsing \(trimmed)")
    }
    
    // Convert string in the format of {number}/{number} to a Double if possible
    // e.g. 3/4 -> 0.75
    func getFractionFromString() throws -> Double? {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let splitNumber = trimmed.split(separator: "/")
        
        guard splitNumber.count == 2 else {
            throw ExpressionError.invalidExpression("Invalid fraction while parsing \(trimmed)")
        }
        
        if let first = Double(splitNumber.first ?? ""), let second = Double(splitNumber.last ?? "") {
            return second == 0 ? nil : Double(first/second)
        }
        
        throw ExpressionError.invalidExpression("Invalid fraction while parsing \(trimmed)")
    }
}
