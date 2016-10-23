//
//  MainViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import PKRevealController

class MainViewController: PKRevealController, MenuViewControllerDelegate {
    
    lazy var menuViewController : MenuViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: MenuViewController.self) as! MenuViewController
        
        return vc
    }()
    
    lazy var profileViewController : ProfileViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: ProfileViewController.self) as! ProfileViewController
        
        return vc
    }()
    
    lazy var homeViewController : HomeViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: HomeViewController.self) as! HomeViewController
        let nav = UINavigationController(rootViewController: vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        
        setupRevealControllers()
    }
    
    func setupRevealControllers() {
        leftViewController = menuViewController
        frontViewController = homeViewController.navigationController
        rightViewController = profileViewController
    }
    
    func setupMenu() {
        menuViewController.delegate = self
    }
    
    // MARK: MenuViewControllerDelegate
    
    func menuDidChange(menuOption: MenuOption) {
        let viewController : UIViewController = homeViewController
        changeFrontViewController(viewController: viewController)
    }
    
    // MARK: Navigation
    
    func changeFrontViewController(viewController : UIViewController) {
        
    }

}
