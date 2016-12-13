//
//  MenuViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

enum MenuOption {
    case dashboard, viewActivities, createActivity
}

protocol MenuViewControllerDelegate {
    func menuDidChange(menuOption : MenuOption)
}

class MenuViewController: UIViewController {
    
    var delegate : MenuViewControllerDelegate?
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabelsStackView: UIStackView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
    }
    
}
