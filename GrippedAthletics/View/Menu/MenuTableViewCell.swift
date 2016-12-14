//
//  MenuTableViewCell.swift
//  GrippedAthletics
//
//  Created by Andrew Mclean on 12/13/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MenuTableViewCellID"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel?.textColor = UIColor.lightGray
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
