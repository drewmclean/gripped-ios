//
//  RatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

protocol PickerComponentProvider {
    var providers : [[StringRepresentable]] { get }
}

class ComponentsValue : ComponentStringRepresentable {
    var components : [StringRepresentable] = [StringRepresentable]()
    var rawValue : String {
        return "\(components)"
    }
    convenience init(components : [StringRepresentable]) {
        self.init()
        self.components = components
    }
}

class FormStackItemPickerViewController: FormStackItemTextFieldViewController {
    
    var provider : PickerComponentProvider! {
        didSet {
            
        }
    }
    
    var selectedValue : ComponentsValue? {
        didSet {
            formField.value = selectedValue?.rawValue ?? ""
            updateSelectedComponents(animated: true)
            updateUI()
        }
    }
    
    lazy var pickerView : UIPickerView = {
        let pv = UIPickerView()
        pv.delegate = self
        pv.dataSource = self
        return pv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.inputView = pickerView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func updateSelectedComponents(animated : Bool) {
        if let selection = selectedValue {
            for (index, value) in  selection.components.enumerated() {
                let componentValues = provider.providers[index]
                
                guard let rowToSelect = componentValues.index(where: { (component: StringRepresentable) -> Bool in
                    return value.rawValue == component.rawValue
                }) else {
                    return
                }
                pickerView.selectRow(rowToSelect, inComponent: index, animated: animated)
            }
        }
    }
    
    override func updateUI() {
        super.updateUI()
        
    }
}

extension FormStackItemPickerViewController : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return provider.providers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let component = provider.providers[component]
        return component.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let component = provider.providers[component]
        return component[row].rawValue.capitalized
    }
    
}

extension FormStackItemPickerViewController {
    
    override var inputValue : String? {
        return selectedValue?.rawValue
    }
    
}

extension FormStackItemPickerViewController : UIPickerViewDelegate {
    
    
    
}
