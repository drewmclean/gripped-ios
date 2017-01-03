//
//  FormField.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation
import UIKit

struct FormField {
    var title : String
    var unit : String
    var propertyKey : String
    var textFieldConfiguration : (UITextField) -> Void?
    
    init (title:String, unit:String, propertyKey:String, textFieldConfiguration: @escaping (UITextField) -> Void) {
        self.title = title
        self.unit = unit
        self.propertyKey = propertyKey
        self.textFieldConfiguration = textFieldConfiguration
    }
}
