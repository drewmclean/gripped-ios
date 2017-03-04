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
    
    public var selectedColor : UIColor?
    
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
        
        colorPickerView.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1),
                                  #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1),
                                  #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
                                  #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
        
        colorPickerView(colorPickerView, didSelectItemAt: IndexPath(item: 2, section: 0))
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
