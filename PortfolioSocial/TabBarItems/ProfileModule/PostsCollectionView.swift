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

class PostCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
   // var posts: [PostInformation]?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = self
        self.delegate = self
    }
    
//    convenience init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, posts: [PostInformation]) {
//        self.init(frame: frame, collectionViewLayout: layout)
//        self.posts = posts
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = self.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.blue
        return myCell
    }
    
    
   
}
