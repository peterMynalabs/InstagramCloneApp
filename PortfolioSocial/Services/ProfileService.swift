//
//  ProfileService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/9/21.
//


import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
import FirebaseDatabase.FIRDataSnapshot

class ProfileService {
     func posts(for uuid: String, completion: @escaping ([Post]) -> Void) {
        let ref = Database.database().reference().child("posts").child(uuid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }

            let dispatchGroup = DispatchGroup()

            let posts: [Post] = snapshot.reversed().compactMap {
                guard let post = Post(snapshot: $0)
                    else { return nil }

                dispatchGroup.enter()

                LikeService().isPostLiked(post) { (isLiked) in
                    post.isLiked = isLiked

                    dispatchGroup.leave()
                }

                return post
            }

            dispatchGroup.notify(queue: .main, execute: {
                completion(posts)
            })
        })
    }
    
     func updateNumberOfPosts(forUID uid: String) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String: Any] else {
                return
            }
            guard let value = snapshot["numberOfPosts"] as? String else {
                return
            }
            let newPostCount = Int(value)! + 1
            User.current!.numberOfPosts = String(newPostCount)
            ref.child("numberOfPosts").setValue(String(newPostCount)) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
            }
        })
    }
    
    func getNumberOfPost(for uuid: String, completion: @escaping (String) -> Void) {
        let ref = Database.database().reference().child("users").child(uuid).child("numberOfPosts")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? String else {
                return
            }
            completion(snapshot)
        })
        
    }
    
     func profileImage(for uuid: String, completion: @escaping (String) -> Void) {
        let ref = Database.database().reference().child("profilePhotos").child(uuid)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as?  [String : Any] else {
                return completion("")
            }
            completion(snapshot["image_url"] as! String)
        })
    }
    
     func updateProfilePhoto(forURLString urlString: String, aspectHeight: CGFloat) {
       let currentUser = User.current
       let postRef = Database.database().reference().child("profilePhotos").child(currentUser!.uid)
          postRef.setValue(["image_url" : urlString])
   }
    
     func userInformation(for uuid: String, completion: @escaping (UserInformation) -> Void) {
        let ref = Database.database().reference().child("users").child(uuid).child("information")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String: String]  else {
                return completion(UserInformation(name: "", occupation: "", username: "", bio: ""))
            }
            
            let info = UserInformation( name: snapshot["name"] ?? "", occupation: snapshot["occupation"] ?? "", bio: snapshot["bio"] ?? "")
            
            completion(info)
        })
    }

     func updateInformation(forUID uid: String, newInfo: UserInformation, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        let attributes = ["name": newInfo.name, "occupation": newInfo.occupation, "bio": newInfo.bio]
        
        ref.child("information").setValue(attributes) { (error, ref) in
            if let error = error {
                completion(false)
                assertionFailure(error.localizedDescription)
            }
            completion(true)
        }
        
        ref.child("username").setValue(newInfo.username) { (error, ref) in
            if let error = error {
                completion(false)
                assertionFailure(error.localizedDescription)
            }
            completion(true)
        }
        
        if User.current?.username != newInfo.username {
            Database.database().reference().child("active_usernames").setValue([newInfo.username: "true"]) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
            }
            
            Database.database().reference().child("active_usernames").child(User.current!.username).setValue("false") { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
            }
        }
        
        completion(true)
    }
}
