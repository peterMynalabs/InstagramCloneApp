//
//  TabBarController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 06.01.2021.
//
import UIKit
import Foundation

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    let homeController = HomeFeedWireframe.init()
    let userSearchController = SearchViewWireframe.init()
    let addPostController = AddPostWireframe.init()
    let activityController = ActivityWireframe.init()
    let profileController = ProfileScreenWireframe.init(uuid: "")

    override func viewDidLoad() {
        delegate = self
        tabBar.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeController.viewController.title = "Home"
        addPostController.viewController.title = "Post"
        activityController.viewController.title = "Liked"
        profileController.viewController.title = "Profile"
        userSearchController.viewController.title = "Search"

        let controllers = [homeController.viewController,
                           userSearchController.viewController,
                           addPostController.viewController,
                           activityController.viewController,
                           profileController.viewController]
        viewControllers = controllers
        selectedIndex = 4
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true
    }
}
