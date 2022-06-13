//
//  AppDelegate.swift
//  StockManager
//
//  Created by Chavalit Vanasapdamrong on 8/4/2565 BE.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppFont.registerFonts
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundImage = UIImage(color: .zortBranding)
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSukhumvitTadmai(ofSize: 20)
            ]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
        let navigation = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigation)
        window = UIWindow()
        window?.rootViewController = navigation
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }

}

