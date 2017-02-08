//
//  RouteColorViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

import IGColorPicker

class ClimbColorViewController: FormStackItemViewController {

    lazy var colorPickerView : ColorPickerView = {
        let cpv = ColorPickerView()
        cpv.style = .square
        cpv.delegate = self
        return cpv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// MARK: ColorPickerViewDelegate

extension ClimbColorViewController : ColorPickerViewDelegate {

    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
}

