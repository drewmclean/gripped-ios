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
    
    @IBOutlet weak var climbColorView: UIView!
//    @IBOutlet weak var climbImageView: UIImageView!
//    @IBOutlet weak var climbImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelsStackView: UIStackView!
    
    var climb : Climb! {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        labelsStackView.layoutMargins = UIEdgeInsets(top: 2, left: 0, bottom: 4, right: 4)
//        climbImageView.layer.borderColor = UIColor.gray.cgColor
//        climbImageView.layer.borderWidth = 0.5
//        climbImageView.backgroundColor = UIColor.lightGray
    }
    
    func updateUI() {
        if let hexColor = climb.color {
            let color = UIColor(hexString: hexColor)
            climbColorView.backgroundColor = color
        } else {
            climbColorView.backgroundColor = UIColor.gray
        }
//        climbImageView.isHidden = true
        nameLabel.text = climb.name
        gradeLabel.text = climb.rating
        venueLabel.text = climb.venue
        typeLabel.text = climb.type
        descriptionLabel.text = climb.description
    }

}
