//
//  InteractableProfilePhoto.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 22.01.2021.
//

import Foundation
import UIKit

class InteractableProfilePhoto: UIView {
    
    var button: UIButton?
    var PImage = UIImage(named: "back")
    override init(frame: CGRect) {
        super.init(frame: frame)
        profilePhoto.frame = bounds
        setupProfilePhoto()
        addSubview(profilePhoto)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProfilePhoto() {
        profilePhoto.image = PImage
        profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2
        //refactor
        button = UIButton(frame: frame)
        button?.backgroundColor = .clear
        guard let buttonSubView = button else {
            fatalError()
        }
        profilePhoto.addSubview(buttonSubView)
        profilePhoto.isUserInteractionEnabled = true
    }
    
    let profilePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
}
