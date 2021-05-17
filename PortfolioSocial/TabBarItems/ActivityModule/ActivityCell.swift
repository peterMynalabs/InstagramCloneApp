//
//  ActivityCell.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/19/21.
//

import Foundation
import UIKit
class ActivityCell: UITableViewCell {
    
    var imagePreview = UIImageView()
    var informationLabel = UsernameButton()
    var profileImage = UIImageView()
    var otherText = UILabel()
    var followButton = FollowUnfollowButton()
    var isFollowNotification = false
    var post: Post?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imagePreview)
        contentView.addSubview(informationLabel)
        addSubview(profileImage)
        addSubview(otherText)
        contentView.addSubview(followButton)
    }
    
    func setupProfileImage(with url: String) {
        profileImage.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
        profileImage.layer.cornerRadius = 15
        profileImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "defaultProfilePhoto"), options: .highPriority, completed: nil)
    }
    
    func setupImageView(with url: URL) {
        imagePreview.frame = CGRect(x: self.frame.width - 55, y: 5, width: 40, height: 40)
        imagePreview.sd_setImage(with: url, completed: nil)

    }
    func setupInformationLabel(with username: String) {
        informationLabel.username = username
        informationLabel.setupButton()
        informationLabel.sizeToFit()
        informationLabel.frame = CGRect(x: 50, y: 0, width: informationLabel.frame.width, height: 50)
        setupOtherText()

    }
    
    func setupFollowButton(with uuid: String, isFollowed: Bool) {
        followButton.uuid = uuid
        if isFollowed {
            self.followButton.unfollow()
        } else {
            self.followButton.follow()
        }
        self.followButton.frame = CGRect(x: self.frame.width - 110, y: 7.5, width: 100, height: 35)
    }
    
    func setupOtherText() {
        otherText.frame = CGRect(x: 50 + informationLabel.frame.width, y: 0, width: 200, height: 50)
        if isFollowNotification {
            otherText.text = " followed you"
        } else {
            otherText.text = " liked your photo"
        }
        otherText.textColor = .black
        otherText.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
