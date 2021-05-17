//
//  FollowService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/12/21.
//

import Foundation
import FirebaseDatabase

class FollowService {
    func followUser(_ user: String, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current!.uid
        let followData = ["followers/\(user)/\(currentUID)" : true,
                          "following/\(currentUID)/\(user)" : true]

        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            }

            // 1
            ProfileService().posts(for: user) { (posts) in
                // 2
                let postKeys = posts.compactMap { $0.key }

                // 3
                var followData = [String : Any]()
                let timelinePostDict = ["poster_uid" : user]
                postKeys.forEach { followData["timeline/\(currentUID)/\($0)"] = timelinePostDict }

                // 4
                ref.updateChildValues(followData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }

                    ActivityService().createEvent(forURLString: "", from: user, completion: { (bool) in
                        success(error == nil)
                    })
                })
            }
        }
    }
    
     func unfollowUser(_ user: String, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current!.uid
        // Use NSNull() object instead of nil because updateChildValues expects type [Hashable : Any]
        // http://stackoverflow.com/questions/38462074/using-updatechildvalues-to-delete-from-firebase
        let followData = ["followers/\(user)/\(currentUID)" : NSNull(),
                          "following/\(currentUID)/\(user)" : NSNull()]

        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return success(false)
            }

            ProfileService().posts(for: user, completion: { (posts) in
                var unfollowData = [String : Any]()
                let postsKeys = posts.compactMap { $0.key }
                postsKeys.forEach {
                    // Use NSNull() object instead of nil because updateChildValues expects type [Hashable : Any]
                    unfollowData["timeline/\(currentUID)/\($0)"] = NSNull()
                }

                ref.updateChildValues(unfollowData, withCompletionBlock: { (error, ref) in
                    if let error = error {
                        assertionFailure(error.localizedDescription)
                    }

                    ActivityService().deleteEvent(forURLString: "", from: user, completion: { (bool) in
                        success(error == nil)
                    })
                })
            })
        }
    }
    
     func isUserFollowed(_ userUUID: String, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current!.uid
        let ref = Database.database().reference().child("followers").child(userUUID)

        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
     func setIsFollowing(_ isFollowing: Bool, fromCurrentUserTo followeeUUID: String, success: @escaping (Bool) -> Void) {
        if isFollowing {
            followUser(followeeUUID, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followeeUUID, forCurrentUserWithSuccess: success)
        }
    }
    
     func getNumberOfFollowersAndFollowing(from uuid: String, completion: @escaping (Int, Int) -> Void) {
        let ref = Database.database().reference()
        ref.child("followers").child(uuid).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let followers = snapshot.value as? [String : Bool] {
                ref.child("following").child(uuid).observeSingleEvent(of: .value, with: {
                    (snapshot) in
                    if let following = snapshot.value as? [String : Bool] {
                        completion(followers.count, following.count)
                    } else {
                        completion(0,0)
                    }
                })
            } else {
                completion(0,0)
            }
        })
        
    }
}
