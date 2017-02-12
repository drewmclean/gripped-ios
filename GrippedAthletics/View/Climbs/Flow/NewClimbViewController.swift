//
//  CreateClimbViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class NewClimbViewController: FormStackViewController {
    typealias T = FormStackItemProvider
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Climb"
        
        provider = NewClimbFormFieldProvider()
        reloadViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


