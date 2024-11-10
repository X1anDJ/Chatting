//
//  AppDelegate.swift
//  WA8_<Xian>_<5969>
//
//  Created by Dajun Xian on 2024/11/9.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let navController = UINavigationController(rootViewController: LoginViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}
