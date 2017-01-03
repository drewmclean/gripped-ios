//
//  D.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/2/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

extension Date {
    
    func sinceNowInYears() -> Int {
        let now = Date()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: self, to: now as Date, options: [])
        let age = ageComponents.year!
        return age
    }
}
