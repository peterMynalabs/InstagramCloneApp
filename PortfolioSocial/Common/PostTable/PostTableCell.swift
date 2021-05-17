//
//  PostTableCell.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/6/21.
//

import Foundation
import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostTableCell)
}

class PostTableCell: UITableViewCell {
    static var identifier: String = "TableViewCell"
    var caption = ""
    var numberOfLikes = 0
    var post: Post?
    var profileImage = UIImageView(frame: CGRect(x: 10, y: 11, width: 32, height: 32))
    var topNameButton = UsernameButton()
    var bottomNameButton = UsernameButton()
    var likeLabel = UILabel()
    var captionLabel = UILabel(frame: .zero)
    var likeButton = UIButton()
    var mainImageView = UIImageView()
    var dateLabel = UILabel()
    var liked: Bool?
    var likeCount = 0
    let shimmerView = UIView(frame: CGRect(x: 0, y: 54, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))

    weak var delegate: PostActionCellDelegate?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(shimmerView)
        addSubview(mainImageView)
        addSubview(likeButton)
        addSubview(bottomNameButton)
        addSubview(likeLabel)
        addSubview(captionLabel)
        addSubview(dateLabel)
        addSubview(profileImage)
        addSubview(topNameButton)
        backgroundColor = UIColor(rgb: 0xFAFAFA)

    }
    
    func setupTopNameButton(name: String) {
        topNameButton.username = name
        topNameButton.setupButton()
        topNameButton.sizeToFit()
        topNameButton.frame.origin = CGPoint(x: 52, y: (54 - topNameButton.frame.height) / 2)
    }
    
    func setupProfileImage(info: Post) {
        //this is a problem with my backend and I don't want to uncouple this from this cell because ideally I would iron it out
        UserService().getUUID(from: info.poster, completion: { (uuid) in
            ProfileService().profileImage(for: uuid, completion: { [weak self] (image_url) in
                self?.profileImage.sd_setImage(with:  URL(string: image_url), placeholderImage: UIImage(named: "defaultProfilePhoto"),  completed: nil)
            })
        })
    }
    
    func setupMainImageView(imageURL: String) {
        mainImageView.frame = CGRect(x: 0, y: 54, width: frame.width, height: frame.width)
        mainImageView.sd_setImage(with: URL(string: imageURL), completed: nil)
    }
    
    func setupLikeButton(isLiked: Bool) {
        self.liked = isLiked
        likeButton.frame = CGRect(x: 7, y: frame.width + 54 + 9, width: 35, height: 31.5)
        if isLiked {
            likeButton.setImage(UIImage(named: "liked"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
        }
        likeButton.addTarget(self, action: #selector(pressedLiked), for: .touchDown)
    }
    
    func setupBottonNameButton(name: String) {
        bottomNameButton.username = name
        bottomNameButton.setupButton()
        bottomNameButton.sizeToFit()
        let inset = 36 - bottomNameButton.frame.height
        bottomNameButton.titleLabel?.textAlignment = .left
        bottomNameButton.frame.origin = CGPoint(x: 14, y: 72 + frame.width + 54 - 3 - inset)
        let sizeOfNameButton = bottomNameButton.titleLabel!.text!.sizeOfString(usingFont: UIFont.boldSystemFont(ofSize: 13))
        bottomNameButton.frame.size = CGSize(width: (sizeOfNameButton.width > 44) ? sizeOfNameButton.width : 44, height: 36)

    }
    
    func setupLikeLabel(with liked: String) {
        likeCount = Int(liked)!
        likeLabel.frame = CGRect(x: 14, y: 48 + frame.width + 54, width: frame.width, height: 19)
        likeLabel.text = liked + " likes"
        likeLabel.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func setupCaptionLabel(caption: String) {
        let sizeOfSpace = " ".sizeOfString(usingFont: UIFont.systemFont(ofSize: 13))
        let sizeOfNameButton = bottomNameButton.titleLabel!.text!.sizeOfString(usingFont: UIFont.boldSystemFont(ofSize: 13))
        let numberOfSpacesNeeded = sizeOfNameButton.width / sizeOfSpace.width
        let insetString = String(repeating: " ", count: Int(numberOfSpacesNeeded) + 2)

        captionLabel.numberOfLines = 4
        captionLabel.lineBreakMode = .byWordWrapping
        captionLabel.text = insetString + caption
        captionLabel.font = UIFont.systemFont(ofSize: 13)
        captionLabel.frame.size.width = frame.width - 30
        captionLabel.sizeToFit()
        captionLabel.sendSubviewToBack(bottomNameButton)
        captionLabel.frame.origin = CGPoint(x: 14, y: 72 + frame.width + 54)
    }
    
    func setupDateLabel(date: Date, captionExists: Bool) {
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.textColor = UIColor.black.withAlphaComponent(0.5)
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy"
        let now = df.string(from: Date())
        dateLabel.text = now
        dateLabel.sizeToFit()
        dateLabel.frame.origin = CGPoint(x: 14, y: 72 + frame.width + 60 + ((captionExists) ? captionLabel.frame.height : 0))
    }
    
    @objc func pressedLiked(_ sender: UIButton) {
        if liked! {
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
            if likeCount == 2 {
                likeLabel.text = String(likeCount - 1) + " like"
            } else {
                likeLabel.text = String(likeCount - 1) + " likes"
            }
        } else {
            likeButton.setImage(UIImage(named: "liked"), for: .normal)
            if likeCount == 0 {
                likeLabel.text = String(likeCount + 1) + " like"
            } else {
                likeLabel.text = String(likeCount + 1) + " likes"
            }

        }
        
        delegate?.didTapLikeButton(sender, on: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = UIImage(named: "back")
    }
}
