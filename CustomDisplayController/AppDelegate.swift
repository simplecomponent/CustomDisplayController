//
//  AppDelegate.swift
//  CustomDisplayController
//
//  Created by apple on 2019/12/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = ViewController()
        let nav = UINavigationController(rootViewController: root)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }


}

