//
//  PostService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/2/21.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class PostService {
    func create(for image: UIImage, with caption: String, by poster: String, likeCount: Int, completion: @escaping (Bool) -> Void) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService().uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            Post.create(forURLString: urlString, aspectHeight: aspectHeight, caption: caption, poster: poster, likedCount: likeCount, completion: { (bool) in
                completion(bool)
            })
        }
    }
    
    func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            LikeService().isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
    
    func getNumberOfPosts(with uuid: String, completion: @escaping (Int) -> Void) {
        let ref = Database.database().reference().child("posts").child(uuid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : Any] {
                return completion(value.count)
            } else {
                return completion(0)
            }
        })
    }
}
