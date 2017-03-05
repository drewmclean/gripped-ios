//
//  AttemptStyleViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class AttemptStyleViewController: FormStackItemPickerViewController {
    
    var climbType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch climbType {
        case ClimbType.sport.rawValue:
            provider = SportStylesComponentProvider()
            break
        case ClimbType.boulder.rawValue:
            provider = BoulderStylesComponentProvider()
            break
        case ClimbType.trad.rawValue:
            provider = TradStylesComponentProvider()
            break
        default:
            provider = SportStylesComponentProvider()
        }
    }
    
}

extension AttemptStyleViewController : PickerComponentProvider {
    
}

struct SportStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.sportValues]
}

struct BoulderStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.boulderValues]
}

struct TradStylesComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [AttemptStyle.tradValues]
}
