//
//  FractionExpression+Extension.swift
//  smooth-operator-lib
//
//  Created by Justin Trantham on 10/7/21.
//

import Foundation

internal extension FractionExpression {
    func gcd(numerator: Int, denominator: Int) -> Int {
        return denominator == 0 ? numerator : gcd(numerator: denominator, denominator: numerator % denominator)
    }
    
    func lowestReducedFraction() -> String {
        let n = numerator ?? 0
        let d = denominator ?? 0
        
        let gcd = gcd(numerator: n, denominator: d)
        
        return "\(n/gcd)/\(d/gcd)"
    }
    
    static func getFinalNumerator(numerator: Int, denominator: Int) -> Int {
        let n = numerator
        let d = denominator
        
        return abs(((abs(n) >= d) || (n == 0)) ? (n % d) : n)
    }
}
