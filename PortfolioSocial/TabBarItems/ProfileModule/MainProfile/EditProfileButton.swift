//
//  EditProfileButton.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 22.01.2021.
//

import Foundation
import UIKit


class EditProfileButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDesign()
        self.clipsToBounds = true
    }
    
    func addDesign() {
        layer.borderWidth = 1
        backgroundColor = .white
        layer.cornerRadius = 6
        layer.borderColor = UIColor(rgb: 0xDCDCDD).cgColor
        setTitle("Edit Profile", for: .normal)
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
