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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, stats: UserStatistics) {
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

        for i in 0...titles.count - 1 {
        addArrangedSubview(addItemsToContainer(title: titles[i], stat: statArray[i]!))
        }
    }
    
    func addItemsToContainer(title: String, stat: Int) -> UIView {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: (self.frame.width - 20) / 3).isActive = true
        view.widthAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        
        let numberLabelFont = UIFont.boldSystemFont(ofSize: 16)
        let sizeOfNumber = String(stat).sizeOfString(usingFont: numberLabelFont)
        
        let numberLabel = UILabel()
        numberLabel.text = String(stat)
        numberLabel.font = numberLabelFont
        numberLabel.textColor = .black
        numberLabel.lineBreakMode = .byClipping
        
        let titleLabelFont = UIFont.systemFont(ofSize: 13)
        let sizeOfTitle = title.sizeOfString(usingFont: titleLabelFont)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = titleLabelFont
        titleLabel.textColor = .black
        titleLabel.lineBreakMode = .byClipping
        
        view.addSubview(numberLabel)
        view.addSubview(titleLabel)
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.heightAnchor.constraint(equalToConstant: sizeOfNumber.height).isActive = true
        numberLabel.widthAnchor.constraint(equalToConstant:sizeOfNumber.width).isActive = true
        numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        numberLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        titleLabel.heightAnchor.constraint(equalToConstant: sizeOfTitle.height).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant:sizeOfTitle.width).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5).isActive = true

        return view
    }
}
