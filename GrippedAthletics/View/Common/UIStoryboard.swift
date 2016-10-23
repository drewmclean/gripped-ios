//
//  UIStoryboard.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    open func instantiateViewController(withClass viewControllerClass: AnyClass) -> UIViewController {
        let identifer = "\(viewControllerClass)"
        let vc = instantiateViewController(withIdentifier: identifer)
        return vc
    }
    
}
