//
//  PostsCollectionView.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 22.01.2021.
//

import Foundation
import UIKit

struct PostInformation {
    let image: UIImage
    let numberOfLikes: Int
    let caption: String
}

class PostCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var postList: [PostInformation]?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = self
        backgroundColor = UIColor(rgb: 0xFAFAFA)
        isScrollEnabled = false
        setupCollectionView()
    }
    
    convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, posts: [PostInformation]) {
        self.init(frame: frame, collectionViewLayout: layout)
        self.postList = posts
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = self.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        
        guard let posts = postList else {
            fatalError()
        }
        
        myCell.imageView.frame = myCell.bounds
        myCell.imageView.image = posts[indexPath.item].image
        myCell.post = posts[indexPath.item]
        return myCell
    }
}

class PostCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "Cell"
    var imageView = UIImageView()
    var caption = ""
    var numberOfLikes = 0
    var post: PostInformation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        imageView.frame = frame
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
        }
}
