//
//  AppDelegate.swift
//  GrippedAthletics
//
//  Created by Andrew McLean on 10/22/16.
//  Copyright © 2016 GrippedAthletics. All rights reserved.
//

import UIKit
import PKRevealController
import Firebase
import CocoaLumberjack
import FacebookCore.Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var viewControllers = ViewControllers()
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        
        FIRApp.configure()
        
        window?.backgroundColor = UIColor.purple
        
        setupRootViewController()
        showAuthIfNeeded()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
     
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        DataStore.instance.saveContext()
    }

}


// MARK: View Management
extension AppDelegate : PKRevealing {
    
    func setupRootViewController() {
        window = UIWindow()
        
        let revealController = PKRevealController(frontViewController: viewControllers.homeViewController, leftViewController: viewControllers.menuViewController)!
        revealController.delegate = self
        
        window?.rootViewController = revealController
        window?.makeKeyAndVisible()
    }
    
    func showAuthIfNeeded() {
        if !Auth.instance.isAuthenticated {
            window?.rootViewController?.present(viewControllers.authPromptViewController, animated: false, completion: nil)
        }
    }
}

struct ViewControllers {
    private let storyboard = UIStoryboard.main
    
    lazy var authPromptViewController : AuthPromptViewController = {
        let vc = UIStoryboard.auth.instantiateInitialViewController() as! AuthPromptViewController
        
        return vc
    }()
    
    lazy var menuViewController : MenuViewController = {
        let vc = self.storyboard.instantiateViewController(withClass: MenuViewController.self) as! MenuViewController
        
        return vc
    }()
    
    lazy var profileViewController : ProfileViewController = {
        let vc = self.storyboard.instantiateViewController(withClass: ProfileViewController.self) as! ProfileViewController
        
        return vc
    }()
    
    lazy var homeViewController : HomeViewController = {
        let vc = self.storyboard.instantiateViewController(withClass: HomeViewController.self) as! HomeViewController
        let nav = UINavigationController(rootViewController: vc)
        return vc
    }()
}

