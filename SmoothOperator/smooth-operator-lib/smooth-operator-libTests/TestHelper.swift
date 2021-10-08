//
//  TestHelper.swift
//  smooth-operator-libTests
//
//  Created by Justin Trantham on 10/7/21.
//

import Foundation


struct TestHelper {
    static let sampleTestExpressionsWithStringValues = ["1/2 * 3_3/4" : "1_7/8",
                                                        "2_3/8 + 9/8" : "3_1/2",
                                                        "-2_3/8 + 9/8" : "-1_1/4",
                                                        "4 * 5" : "20",
                                                        "1/4 + 1/4" : "1/2"
    ]
    
    static let sampleTestExpressionsWithDoubleValues = ["1/2 * 3_3/4" : 1.875,
                                                        "2_3/8 + 9/8" : 3.5,
                                                        "-2_3/8 + 9/8" : -1.25,
                                                        "4 * 5" : 20.0,
                                                        "1/4 + 1/4" : 0.5
    ]
    
    static let sampleTestExpressionsWithStringValuesAndDoubleKeys = [1.5: "1_1/2",
                                                                     3.5: "3_1/2",
                                                                     -1.25: "-1_1/4",
                                                                     20.0: "20",
                                                                     0.5: "1/2"
    ]
    
    static let sampleTestExpressionsSingleFractionWithDoubleValues = ["1/2" : 0.5,
                                                                      "2_3/8" : 2.375,
                                                                      "-1/2" : -0.5,
                                                                      "5" : 5.0,
                                                                      "1/4" : 0.25
    ]
    
}
