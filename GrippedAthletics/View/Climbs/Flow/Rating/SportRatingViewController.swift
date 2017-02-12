//
//  SportRatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class SportRatingValue : ComponentsValue, StringRepresentableSource {
    
    convenience init(rawValue : String) {
        self.init()
        
        // Parse the string into components
        print("Sport Value: \(rawValue)")
    }
    
}

struct SportRatingComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] {
        return [Ratings.NorthAmerica.ClassGrade.allValues, Ratings.NorthAmerica.SubGrade.allValues]
    }
}


class SportRatingViewController: FormStackItemPickerViewController {
    
    var newClimbProvider : NewClimbFormFieldProvider? {
        return delegate?.stackProvider as? NewClimbFormFieldProvider
    }
    
    override var nextFormItem: FormStackItem? {
        return newClimbProvider?.climbVenue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = SportRatingComponentProvider()
        
        let defaultGrade = Ratings.NorthAmerica.ClassGrade.Five9
        let defaultSubGrade = Ratings.NorthAmerica.SubGrade.none
        
        selectedValue = SportRatingValue(components:[defaultGrade, defaultSubGrade])
    }

}

extension SportRatingViewController {
    
    override func formattedTitle(forComponent component: Int, title: String) -> String {
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40
    }
    
}

extension SportRatingViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedComponents = [StringRepresentable]()
        for (componentIndex, componentProvider) in provider.providers.enumerated() {
            let selectedRow = pickerView.selectedRow(inComponent: componentIndex)
            let selectedComponent = componentProvider[selectedRow]
            selectedComponents.append(selectedComponent)
        }
        selectedValue = SportRatingValue(components: selectedComponents)
    }
    
}

