//
//  AppLaunchManager.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import UIKit

class AppLaunchManager {
    static let shared = AppLaunchManager()
    private init() {}

    func configureInitialViewController(for window: UIWindow?) {
        // Set app language direction
        LanguageManager.shared.setSemanticDirection()
        Bundle.setLanguage(LanguageManager.shared.currentLanguage)

        guard let window = window else { return }

        let userDefaults = UserDefaults.standard
        let isLoggedIn = userDefaults.bool(forKey: "isLoggedIn")
        let hasLaunchedBefore = userDefaults.bool(forKey: "hasLaunchedBefore")

        let initialVC: UIViewController

        if !hasLaunchedBefore {
            // First launch → SignUp
            let signUpStoryboard = UIStoryboard(name: "SignUpView", bundle: nil)
            initialVC = signUpStoryboard.instantiateViewController(withIdentifier: "SignUpView")
            userDefaults.set(true, forKey: "hasLaunchedBefore")
            userDefaults.synchronize()
        } else if isLoggedIn {
            // Already logged in → MainTabBar
            let mainStoryboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
            initialVC = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController")
        } else {
            // Not logged in → Login
            let loginStoryboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            initialVC = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
        }

        let navController = UINavigationController(rootViewController: initialVC)
        navController.view.semanticContentAttribute = LanguageManager.shared.currentLanguage == "ar" ? .forceRightToLeft : .forceLeftToRight

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
