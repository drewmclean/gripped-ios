//
//  MenuViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit

enum MenuItemTyoe : Int {
    case home, profile, biometrics, climbingActivity
}

struct MenuItem {
    var type : MenuItemTyoe
    var title : String
    var image : UIImage
    var viewController : UIViewController
    
    init(type:MenuItemTyoe, title:String, image:UIImage, viewController:UIViewController) {
        self.type = type
        self.title = title
        self.image = image
        self.viewController = viewController
    }
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabelsStackView: UIStackView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    lazy var menuItems : [MenuItem] = {
        var items = [MenuItem]()
        var vcs = (UIApplication.shared.delegate as! AppDelegate).viewControllers
        var profileVC = vcs.profileViewController
        
//        var biometrics = vcs.
        items.append(MenuItem(type: .profile, title: "Profile", image: UIImage.contacts, viewController: profileVC))
//        items.append(MenuItem(type: .biometrics, title: "Biometrics", image: UIImage.healthBook, viewController: self.viewC
//        items.append(MenuItem(type: .climbs, title: "Climbing Activity", image: UIImage.climbing))
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        menuTableView.estimatedRowHeight = 60
        menuTableView.rowHeight = 60
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableViewHeightConstraint.constant = CGFloat(menuItems.count) * menuTableView.rowHeight

    }
    
    
    
}

extension MenuViewController : UITableViewDataSource {
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = menuItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as! MenuTableViewCell
        cell.imageView?.image = menuItem.image
        cell.textLabel?.text = menuItem.title
        return cell
    }
}

extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        revealController.show(menuItem.viewController, animated: true) { (finished : Bool) -> Void in
            
        }
    }
    
}

