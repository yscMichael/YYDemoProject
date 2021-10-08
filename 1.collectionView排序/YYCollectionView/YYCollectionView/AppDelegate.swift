//
//  AppDelegate.swift
//  YYCollectionView
//
//  Created by 杨世川 on 2021/9/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = YYMainViewController.init()
        self.window?.makeKeyAndVisible()
        return true
    }
}

