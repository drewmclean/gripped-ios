//
//  BiometricsListTableViewCell.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class BiometricsListTableViewCell: UITableViewCell {
    
    static let cellId = "BiometricsListTableViewCellID"
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heightTitleLabel: UILabel!
    @IBOutlet weak var heightValueLabel: UILabel!
    
    @IBOutlet weak var weightTitleLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    
    @IBOutlet weak var bodyCompTitleLabel: UILabel!
    @IBOutlet weak var bodyCompValueLabel: UILabel!
    
    @IBOutlet weak var apeTitleLabel: UILabel!
    @IBOutlet weak var apeValueLabel: UILabel!
    
    @IBOutlet weak var faLengthTitleLabel: UILabel!
    @IBOutlet weak var faLengthValueLabel: UILabel!
    
    @IBOutlet weak var faCircTitleLabel: UILabel!
    @IBOutlet weak var faCircValueLabel: UILabel!
    
    var biometrics : Biometrics! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    func updateUI() {
        
        dateLabel.text = biometrics?.createdAt?.shortString()
        heightValueLabel.text = biometrics?.heightWithUnits
        weightValueLabel.text = biometrics?.weightWithUnits
        bodyCompValueLabel.text = biometrics?.bodyCompositionWithUnits
        apeValueLabel.text = biometrics?.apeIndexWithUnits
        faLengthValueLabel.text = biometrics?.forearmLengthWithUnits
        faCircValueLabel.text = biometrics?.forearmCircumferenceWithUnits
    }
}
