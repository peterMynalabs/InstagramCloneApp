//
//  AppDelegate.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 06.01.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        let wireframeNavigationController = RootNavigationController()
        FirebaseApp.configure()

        
        if let _ = Auth.auth().currentUser,
                  let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
                  let user = try? JSONDecoder().decode(User.self, from: userData) {
                   User.setCurrent(user)
            wireframeNavigationController.setRootWireframe(TabBarWireframe.init(), animated: false)
        } else {
            wireframeNavigationController.setRootWireframe( LoginWireframe.init(), animated: false)
        }
        
        window?.rootViewController = wireframeNavigationController
        window?.makeKeyAndVisible()
       

       
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

            UINavigationBar.appearance().tintColor = .red
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = .purple
            UINavigationBar.appearance().isTranslucent = false
        }
        
       

        return true
    }

 


}

