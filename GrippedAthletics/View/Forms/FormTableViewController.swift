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
    
    var cellReuseId : String {
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = barItemForNavType(withType: .close)
        navigationItem.rightBarButtonItem = barItemForNavType(withType: .done, title: "Save", target: self, action: #selector(FormTableViewController.didTapSave(sender:)))
    }
    
    func createFields() -> [FormField] {
        return [FormField]()
    }
    
    func didTapSave(sender:UIBarButtonItem) {
        if validateFields() {
            saveFields()
        }
    }
    
    func validateFields() -> Bool {
        return true
    }
    
    func saveFields() {
        
    }
    
}

// MARK: UITableViewDataSource

extension FormTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = fields[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! FormFieldTableViewCell
        cell.formField = field
        return cell
    }
    
}
