//
//  UsenameButton.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/4/21.
//

import Foundation
import UIKit


class UsernameButton: UIButton {
    
    var username: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, username: String) {
        self.init(frame: frame)
        self.username = username
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        //contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setTitle(username!, for: .normal)
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        setTitleColor(UIColor.black, for: .normal)
    }
    
}
