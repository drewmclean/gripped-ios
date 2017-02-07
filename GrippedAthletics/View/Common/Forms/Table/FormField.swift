//
//  FormField.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import Foundation
import UIKit

protocol FormFieldValidator {
    var value : String? { get set }
    func validate(value:String?) -> Bool
}

class FormField {
    var indexPath : Int!
    var title : String
    var unit : String
    var propertyKey : String
    var value : String = ""
    var isValid : Bool {
        guard let v = validator else {
            return true
        }
        return v.validate(value: value)
    }
    var textFieldConfiguration : (UITextField) -> Void?
    var validator : FormFieldValidator?
    
    init (title:String, unit:String, propertyKey:String, textFieldConfiguration: @escaping (UITextField) -> Void) {
        self.title = title
        self.unit = unit
        self.propertyKey = propertyKey
        self.textFieldConfiguration = textFieldConfiguration
        
    }
    
}
