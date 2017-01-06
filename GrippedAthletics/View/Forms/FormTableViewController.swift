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
        
        fetchFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FormFieldTableViewCell {
            firstCell.textField.becomeFirstResponder()
        }
        
    }
    
    /// MARK: Actions
    func didTapSave(sender:UIBarButtonItem) {
        if validateFields() {
            saveFields()
        }
    }
    
    // MARK: Abstract
    func createFields() -> [FormField] {
        return [FormField]()
    }
    
    func fetchFields() {
        
    }
    
    func validateFields() -> Bool {
        return true
    }
    
    func saveFields() {
        
    }
}

// MARK: 
extension FormTableViewController {

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
