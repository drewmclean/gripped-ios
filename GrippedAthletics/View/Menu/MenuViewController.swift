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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
    }
    
}
