//
//  AppDelegate.swift
//  MLSearch
//
//  Created by Nicolas Bolzan on 18/05/2021.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: SearchTableViewController())
        window?.makeKeyAndVisible()

        return true
    }

}

