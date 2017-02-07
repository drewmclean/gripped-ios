//
//  CreateClimbViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class NewClimbViewController: FormStackViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Climb"
        
        provider = NewClimbFormFieldProvider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

struct NewClimbFormFieldProvider : FormStackItemProvider {
    
    var items: [FormStackItem] = [FormStackItem]()
    
    init() {
        items = [Items.climbType]
    }
    
    struct Items {
        static var climbType : FormStackItem = {
            let field = FormField(title: "What type of climb?", unit: "", propertyKey: Climb.Keys.type) { (textField : UITextField) in }
            let vc = ClimbTypeViewController()
            vc.formField = field
            return FormStackItem(formField: field, itemViewController: vc)
        }()
        
        static var sportRating : FormStackItem = {
            let field = FormField(title: "What would you rate the climb?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
            let vc = SportRatingViewController()
            vc.formField = field
            return FormStackItem(formField: field, itemViewController: vc)
        }()
        
        static var boulderRating : FormStackItem = {
            let field = FormField(title: "How hard would you rate this problem?", unit: "", propertyKey: Climb.Keys.rating) { (textField : UITextField) in }
            let vc = BoulderRatingViewController()
            vc.formField = field
            return FormStackItem(formField: field, itemViewController: vc)
        }()
    }
}