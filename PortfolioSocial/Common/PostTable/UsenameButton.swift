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
        setTitle(username!, for: .normal)
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        setTitleColor(UIColor.black, for: .normal)
    }
}
