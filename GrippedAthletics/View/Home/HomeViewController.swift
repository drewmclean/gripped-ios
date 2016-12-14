//
//  HomeViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet weak var recordClimbButton: UIButton!
    @IBOutlet weak var updateBiometricsButton: UIButton!
    @IBOutlet weak var updateProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.leftBarButtonItem = barItemForNavType(withType: .mainMenu)
        
    }
}
