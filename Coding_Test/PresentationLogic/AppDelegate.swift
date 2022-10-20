//
//  AppDelegate.swift
//  Coding_Test
//
//  Created by mac on 2022-10-13.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties

    var window: UIWindow?
    
    //MARK: - Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarController = TabBarController()
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

