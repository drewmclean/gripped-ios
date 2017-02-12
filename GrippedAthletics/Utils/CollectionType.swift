//
//  CollectionType.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/11/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Use as
    ///
    ///      let num = [1,2,3,4,5]
    ///      num.forEach{
    ///        if $1 > 3 { $2 = true }
    ///        print($0,$1)
    ///      }
    func forEach(body: ((Self.Iterator.Element, Int, inout Bool) -> Void)) {
        var stop = false
        let enumerate = self.enumerated()
        for (index,value) in enumerate {
            if stop { break }
            body(value,index,&stop)
        }
    }
    
    /// Use as
    ///
    ///      let num = [1,2,3,4,5]
    ///      num.forEach{
    ///        if $0 > 3 { $1 = true }
    ///        print($0)
    ///      }
    func forEach(body: ((Self.Iterator.Element, inout Bool) -> Void)) {
        var stop = false
        for value in self {
            if stop { break }
            body(value,&stop)
        }
    }
}
