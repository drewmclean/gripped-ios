//
//  SignUpViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 11/20/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class SignUpViewController: UINavigationController {

    lazy var emailViewController : AuthTextFieldViewController = {
        let vc = self.storyboard!.instantiateViewController(withClass: AuthTextFieldViewController.self) as! AuthTextFieldViewController
        
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([emailViewController], animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
