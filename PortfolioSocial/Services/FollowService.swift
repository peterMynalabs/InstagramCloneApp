//
//  FollowService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/12/21.
//

import Foundation
import FirebaseDatabase

class FollowService {
    func followUser(_ user: String) {
        let currentUID = User.current!.uid
        let followData = ["followers/\(user)/\(currentUID)": true,
                          "following/\(currentUID)/\(user)": true]

        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }

            ProfileService().posts(for: user) { (posts) in
                let postKeys = posts.compactMap { $0.key }

                var followData = [String: Any]()
                let timelinePostDict = ["poster_uid": user]
                postKeys.forEach { followData["timeline/\(currentUID)/\($0)"] = timelinePostDict }

                ref.updateChildValues(followData, withCompletionBlock: { (error, _) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }

                    ActivityService().createEvent(forURLString: "", from: user, completion: { (bool) in
                        if !bool {
                            assertionFailure()
                        }
                    })
                })
            }
        }
    }

     func unfollowUser(_ user: String) {
        let currentUID = User.current!.uid
        let followData = ["followers/\(user)/\(currentUID)": NSNull(),
                          "following/\(currentUID)/\(user)": NSNull()]

        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }

            ProfileService().posts(for: user, completion: { (posts) in
                var unfollowData = [String: Any]()
                let postsKeys = posts.compactMap { $0.key }
                postsKeys.forEach {
                    unfollowData["timeline/\(currentUID)/\($0)"] = NSNull()
                }

                ref.updateChildValues(unfollowData, withCompletionBlock: { (error, _) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }

                    ActivityService().deleteEvent(forURLString: "", from: user, completion: { (bool) in
                        if !bool {
                            assertionFailure()
                        }
                    })
                })
            })
        }
    }

     func isUserFollowed(_ userUUID: String, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current!.uid
        let ref = Database.database().reference().child("followers").child(userUUID)

        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String: Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }

     func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followeeUUID: String) {
        if isFollowing {
            followUser(followeeUUID)
        } else {
            unfollowUser(followeeUUID)
        }
    }

     func getNumberOfFollowersAndFollowing(from uuid: String, completion: @escaping (Int, Int) -> Void) {
        let ref = Database.database().reference()
        ref.child("followers").child(uuid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let followers = snapshot.value as? [String: Bool] {
                ref.child("following").child(uuid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let following = snapshot.value as? [String: Bool] {
                        completion(followers.count, following.count)
                    } else {
                        completion(0, 0)
                    }
                })
            } else {
                completion(0, 0)
            }
        })
    }
}
