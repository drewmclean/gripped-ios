//
//  String.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/6/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

extension String {
    var hex: Int? {
        return Int(self, radix: 16)
    }
}

extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
