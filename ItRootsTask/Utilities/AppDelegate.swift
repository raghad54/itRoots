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

        window = UIWindow(frame: UIScreen.main.bounds)
        AppLaunchManager.shared.configureInitialViewController(for: window)
        return true
    }
}
