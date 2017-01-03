//
//  MenuViewController.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
    @IBOutlet weak var signOutButton: UIButton!
    
    var profile : UserProfile!
    
    var selectedIndex : IndexPath = IndexPath(row: 0, section: 0)
    
    var selectedMenuItem : MenuItem {
        return menuItems[selectedIndex.row]
    }
    
    lazy var menuItems : [MenuItem] = {
        var items = [MenuItem]()
        var vcs = (UIApplication.shared.delegate as! AppDelegate).viewControllers
        var homeVC = vcs.homeNavController
        var profileVC = vcs.profileNavController
        var activityVC = vcs.activityNavController
        
        items.append(MenuItem(type: .home, title: "Home", image: UIImage.home, viewController: homeVC))
        items.append(MenuItem(type: .profile, title: "Profile", image: UIImage.contacts, viewController: profileVC))
//        items.append(MenuItem(type: .biometrics, title: "Biometrics", image: UIImage.healthBook, viewController: self.viewC
        items.append(MenuItem(type: .climbingActivity, title: "Activity", image: UIImage.climbing, viewController: activityVC))
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        menuTableView.backgroundColor = UIColor.black
        menuTableView.separatorColor = UIColor.gray
        menuTableView.estimatedRowHeight = 60
        menuTableView.rowHeight = 60
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableViewHeightConstraint.constant = CGFloat(menuItems.count) * menuTableView.rowHeight
        menuTableView.selectRow(at: selectedIndex, animated: false, scrollPosition: .none)
        
        signOutButton.setTitleColor(UIColor.gray, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProfile()
    }
    
    func loadProfile() {
        let profileRef = UserProfile.objectRef.child(auth.currentUser!.uid)
        profileRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            self.profile = UserProfile(snapshot: snapshot)
            self.updateProfileUI()
        }
    }
    
    func updateProfileUI() {
        
    }
    
    // MARK: Actions
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        revealController.resignPresentationModeEntirely(true, animated: true) { (done:Bool) in
            self.auth.signOut()
        }
    }
    
}

extension MenuViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menuItem = menuItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier) as! MenuTableViewCell
        cell.iconImage = menuItem.image
        cell.textLabel?.text = menuItem.title
        return cell
    }
}

extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let menuItem = menuItems[indexPath.row]
        revealController.show(menuItem.viewController, animated: true) { (finished : Bool) -> Void in
            
        }
    }
    
}

class MenuTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "MenuTableViewCellID"
    
    var iconImage : UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            imageView?.image = iconImage?.maskWithColor(color: UIColor.black)
            textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            textLabel?.textColor = UIColor.black
        } else {
            imageView?.image = iconImage?.maskWithColor(color: UIColor.lightGray)
            textLabel?.font = UIFont.systemFont(ofSize: 24)
            textLabel?.textColor = UIColor.lightGray
        }
    }
    
}

