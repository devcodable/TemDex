//
//  Int+Extension.swift
//  TemDex
//
//  Created by dabiz on 21/12/2023.
//

import Foundation

extension Int {
    func toHashtag() -> String {
        var result: String = "#"
        var zerosNeeded: Int = 0
        if self/10 >= 10 {
            zerosNeeded = 0
        } else if self/10 >= 1 {
            zerosNeeded = 1
        } else if self/10 >= 0 {
            zerosNeeded = 2
        }
        
        for _ in 0..<zerosNeeded {
            result.append("0")
        }
        result.append("\(self)")
        return result
    }
    
    func toDouble() -> Double {
        Double(self)
    }
}
