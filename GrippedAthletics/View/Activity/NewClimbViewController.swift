//
//  CreateClimbViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

struct NewClimbFormFieldProvider : FormFieldProvider {
    
    struct Items {
        lazy var climbType : FormStackItem = {
            let field = FormField(title: "Type of Climb", unit: "", propertyKey: <#T##String#>) { (textField : UITextField) in
                
            }
            
            let vc = ClimbTypeViewController()
            
            return FormStackItem(formField: field, itemViewController: vc)
        }()
    }
    
    var formFields: [String : FormField] {
        return [String : FormField]()
    }
}

struct NewClimbFieldViewControllers {
    lazy var climbTypeViewController : ClimbTypeViewController = {
        let climbTypeVC = ClimbTypeViewController()
        
        return climbTypeVC
    }()
}

class NewClimbViewController: FormStackViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = NewClimbFormFieldProvider()
        provider?.formFields = NewClimbFormFieldProvider()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
