//
//  CameraRollCollectionViewCell.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/6/21.
//

import Foundation
import UIKit

class CameraRollCollectionViewCell: UICollectionViewCell {

    static var identifier: String = "Cell"
    var imageView = UIImageView()
    var caption = ""
    var numberOfLikes = 0
    var post: Post?

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.isUserInteractionEnabled = true
        backgroundColor = .red
        self.addSubview(imageView)
        addConstraints()
    }

    func addConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
