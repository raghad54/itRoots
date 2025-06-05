//
//  SettingsViewController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var changeLanguageButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        updateLanguageButtonTitle()
        logoutButton.setTitle("logout".localized(), for: .normal)
    }
    
    // Toggle language directly without alert
    @IBAction func changeLanguageTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Language", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            LanguageManager.shared.changeLanguageAppWide(to: "en")
        }))
        alert.addAction(UIAlertAction(title: "Arabic", style: .default, handler: { _ in
            LanguageManager.shared.changeLanguageAppWide(to: "ar")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }
    
    func updateLanguageButtonTitle() {
        let currentLang = LanguageManager.shared.currentLanguage
        let buttonTitle = currentLang == "en" ? "change_to_arabic".localized() : "change_to_english".localized()
        changeLanguageButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
                UserDefaults.standard.synchronize()
            }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        let nav = UINavigationController(rootViewController: loginVC)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: nil)
    }
}
