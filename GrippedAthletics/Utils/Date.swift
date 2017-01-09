//
//  D.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/2/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

enum DateFormat : String {
    case short = "MM/DD/YYYY"
    case long = ""
}

struct DateFormaters {
    
}

extension Date {
    
    struct Formatters {
        static var iso : DateFormatter {
            let isoFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let formatter = DateFormatter()
            formatter.dateFormat = isoFormat
            return formatter
        }
    }
    
    func sinceNowInYears() -> Int {
        let now = Date()
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.year, from: self, to: now as Date, options: [])
        let age = ageComponents.year!
        return age
    }
    
    func shortString() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = DateFormat.short.rawValue
        return formatter.string(from: self)
    }
    
    func isoString() -> String {
        return Formatters.iso.string(from: self)
    }
    
    // Date Creation Statics
    
    static func isoDate(from dateString : String) -> Date? {
        return Formatters.iso.date(from: dateString)
    }
}
