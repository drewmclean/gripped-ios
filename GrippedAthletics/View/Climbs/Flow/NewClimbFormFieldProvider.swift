//
//  File.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/9/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class NewClimbFormFieldProvider : FormStackItemProvider {
    
    var items: [FormStackItem] = [FormStackItem]()
    
    init() {
        items = [climbType]
    }
    
    lazy var climbType : FormStackItem = {
        let field = FormField(title: "What type of climb?", unit: "", propertyKey: Climb.Keys.type) { (textField : UITextField) in
        
        }
        let vc = ClimbTypeViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
        
    lazy var sportRating : FormStackItem = {
        let field = FormField(title: "What would you rate the climb?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
        let vc = SportRatingViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
        
    lazy var boulderRating : FormStackItem = {
            let field = FormField(title: "How hard would you rate this problem?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
            let vc = BoulderRatingViewController()
            return FormStackItem(formField: field, itemViewController: vc)
        }()
        
    lazy var climbVenue : FormStackItem = {
            let field = FormField(title: "Is this climb indoor or outdoor?", unit: "", propertyKey: Climb.Keys.venue) { (textField : UITextField) in }
            let vc = ClimbVenueViewController()
            return FormStackItem(formField: field, itemViewController: vc)
        }()
        
    lazy var climbColor : FormStackItem = {
        let field = FormField(title: "Does the climb have a color?", unit: "", propertyKey: Climb.Keys.color) { (textField : UITextField) in }
        let vc = ClimbColorViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()

}
