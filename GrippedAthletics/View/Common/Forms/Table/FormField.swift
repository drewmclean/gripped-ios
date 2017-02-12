//
//  FormField.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SwiftValidator

protocol FormFieldValidator {
    var value : String? { get set }
    func validate(value:String?) -> Bool
    var validator : Validator { get set }
}

class FormField : Validatable {
    
    var validationText: String { return value }
    
    var indexPath : Int!
    var title : String
    var unit : String
    var propertyKey : String
    var value : String = ""
    var isValid : Bool {
        return validator?.validate(value: value) ?? false
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
