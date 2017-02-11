//
//  Utils.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

protocol StringRepresentableSource {
    init(rawValue : String)
}

protocol ComponentStringRepresentable : StringRepresentable {
    var components : [StringRepresentable] { get set }
}

protocol StringRepresentable {
    var rawValue: String { get }
}

class Utils {
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafePointer(to: &i) {
                $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
            }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
    
}
