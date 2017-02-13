//
//  TradRatingViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/5/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

final class TradRatingValue : ComponentsValue, StringRepresentableSource {
    
    override var rawValue : String {
        return "\(components[0].rawValue)\(components[1].rawValue) \(components[2].rawValue)"
    }
    
    convenience init(rawValue : String) {
        self.init()
        
    }
    
}

struct TradRatingComponentProvider : PickerComponentProvider {
    var providers: [[StringRepresentable]] = [Ratings.NorthAmerica.ClassGrade.allValues, Ratings.NorthAmerica.SubGrade.signValues, Ratings.NorthAmerica.DangerGrade.allValues]
}

class TradRatingViewController: FormStackItemPickerViewController {

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
        
        provider = TradRatingComponentProvider()
        
        let defaultGrade = Ratings.NorthAmerica.ClassGrade.Five9
        let defaultSubGrade = Ratings.NorthAmerica.SubGrade.none
        let defaultDanger = Ratings.NorthAmerica.DangerGrade.none
        
        selectedValue = TradRatingValue(components:[defaultGrade, defaultSubGrade, defaultDanger])
        updateSelectedComponents(animated: false)
    }

}

extension TradRatingViewController {
    
    override func formattedTitle(forComponent component: Int, title: String) -> String {
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 60
        } else if component == 1 {
            return 50
        } else {
            return 50
        }
    }
    
}

extension TradRatingViewController {
    
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
        selectedValue = TradRatingValue(components: selectedComponents)
    }
}
