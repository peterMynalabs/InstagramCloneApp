//
//  UserTableView.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/12/21.
//

import Foundation
import UIKit

class UsersTableViewCell: UITableViewCell {
    static var identifier: String = "UserTableViewCell"
    var newImageView = UIImageView()
    var usernameLabel = UILabel()
    var nameLabel = UILabel()
    var backgroundViewForImage = UIView()
    var followUnfollowButton = FollowUnfollowButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backgroundViewForImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
    }
}
