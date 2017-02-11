//
//  SportRatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

struct SportRatingComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]]
    
    init() {
        providers = [Ratings.NorthAmerica.ClassGrade.allValues, Ratings.NorthAmerica.SubGrade.allValues]
    }
}


class SportRatingViewController: FormStackItemPickerViewController {
    
    override var nextFormItem: FormStackItem? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
