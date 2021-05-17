//
//  PostCollectionviewParrallaxHeader.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/16/21.
//

import Foundation
import UIKit
import SDWebImage

protocol PostCollectionViewParrallaxHeaderDelegate: class {
    func pressedEdit()
    func pressedFollow(with username: String, isFollowing: Bool)
}

class PostCollectionViewParrallaxHeader: UICollectionReusableView {

    var editProfileButton = EditProfileButton()
    var userInformationView = UserInformationStack()
    var userStatisticsStack = UserStatisticContainerView()
    var profilePhoto = UIImageView()
    var followButton = FollowUnfollowButton()
    var pinnableSeperatorView = UIView()
    weak var parrallaxDelegate: PostCollectionViewParrallaxHeaderDelegate?
    static let Kind = "StickyHeaderLayoutAttributesKind"
    static let reuseIdentifierHeader = "header"

    var onRefresh : (() -> Void)?
    var onCancel : (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        backgroundColor = UIColor(rgb: 0xFAFAFA)
        userStatisticsStack = UserStatisticContainerView(frame: .zero, stats: nil)
        addSubview(userStatisticsStack)
        userStatisticsStack.translatesAutoresizingMaskIntoConstraints = false
        userStatisticsStack.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        userStatisticsStack.leftAnchor.constraint(equalTo: rightAnchor, constant: -266.5).isActive = true
        userStatisticsStack.widthAnchor.constraint(equalToConstant: 225.5).isActive = true
        userStatisticsStack.heightAnchor.constraint(equalToConstant: 32).isActive = true
        setupProfilePhoto()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupProfilePhoto() {
        profilePhoto.image = UIImage(named: "back")?.withRoundedCorners(radius: profilePhoto.frame.width / 2)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2
        profilePhoto.layer.masksToBounds = true
        profilePhoto.clipsToBounds = true
        profilePhoto.isUserInteractionEnabled = true
        addSubview(profilePhoto)
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        profilePhoto.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        profilePhoto.widthAnchor.constraint(equalToConstant: 95).isActive = true
        profilePhoto.heightAnchor.constraint(equalToConstant: 95).isActive = true
    }

    func updateProfileImage(with image: String) {
        profilePhoto.sd_setImage(with: URL(string: image),
                                 placeholderImage: UIImage(named: "defaultProfilePhoto"),
                                 options: .highPriority,
                                 completed: nil)
    }

    func setupUserStatisticView(with info: UserStatistics) {
        userStatisticsStack.removeFromSuperview()
        userStatisticsStack = UserStatisticContainerView(frame: .zero, stats: info)
        addSubview(userStatisticsStack)
        userStatisticsStack.translatesAutoresizingMaskIntoConstraints = false
        userStatisticsStack.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        userStatisticsStack.leftAnchor.constraint(equalTo: rightAnchor, constant: -266.5).isActive = true
        userStatisticsStack.widthAnchor.constraint(equalToConstant: 225.5).isActive = true
        userStatisticsStack.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }

    func setupUserInformationView(with info: UserInformation) {
        if !userInformationView.isDescendant(of: self) {
            userInformationView = UserInformationStack(frame: .zero, withInformation: info)
            addSubview(userInformationView)
            userInformationView.translatesAutoresizingMaskIntoConstraints = false
            userInformationView.topAnchor.constraint(equalTo: topAnchor, constant: 117).isActive = true
            userInformationView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            userInformationView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            userInformationView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            userInformationView.updateInformationStack(info: info)
            userInformationView.invalidateIntrinsicContentSize()
            userInformationView.setNeedsLayout()
            userInformationView.layoutIfNeeded()
        } else {
            userInformationView.updateInformationStack(info: info)
            userInformationView.invalidateIntrinsicContentSize()
            userInformationView.setNeedsLayout()
            userInformationView.layoutIfNeeded()
        }
    }

    func setupEditProfileButton() {
        editProfileButton = EditProfileButton(frame: .zero)
        addSubview(editProfileButton)
        editProfileButton.addTarget(self, action: #selector(onPressEditProfile), for: .touchDown)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.topAnchor.constraint(equalTo: userInformationView.bottomAnchor, constant: 12).isActive = true
        editProfileButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        editProfileButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -32).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }

    func setupFollowButton(with uuid: String) {
        addSubview(followButton)
        followButton.uuid = uuid
        followButton.addTarget(self, action: #selector(pressedFollowButton), for: .touchDown)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        followButton.topAnchor.constraint(equalTo: userInformationView.bottomAnchor, constant: 12).isActive = true
        followButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        followButton.rightAnchor.constraint(equalTo: centerXAnchor, constant: -32).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }

    @objc func pressedFollowButton(sender: Any) {
        guard let button = sender as? FollowUnfollowButton else { return }
        if button.titleLabel?.text == "Following" {
            button.follow()
            parrallaxDelegate?.pressedFollow(with: button.uuid, isFollowing: true)
        } else {
            button.unfollow()
            parrallaxDelegate?.pressedFollow(with: button.uuid, isFollowing: false)
        }
    }

    func startRefreshAnimation() {
        onRefresh?()
    }

    func cancelRefreshAnimation() {
        onCancel?()
    }

    func finishRefreshAnimation(onCompletion : (() -> Void)? = nil) {
        onCompletion?()
    }

    override func prepareForReuse() {
        onRefresh = nil
        onCancel = nil
    }

    @objc func onPressEditProfile() {
        parrallaxDelegate?.pressedEdit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
