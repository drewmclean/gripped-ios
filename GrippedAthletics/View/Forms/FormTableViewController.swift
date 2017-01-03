//
//  FormTableViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FormTableViewController: UITableViewController {
    
    lazy var fields : [FormField] = {
        return self.createFields()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FormFieldTableViewCell.self, forCellReuseIdentifier: FormFieldTableViewCell.cellId)
    }
    
    func createFields() -> [FormField] {
        return [FormField]()
    }
}
