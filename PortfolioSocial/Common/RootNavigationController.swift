//
//  rootNavigationController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 14.01.2021.
//

import Foundation
import UIKit

class RootNavigationController: UINavigationController {
    override func viewWillLayoutSubviews() {
        //setupNavigationBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func setupNavigationBar()  {
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 90 ))
        self.view.addSubview(navigationBar)
        
        let navigationItem = UINavigationItem(title: self.topViewController?.title ?? "Something is Wrong")
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.prefersLargeTitles = true
        navigationBar.backgroundColor = .clear
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}
