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
    
    @IBOutlet weak var climbImageView: UIImageView!
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
        
        climbImageView.layer.cornerRadius = 4.0
        climbImageView.layer.borderColor = UIColor.gray.cgColor
        climbImageView.layer.borderWidth = 0.75
    }
    
    func updateUI() {
        if let hexColor = climb.color {
            let color = UIColor(hexString: hexColor)
            climbImageView.backgroundColor = color
        }
        nameLabel.text = climb.name
        venueLabel.text = climb.venue?.capitalized
        gradeLabel.text = climb.rating
        descriptionLabel.text = climb.description
    }

}
