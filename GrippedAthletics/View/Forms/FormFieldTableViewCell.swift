//
//  FormFieldTableViewCell.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 1/3/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class FormFieldTableViewCell: UITableViewCell {
    
    static let cellId = "FormFieldTableViewCellID"
    
    @IBOutlet weak var stackView : UIStackView!
    @IBOutlet weak var titleStackView : UIStackView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var unitLabel : UILabel!
    @IBOutlet weak var textField : UITextField!
    
    var formField : FormField! {
        didSet {
            updateFieldUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
 
    }
    
    func updateFieldUI() {
        
    }

}
