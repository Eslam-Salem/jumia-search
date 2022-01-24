//
//  AppDelegate.swift
//  PTC_IOS_TEST
//
//  Created by Tiago Valente on 27/06/2019.
//  Copyright © 2019 Jumia. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureIQKeyboardManager()
        setDefaultScreen()
        return true
    }

    private func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    private func setDefaultScreen() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mainViewCtrl = SplashScreenViewController()
        window?.rootViewController = mainViewCtrl
    }
}

