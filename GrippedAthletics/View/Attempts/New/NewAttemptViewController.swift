//
//  NewAttemptViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/14/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewAttemptViewController: FormStackViewController {
    typealias T = FormStackItemProvider
    
    var attempt : Attempt?
    var climb : Climb!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Record Attempt"
        
        provider = NewAttemptFormFieldProvider(climb: climb)
        reloadViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func submitForm() {
        if let existingClimb = climb {
            existingClimb.update(updatedValues: formFieldValues!) { (error: Error?, c:Climb?) in
                guard error == nil else {
                    return
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            var formValues = formFieldValues!
            formValues[Climb.Keys.userId] = auth.currentUser!.uid
            let now = Date().isoString()
            formValues[Climb.Keys.createdAt] = now
            formValues[Climb.Keys.modifiedAt] = now
            
            // Create New
            Attempt.create(fieldValues: formValues) { (error: Error?, snapshot: FIRDataSnapshot?) in
                guard let s = snapshot else {
                    return
                }
                self.attempt = Attempt(snapshot: s)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
