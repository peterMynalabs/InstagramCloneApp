//
//  PostCollectionViewHeader.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/16/21.
//

import Foundation
import UIKit
class PostCollectionViewHeader: UICollectionReusableView {
    static let reuseIdentifierHeader = "headerView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = UIColor(rgb: 0xFAFAFA)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        let seperatorViewDark = SeperatorLineView()
        seperatorViewDark.backgroundColor = .black
        addSubview(seperatorViewDark)
        seperatorViewDark.translatesAutoresizingMaskIntoConstraints = false
        seperatorViewDark.topAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        seperatorViewDark.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        seperatorViewDark.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorViewDark.heightAnchor.constraint(equalToConstant: 1).isActive = true

        let seperatorViewHidden = SeperatorLineView()
        seperatorViewHidden.backgroundColor = .clear
        addSubview(seperatorViewHidden)
        seperatorViewHidden.translatesAutoresizingMaskIntoConstraints = false
        seperatorViewHidden.topAnchor.constraint(equalTo: seperatorViewDark.bottomAnchor).isActive = true
        seperatorViewHidden.leftAnchor.constraint(equalTo: seperatorViewDark.rightAnchor).isActive = true
        seperatorViewHidden.widthAnchor.constraint(equalTo: seperatorViewDark.widthAnchor).isActive = true
        seperatorViewHidden.heightAnchor.constraint(equalToConstant: 1).isActive = true

        let postIcon = UIImageView()
        postIcon.image = UIImage(named: "posts")
        postIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(postIcon)
        postIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10.5).isActive = true
        postIcon.leftAnchor.constraint(equalTo: seperatorViewDark.centerXAnchor, constant: -11).isActive = true
        postIcon.widthAnchor.constraint(equalToConstant: 23).isActive = true
        postIcon.heightAnchor.constraint(equalToConstant: 23).isActive = true

        let taggedIcon = UIImageView()
        taggedIcon.image = UIImage(named: "tagged")
        taggedIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(taggedIcon)
        taggedIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10.5).isActive = true
        taggedIcon.leftAnchor.constraint(equalTo: seperatorViewHidden.centerXAnchor, constant: -11).isActive = true
        taggedIcon.widthAnchor.constraint(equalToConstant: 23).isActive = true
        taggedIcon.heightAnchor.constraint(equalToConstant: 23).isActive = true
      }
}
