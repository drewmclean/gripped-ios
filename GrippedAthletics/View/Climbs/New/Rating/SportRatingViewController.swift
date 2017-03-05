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
    var providers: [[StringRepresentable]] = [Ratings.NorthAmerica.ClassGrade.allValues, Ratings.NorthAmerica.SubGrade.signValues]
}


class SportRatingViewController: FormStackItemPickerViewController {
    
    var newClimbProvider : NewClimbFormFieldProvider? {
        return delegate?.stackProvider as? NewClimbFormFieldProvider
    }
    
    var selectedGradeIsModerate : Bool {
        let selectedGrade = provider.providers[0][pickerView.selectedRow(inComponent: 0)]
        guard let _ = Ratings.NorthAmerica.ClassGrade.allModerateGrades.first(where: { (grade: Ratings.NorthAmerica.ClassGrade) -> Bool in
            grade.rawValue == selectedGrade.rawValue
        }) else {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider = SportRatingComponentProvider()
        
        let defaultGrade = Ratings.NorthAmerica.ClassGrade.Five9
        let defaultSubGrade = Ratings.NorthAmerica.SubGrade.none
        
        selectedValue = SportRatingValue(components:[defaultGrade, defaultSubGrade])
        updateSelectedComponents(animated: false)
    }
    

}

extension SportRatingViewController {
    
    override func formattedTitle(forComponent component: Int, title: String) -> String {
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 60
        } else {
            return 50
        }
    }
    
}

extension SportRatingViewController {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            if selectedGradeIsModerate {
                provider.providers[1] = Ratings.NorthAmerica.SubGrade.signValues
                pickerView.reloadComponent(1)
                let newRow = min(pickerView.selectedRow(inComponent: 1), Ratings.NorthAmerica.SubGrade.signValues.count-1)
                pickerView.selectRow(newRow, inComponent: 1, animated: true)
            } else {
                provider.providers[1] = Ratings.NorthAmerica.SubGrade.allValues
                pickerView.reloadComponent(1)
            }
            
        }
        
        var selectedComponents = [StringRepresentable]()
        for (componentIndex, componentProvider) in provider.providers.enumerated() {
            let selectedRow = pickerView.selectedRow(inComponent: componentIndex)
            let selectedComponent = componentProvider[selectedRow]
            selectedComponents.append(selectedComponent)
        }
        selectedValue = SportRatingValue(components: selectedComponents)
    }
    
    override func formattedTextInputValue(sourceValue: String) -> String {
        return sourceValue.capitalized
    }
}

