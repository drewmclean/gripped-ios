//
//  ClimbListTableViewCell.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 2/12/17.
//  Copyright © 2017 GrippedAthletics. All rights reserved.
//

import UIKit

class ClimbListTableViewCell: UITableViewCell {
    
    static var cellId = "ClimbListTableViewCellID"
    
    @IBOutlet weak var climbImageView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var climb : Climb! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI() {
        nameLabel.text = climb.name
        venueLabel.text = climb.venue?.capitalized
        gradeLabel.text = climb.rating
        descriptionLabel.text = climb.description
    }

}
