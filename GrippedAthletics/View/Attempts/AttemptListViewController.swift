//
//  AttemptsViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AttemptsViewController: FormStackItemPickerViewController {

    lazy var allAttempsQuery: FIRDatabaseQuery = {
        return Attempt.objectRef
    }()
    
    lazy var dataSource: FUITableViewDataSource = {
        let source = FUITableViewDataSource(query: self.allClimbsQuery, view: self.tableView) { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: ClimbListTableViewCell.cellId, for: indexPath) as! ClimbListTableViewCell
            cell.delegate = self
            cell.climb = Climb(snapshot: snapshot)
            return cell
        }
        
        return source
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "All Climbs"
        
        navigationItem.leftBarButtonItem = barItemForNavType(withType: .mainMenu)
        navigationItem.rightBarButtonItem = barItemForNavType(withType: .add, title: nil, target: self, action: #selector(ClimbListViewController.didTapAdd(sender:)))
        
        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UITableViewAutomaticDimension
        
        guard auth.currentUser != nil else {
            auth.firAuth.addStateDidChangeListener { (auth:FIRAuth, user:FIRUser?) in
                guard let _ = user else { return }
                self.initializeData()
            }
            return
        }
        
        initializeData()
        
    }
    
    func initializeData() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }

}
