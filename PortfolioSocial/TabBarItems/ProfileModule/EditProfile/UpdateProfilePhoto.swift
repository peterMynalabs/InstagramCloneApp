//
//  UpdateProfilePhoto.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 2/10/21.
//

import Foundation
import UIKit

class UpdateProfilePhotoViewController: UIViewController {
    
    let popupBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.definesPresentationContext = true
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(popupBox)
        popupBox.heightAnchor.constraint(equalToConstant: 200).isActive = true
        popupBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBox.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

