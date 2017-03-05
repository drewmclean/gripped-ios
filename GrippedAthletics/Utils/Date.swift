//
//  D.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/2/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation

enum DateFormat : String {
    case iso = "yyyy-MM-dd'T'HH:mm:ssZ"
    case short = "MM/DD/YYYY"
    case long = "MM/DD/YYYY HH:MM"
}

extension Date {
    
    struct Formatters {
        
        static var iso : DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.iso.rawValue
            return formatter
        }
        
        static var short : DateFormatter {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = DateFormat.short.rawValue
            return formatter
        }
        
        static var long : DateFormatter {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = DateFormat.long.rawValue
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
        return Formatters.short.string(from: self)
    }
    
    func longString() -> String {
        return Formatters.long.string(from: self)
    }
    
    func isoString() -> String {
        return Formatters.iso.string(from: self)
    }
    
    // Date Creation Statics
    
    static func isoDate(from dateString : String) -> Date? {
        return Formatters.iso.date(from: dateString)
    }
}
