//
//  AppDelegate.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 06.01.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import AVKit
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        setRootViewController()
        askForPermissions()
        setupAppearance()
        return true
    }

    func setRootViewController() {
        let defaults = UserDefaults.standard

        var isFirstTime = true
        if let _ = Auth.auth().currentUser,
           let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            User.setCurrent(user)
            isFirstTime = false
        } else {
            isFirstTime = true
        }

        window?.rootViewController = TabBarWireframe.init(isFirstTime: isFirstTime).viewController
        window?.makeKeyAndVisible()
    }

    func askForPermissions() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    print("good")
                } else {
                    print("bad")
                }
            })
        }
    }

    func setupAppearance() {
        if #available(iOS 13.0, *) {
            UITabBar.appearance().barTintColor = UIColor.white
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(rgb: 0xFAFAFA)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.shadowColor = .clear
            UINavigationBar.appearance().tintColor = UIColor(rgb: 0x262626)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
    }
}
