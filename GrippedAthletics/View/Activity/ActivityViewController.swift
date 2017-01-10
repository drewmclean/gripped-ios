//
//  ActivityViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 12/13/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Climbs"
        
        navigationItem.leftBarButtonItem = barItemForNavType(withType: .mainMenu)
        navigationItem.rightBarButtonItem = barItemForNavType(withType: .add, title: nil, target: self, action: #selector(ActivityViewController.didTapAdd(sender:)))
        
    }

    func didTapAdd(sender:Any) {
        
    }

}
