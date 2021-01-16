//
//  AppDelegate.swift
//  Repositories
//
//  Created by Amr Salman on 1/13/21.
//

import UIKit
import App_iOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let injectionContainer = AppDependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainVC = injectionContainer.makeMainViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        return true
    }

}

