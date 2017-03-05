//
//  FormStackItemSliderViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 3/4/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit
import SnapKit

class FormStackItemSliderViewController: FormStackItemTextFieldViewController {
    
    var minimumValueDescriptor : String?
    var maximumValueDescriptor : String?
    
    lazy var sliderInputView : SliderInputView = SliderInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderInputView.leftLabel.text = minimumValueDescriptor
        sliderInputView.rightLabel.text = maximumValueDescriptor
        sliderInputView.slider.addTarget(self, action: #selector(FormStackItemSliderViewController.sliderValueChanged(slider:)), for: .valueChanged)
        
        textField.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightMedium)
        textField.tintColor = UIColor.clear
        textField.inputView = sliderInputView
        sliderInputView.setNeedsUpdateConstraints()
        sliderInputView.updateConstraintsIfNeeded()
        
    }
    
    func sliderValueChanged(slider : UISlider) {
        textField.text = "\(slider.value)"
    }
    
}

class SliderInputView : UIInputView {
    
    lazy var sliderStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        self.addSubview(sv)
        return sv
    }()
    
    lazy var labelStackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fill
        self.sliderStackView.addArrangedSubview(sv)
        return sv
    }()
    
    lazy var slider : UISlider = {
        let s = UISlider()
        s.minimumValue = 0
        s.maximumValue = 10
        self.sliderStackView.insertArrangedSubview(s, at: 0)
        return s
    }()
    
    lazy var leftLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        self.labelStackView.insertArrangedSubview(l, at: 0)
        return l
    }()
    
    lazy var rightLabel : UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        self.labelStackView.addArrangedSubview(l)
        return l
    }()
    
    override func updateConstraints() {
        super.updateConstraints()
        
        sliderStackView.snp.updateConstraints { (make) in
            make.left.equalTo(self).offset(30)
            make.right.equalTo(self).offset(-30)
            make.centerY.equalTo(self)
        }
        
    }
}

