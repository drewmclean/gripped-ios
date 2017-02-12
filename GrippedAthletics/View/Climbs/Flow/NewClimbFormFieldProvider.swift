//
//  File.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/9/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewClimbFormFieldProvider : FormStackItemProvider {
    
    var items : [FormStackItem] = [FormStackItem]()
    
    lazy var venueAndTypeFormStackItems : [String : [FormStackItem]] = {
        
        var indoorSport = [self.sportRating, self.climbColor, self.climbName, self.climbDescription]
        var indoorBoulder = [self.boulderRating, self.climbColor, self.climbName]
        
        var outdoorSport = [self.sportRating, self.climbName, self.climbDescription]
        var outdoorBoulder = [self.boulderRating, self.climbName, self.climbDescription]
        
        return ["\(ClimbVenue.indoor)\(ClimbType.sport)" : indoorSport,
                "\(ClimbVenue.indoor)\(ClimbType.boulder)" : indoorBoulder,
                "\(ClimbVenue.outdoor)\(ClimbType.sport)" : outdoorSport,
                "\(ClimbVenue.outdoor)\(ClimbType.boulder)" : outdoorBoulder]
    }()
    
    init() {
        items = [climbVenue, climbVenue]
    }
    
    lazy var climbVenue : FormStackItem = {
        let field = FormField(title: "Is this climb indoor or outdoor?", unit: "", propertyKey: Climb.Keys.venue) { (textField : UITextField) in }
        let vc = ClimbVenueViewController()
        let next = { () -> [FormStackItem] in
            let venue = self.climbVenue.formField.value
            let climbType = self.climbType.formField.value
            return self.venueAndTypeFormStackItems["\(venue)\(climbType)"]!
        }
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbType : FormStackItem = {
        return FormStackItem(formField: FormField(title: "What type of climb?", unit: "", propertyKey: Climb.Keys.type) { (textField : UITextField) in
            
        }, itemViewController: ClimbTypeViewController(), followingItems: nil)
    }()
        
    lazy var sportRating : FormStackItem = {
        let field = FormField(title: "How hard would you rate this climb?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
        let vc = SportRatingViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
        
    lazy var boulderRating : FormStackItem = {
        let field = FormField(title: "How hard would you rate this problem?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
        let vc = BoulderRatingViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbColor : FormStackItem = {
        let field = FormField(title: "Does the climb have a color?", unit: "", propertyKey: Climb.Keys.color) { (textField : UITextField) in }
        let vc = ClimbColorViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbName : FormStackItem = {
        let field = FormField(title: "Does the climb have a name?", unit: "", propertyKey: Climb.Keys.name) { (textField : UITextField) in }
        let vc = ClimbNameViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbDescription : FormStackItem = {
        let field = FormField(title: "Describe the climb (optional)", unit: "", propertyKey: Climb.Keys.description) { (textField : UITextField) in }
        let vc = ClimbDescriptionViewController()
        return FormStackItem(formField: field, itemViewController: vc)
    }()
    
    lazy var climbPhoto : FormStackItem = {
        let field = FormField(title: "Add a photo?", unit: "", propertyKey: Climb.Keys.photoUrl) { (textField : UITextField) in }
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
