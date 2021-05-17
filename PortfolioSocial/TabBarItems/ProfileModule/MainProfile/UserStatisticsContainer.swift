//
//  userStatisticsContainer.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 21.01.2021.
//

import Foundation
import UIKit

struct UserStatistics {
    var postCount: Int
    var followerCount: Int
    var followingCount: Int
}

class UserStatisticContainerView: UIStackView {

    var stats: UserStatistics?
    var container: UIStackView?
    let titles = ["Posts", "Followers", "Following"]
    var postCountView = StatisticItemCell()
    var followerCountView = StatisticItemCell()
    var followingCountView = StatisticItemCell()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, stats: UserStatistics?) {
        self.init(frame: frame)
        self.stats = stats
        setupContainer()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContainer() {
        axis = .horizontal
        alignment = .center
        spacing = 5
        distribution = .fillEqually
        let statArray = [stats?.postCount, stats?.followerCount, stats?.followingCount]
        if let postStat = statArray[0] {
            postCountView = StatisticItemCell(frame: .zero, stats: String(postStat), title: titles[0])
        } else {
            postCountView = StatisticItemCell(frame: .zero, stats: String(""), title: titles[0])
        }
        if let followerStat = statArray[1] {
            followerCountView = StatisticItemCell(frame: .zero, stats: String(followerStat), title: titles[1])
        } else {
            followerCountView = StatisticItemCell(frame: .zero, stats: String(""), title: titles[1])
        }
        if let followingStat = statArray[2] {
            followingCountView = StatisticItemCell(frame: .zero, stats: String(followingStat), title: titles[2])
        } else {
            followingCountView = StatisticItemCell(frame: .zero, stats: String(""), title: titles[2])
        }

        addArrangedSubview(postCountView)
        addArrangedSubview(followerCountView)
        addArrangedSubview(followingCountView)
    }
}

class StatisticItemCell: UIView {

    var title = ""
    var stat = ""

    let numberLabel = UILabel()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, stats: String, title: String) {
        self.init(frame: frame)
        self.stat = stats
        self.title = title
        addItemToContainer()
    }

    func addItemToContainer() {

        self.heightAnchor.constraint(equalToConstant: (self.frame.width - 20) / 3).isActive = true
        self.widthAnchor.constraint(equalToConstant: self.frame.height).isActive = true

        let numberLabelFont = UIFont.boldSystemFont(ofSize: 16)

        let sizeOfNumber = String(stat).sizeOfString(usingFont: numberLabelFont)

        numberLabel.text = String(stat)
        numberLabel.font = numberLabelFont
        numberLabel.textColor = .black
        numberLabel.lineBreakMode = .byClipping

        let titleLabelFont = UIFont.systemFont(ofSize: 13)
        let sizeOfTitle = title.sizeOfString(usingFont: titleLabelFont)

        titleLabel.text = title
        titleLabel.font = titleLabelFont
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byClipping

        self.addSubview(numberLabel)
        self.addSubview(titleLabel)

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        numberLabel.heightAnchor.constraint(equalToConstant: sizeOfNumber.height).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant: sizeOfNumber.width).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        titleLabel.heightAnchor.constraint(equalToConstant: sizeOfTitle.height).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: sizeOfTitle.width).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
