//
//  UserService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

class UserService {
    func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        let informationAttrs = ["name": "", "occupation": "", "bio": ""]
        let baseRef = Database.database().reference()
        let ref = baseRef.child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            baseRef.child("active_usernames").child(username).setValue("true") { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
            }

            baseRef.child("UsernameToUUID").child(username).setValue(firUser.uid) { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
            }

            ref.child("information").setValue(informationAttrs) { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
            }
            ref.child("numberOfPosts").setValue("0") { (error, _) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }

    func checkUsername(username: String, completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        ref.child("active_usernames").child(username).observeSingleEvent(of: .value, with: {(usernameSnap) in
            if usernameSnap.exists() {
                completion(true)
            } else {
                completion(false)
            }
        })
    }

    func getUUID(from username: String, completion: @escaping (String) -> Void) {
        let ref = Database.database().reference().child("UsernameToUUID").child(username)
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            guard let result = snapshot.value as? String else {
                return
            }
            completion(result)
        })
    }

    func updateProfilePhoto(forURLString urlString: String, aspectHeight: CGFloat) {
        let currentUser = User.current
        let postRef = Database.database().reference().child("profilePhotos").child(currentUser!.uid)
        postRef.setValue(["image_url": urlString])
    }

    func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }

            completion(user)
        })
    }

    func followers(for user: User, completion: @escaping ([String]) -> Void) {
        let followersRef = Database.database().reference().child("followers").child(user.uid)

        followersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let followersDict = snapshot.value as? [String: Bool] else {
                return completion([])
            }

            let followersKeys = Array(followersDict.keys)
            completion(followersKeys)
        })
    }

    func timeline(completion: @escaping ([Post]) -> Void) {
        let currentUser = User.current

        let timelineRef = Database.database().reference().child("timeline").child(currentUser!.uid)
        timelineRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
            else { return completion([]) }

            let dispatchGroup = DispatchGroup()

            var posts = [Post]()

            for postSnap in snapshot {
                guard let postDict = postSnap.value as? [String: Any],
                      let posterUID = postDict["poster_uid"] as? String
                else { continue }

                dispatchGroup.enter()

                PostService().show(forKey: postSnap.key, posterUID: posterUID) { (post) in
                    if let post = post {
                        posts.append(post)
                    }

                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main, execute: {
                completion(posts.reversed())
            })
        })
    }

    func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
        let currentUser = User.current
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
            else {
                return completion([])
            }

            let users = snapshot.compactMap(User.init).filter { $0.uid != currentUser!.uid }
            let dispatchGroup = DispatchGroup()
            users.forEach { (user) in
                dispatchGroup.enter()

                FollowService().isUserFollowed(user.uid) { (isFollowed) in
                    user.isFollowed = isFollowed
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main, execute: {
                completion(users)
            })
        })
    }
}
