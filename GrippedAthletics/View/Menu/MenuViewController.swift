//
//  MenuViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

enum MenuOption {
    case dashboard, viewActivities, createActivity
}

protocol MenuViewControllerDelegate {
    func menuDidChange(menuOption : MenuOption)
}

enum MenuItemTyoe : Int {
    case profile, biometrics, climbs
}

struct MenuItem {
    var itemType : MenuItemTyoe
    var label : String
    var icon : UIImage
    
    init(type:MenuItemTyoe, label:String, icon:UIImage) {
        self.itemType = type
        self.label = label
        self.icon = icon
    }
}

class MenuViewController: UIViewController {
    
    var delegate : MenuViewControllerDelegate?
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabelsStackView: UIStackView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    lazy var menuItems : [MenuItem] = {
        let items = [MenuItem]()
        items.append(MenuItem(type: .profile, label: "Profile", icon: UIImage.profile)
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        menuTableView.estimatedRowHeight = 44
        menuTableView.rowHeight = 44
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    
}

extension MenuViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
}

extension MenuViewController : UITableViewDelegate {
    
}

