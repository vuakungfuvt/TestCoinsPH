//
//  AppDelegate.swift
//  TestCoinsPH
//
//  Created by thanhhm on 5/27/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainWalletViewController = MainWalletViewController.create()
        let navigationViewController = UINavigationController(rootViewController: mainWalletViewController)
        self.window?.rootViewController = navigationViewController
        self.window?.makeKeyAndVisible()
        return true
    }



}

