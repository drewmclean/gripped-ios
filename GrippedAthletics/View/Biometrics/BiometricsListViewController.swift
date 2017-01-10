//
//  BiometricsListViewController.swift
//  GrippedAthletics
//  
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseDatabaseUI

class BiometricsListViewController: UITableViewController {
    
    lazy var userBiometricsQuery: FIRDatabaseQuery = {
        return Biometrics.userObjectsRef.child(Auth.instance.currentUser!.uid)
    }()
    
    lazy var dataSource: FUITableViewDataSource = {
        let source = FUITableViewDataSource(query: self.userBiometricsQuery, view: self.tableView) { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
            
            print("\(indexPath.row): \(snapshot.value!)")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BiometricsListTableViewCell.cellId, for: indexPath) as! BiometricsListTableViewCell
            cell.biometrics = Biometrics(snapshot: snapshot)
            return cell
        }
        
        return source
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard auth.currentUser != nil else {
            return
        }
        
        title = "Biometrics"
        
        navigationItem.leftBarButtonItem = barItemForNavType(withType: .mainMenu)
        navigationItem.rightBarButtonItem = barItemForNavType(withType: .add, title: nil, target: self, action: #selector(BiometricsListViewController.didTapAdd(sender:)))
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard auth.currentUser != nil else {
            return
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension BiometricsListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

// MARK: Add Form

extension BiometricsListViewController {
    
    func didTapAdd(sender:UIBarButtonItem) {
        presentAddViewController()
    }
    
    func presentAddViewController() {
        let biometricsFormVC = storyboard?.instantiateViewController(withClass: BiometricsFormViewController.self) as! BiometricsFormViewController
        let nav = UINavigationController(rootViewController: biometricsFormVC)
        present(nav, animated: true, completion: nil)
    }
    
}
