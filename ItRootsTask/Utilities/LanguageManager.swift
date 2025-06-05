//
//  LocalizationManager.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 03/06/2025.
//

import Foundation
import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    private init() {}
    

    var currentLanguage: String {
        get {
            UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.preferredLanguages.first ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "AppLanguage")
            UserDefaults.standard.set([newValue], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            Bundle.setLanguage(newValue)
        }
    }

    func setSemanticDirection() {
        let semantic: UISemanticContentAttribute = currentLanguage == "ar" ? .unspecified : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = semantic
    }

    func applyLanguageToCurrentScreen() {
        currentLanguage = currentLanguage == "en" ? "ar" : "en"
        setSemanticDirection()
        NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
    }

    // Full app restart (for Settings)
    func changeLanguageAppWide(to newLang: String) {
        currentLanguage = newLang
        setSemanticDirection()

        guard let window = UIApplication.shared.windows.first else { return }

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let storyboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
        let nav = UINavigationController(rootViewController: loginVC)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        

        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil)
    }
}
