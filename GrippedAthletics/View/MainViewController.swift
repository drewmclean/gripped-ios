//
//  MainViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import PKRevealController

class MainViewController: PKRevealController {
    
    lazy var menuViewController : MenuViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: MenuViewController.self) as! MenuViewController
        
        return vc
    }()
    
    lazy var profileViewController : ProfileViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: ProfileViewController.self) as! ProfileViewController
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRevealControllers()
    }

    func setupRevealControllers() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
