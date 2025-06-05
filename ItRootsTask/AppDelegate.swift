//
//  AppDelegate.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        LanguageManager.shared.setSemanticDirection()
        Bundle.setLanguage(LanguageManager.shared.currentLanguage)

        window = UIWindow(frame: UIScreen.main.bounds)

        let userDefaults = UserDefaults.standard
        let hasLaunchedBefore = userDefaults.bool(forKey: "hasLaunchedBefore")
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")

        let initialVC: UIViewController

        if !hasLaunchedBefore {
            let storyboard = UIStoryboard(name: "SignUpView", bundle: nil)
            initialVC = storyboard.instantiateViewController(withIdentifier: "SignUpView")
            userDefaults.set(true, forKey: "hasLaunchedBefore")
            userDefaults.synchronize()
        } else if isLoggedIn {
            let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
            initialVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        } else {
            let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            initialVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        }

        let navController = UINavigationController(rootViewController: initialVC)
        navController.view.semanticContentAttribute = LanguageManager.shared.currentLanguage == "ar" ? .forceRightToLeft : .forceLeftToRight

        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}
