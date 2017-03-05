//
//  NewAttemptFormProvider.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/14/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftValidator

class NewAttemptFormFieldProvider : FormStackItemProvider {
    
    var items : [FormStackItem] = [FormStackItem]()
    var validator: Validator = Validator()
    
    var climb : Climb
    
    init(climb : Climb) {
        self.climb = climb
        
        items = [attemptedDate, style, didSend, strengthLevel, fearLevel, notes]
    }
    
    lazy var attemptedDate : FormStackItem = {
        let field = FormField(title: "Attempt Date", unit: "", propertyKey: Attempt.Keys.attemptedAt) { (textField : UITextField) in }
        self.validator.registerField(field, rules: [RequiredRule()])
        let vc = FormStackItemDatePickerViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var strengthLevel : FormStackItem = {
        let field = FormField(title: "How strong did you feel?", unit: "", propertyKey: Attempt.Keys.strengthLevel) { (textField : UITextField) in
            
        }
        self.validator.registerField(field, rules: [RequiredRule()])
        
        let vc = FormStackItemSliderViewController()
        vc.minimumValueDescriptor = "Very Weak"
        vc.maximumValueDescriptor = "Very Strong"
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var fearLevel : FormStackItem = {
        let field = FormField(title: "How was your mental composure?", unit: "", propertyKey: Attempt.Keys.fearLevel) { (textField : UITextField) in
            
        }
        self.validator.registerField(field, rules: [RequiredRule()])
        
        let vc = FormStackItemSliderViewController()
        vc.minimumValueDescriptor = "Very Scared"
        vc.maximumValueDescriptor = "Very Calm"
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var style : FormStackItem = {
        let field = FormField(title: "Style of attempt?", unit: "", propertyKey:Attempt.Keys.style) { (textField : UITextField) in }
        let vc = AttemptStyleViewController()
        vc.climbType = self.climb.type
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var didSend : FormStackItem = {
        let field = FormField(title: "Did you send?", unit: "", propertyKey: Attempt.Keys.didSend) { (textField : UITextField) in }
        let vc = YesNoPickerViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var notes : FormStackItem = {
        let field = FormField(title: "Notes", unit: "", propertyKey: Attempt.Keys.notes) { (textField : UITextField) in }
        let vc = FormStackItemTextViewViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()

    var fieldValues : [String:Any] {
        var values = [String : Any]()
        items.forEach({ (item : FormStackItem) in
            let key = item.formField.propertyKey
            values[key] = item.formField.value
        })
        return values
    }
}
