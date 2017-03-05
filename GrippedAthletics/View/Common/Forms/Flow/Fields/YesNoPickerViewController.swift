//
//  YesNoPickerViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

enum BooleanOptions : String, StringRepresentable {
    case yes = "yes"
    case no = "no"
    
    static let allValues = [yes, no]
    
    var boolValue : Bool {
        return rawValue == BooleanOptions.yes.rawValue ? true : false
    }
}

struct YesNoProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [BooleanOptions.allValues]
}

class YesNoPickerViewController: FormStackItemPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
