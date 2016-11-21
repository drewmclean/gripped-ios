//
//  UIStoryboard.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    @nonobjc static let main = UIStoryboard(name: "Main", bundle: nil)
    @nonobjc static let auth = UIStoryboard(name: "Auth", bundle: nil)
    
    open func instantiateViewController(withClass viewControllerClass: AnyClass) -> UIViewController {
        let identifer = "\(viewControllerClass)"
        let vc = instantiateViewController(withIdentifier: identifer)
        return vc
    }
    
}
