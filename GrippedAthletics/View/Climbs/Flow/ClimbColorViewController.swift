//
//  RouteColorViewController.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 2/8/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit
import IGColorPicker

class ClimbColorViewController: FormStackItemViewController {
    
    lazy var colorView : UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.75
        view.layer.cornerRadius = 4
        self.stackView.addArrangedSubview(view)
        return view
    }()
    
    lazy var colorPickerView : ColorPickerView = {
        let cpv = ColorPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        cpv.style = .square
        cpv.delegate = self
        return cpv
    }()
    
    override var inputView: UIView? {
        return colorPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        colorView.snp.updateConstraints { (make: ConstraintMaker) in
            make.width.equalTo(160)
            make.height.equalTo(160)
        }
        
    }
    
}

extension ClimbColorViewController : FormInputProvider {
    
    var inputValue : String? {
        guard let selectedIndex = colorPickerView.indexOfSelectedColor else {
            return nil
        }
        return colorPickerView.colors[selectedIndex].toHexString
    }
    
}

// MARK: ColorPickerViewDelegate

extension ClimbColorViewController : ColorPickerViewDelegate {
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        let pickedColor = colorPickerView.colors[indexPath.row]
        formField.value = pickedColor.toHexString
        colorView.backgroundColor = pickedColor
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
}

