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
    
    
    init() {
        items = [climbVenue, climbType]
        
    }
    
    /*
     static let attemptedAt = "attempted_at"
     static let composureLevel = "composure_level"
     static let fearLevel = "fear_level"
     static let notes = "notes"
     static let style = "style" // Onsight, Redpoint, Flash, Project
     static let didSend = "did_send"
     */
    
    lazy var climbVenue : FormStackItem = {
        let field = FormField(title: "Is this climb indoor or outdoor?", unit: "", propertyKey: Climb.Keys.venue) { (textField : UITextField) in }
        
        self.validator.registerField(field, rules: [RequiredRule()])
        
        let vc = ClimbVenueViewController()
        
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbType : FormStackItem = {
        let field = FormField(title: "What type of climb is it?", unit: "", propertyKey: Climb.Keys.type) { (textField : UITextField) in
            
        }
        
        let next = { () -> [FormStackItem] in
            let venue = self.climbVenue.formField.value
            let climbType = self.climbType.formField.value
            return self.venueAndTypeFormStackItems["\(venue)\(climbType)"]!
        }
        
        return FormStackItem(formField: field, itemViewController: ClimbTypeViewController(), followingItems: next)
    }()
    
    lazy var sportRating : FormStackItem = {
        let field = FormField(title: "Rating", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
        let vc = SportRatingViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbPhoto : FormStackItem = {
        let field = FormField(title: "Route Photo", unit: "", propertyKey: Climb.Keys.photoUrl) { (textField : UITextField) in }
        let vc = ClimbPhotoViewController()
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
