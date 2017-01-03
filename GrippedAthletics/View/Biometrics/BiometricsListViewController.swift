//
//  BiometricsListViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class BiometricsListViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Biometrics"
        
        navigationItem.rightBarButtonItem = barItemForNavType(withType: .add, title: nil, target: self, action: #selector(BiometricsListViewController.didTapAdd(sender:)))
    }
}

// MARK: - UITableViewDataSource

extension BiometricsListViewController  {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BiometricsListTableViewCell.cellId, for: indexPath) as! BiometricsListTableViewCell
        
        return cell
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
        
    }
    
    func presentAddViewController() {
        
    }
    
}
