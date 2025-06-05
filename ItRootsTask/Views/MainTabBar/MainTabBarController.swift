//
//  MainTabBarController.swift
//  ItRootsTask
//
//  Created by Raghad's Mac on 04/06/2025.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        settingButtonTapped()
    }
    
    
    func settingButtonTapped() {
        
    let settingsButton = UIBarButtonItem(
           image: UIImage(systemName: "gearshape"),
           style: .plain,
           target: self,
           action: #selector(openSettings)
       )
       navigationItem.rightBarButtonItem = settingsButton
    }
    
    func setupTabs() {
        let Homestoryboard = UIStoryboard(name: "HomeViewController", bundle: nil)

        let homeVC = Homestoryboard.instantiateViewController(identifier: "HomeViewController")
        homeVC.tabBarItem = UITabBarItem(title: "Home".localized(), image: UIImage(systemName: "house"), tag: 0)

        let mapstoryboard = UIStoryboard(name: "MapViewController", bundle: nil)
        let mapVC = mapstoryboard.instantiateViewController(identifier: "MapViewController")
        mapVC.tabBarItem = UITabBarItem(title: "Map".localized(), image: UIImage(systemName: "map"), tag: 1)
        
        let poststoryboard = UIStoryboard(name: "PostsViewController", bundle: nil)
        let postsVC = poststoryboard.instantiateViewController(identifier: "PostsViewController")
        postsVC.tabBarItem = UITabBarItem(title: "Posts".localized(), image: UIImage(systemName: "doc.text"), tag: 2)

        viewControllers = [homeVC, mapVC, postsVC]
    }
    
    @objc func openSettings() {
    let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
    if let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
        let navVC = UINavigationController(rootViewController: settingsVC)
        navVC.modalPresentationStyle = .formSheet
        present(navVC, animated: true, completion: nil)
    }
    }
}
