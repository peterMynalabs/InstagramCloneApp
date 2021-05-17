//
//  FollowUnfollowButton.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/12/21.
//

import Foundation
import UIKit

class FollowUnfollowButton: UIButton {

    var uuid = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        backgroundColor = UIColor(rgb: 0x3797EF)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleLabel?.textColor = UIColor(rgb: 0xFFFFFF)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func follow() {
        backgroundColor = UIColor(rgb: 0x3797EF)
        layer.borderColor = UIColor.clear.cgColor
        setTitleColor(.white, for: .normal)
        setTitle("Follow", for: .normal)
    }

    func unfollow() {
        backgroundColor = UIColor(rgb: 0xFFFFFF)
        setTitle("Following", for: .normal)
        setTitleColor(.black, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
}
