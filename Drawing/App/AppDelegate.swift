//
//  AppDelegate.swift
//  Drawing
//
//  Created by Pawan  on 17/01/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DrawingViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

