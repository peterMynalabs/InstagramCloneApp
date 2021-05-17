//
//  ActivityService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/15/21.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
import FirebaseDatabase.FIRDataSnapshot

class ActivityService {
    
    func createEvent(forURLString urlString: String, from poster: String, completion:  @escaping (Bool) -> Void) {
        let currentUser = User.current
        let dict = [urlString, User.current?.username, String(Date().timeIntervalSince1970)]
        let postRef = Database.database().reference().child("events").child(currentUser!.uid).childByAutoId()
        let newPostKey = postRef.key
        
        if urlString != "" {
            UserService().getUUID(from: poster, completion: { (uuid) in
                
                let updatedData: [String : Any] = ["events/\(uuid)/\(newPostKey!)": dict]
                
                Database.database().reference().updateChildValues(updatedData) {  (error, ref) in
                    if error != nil {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            })
        }
        else {
            let updatedData: [String : Any] = ["events/\(poster)/\(newPostKey!)": dict]
            
            Database.database().reference().updateChildValues(updatedData) {  (error, ref) in
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func deleteEvent(forURLString urlString: String, from poster: String, completion:  @escaping (Bool) -> Void) {
        let currentUser = User.current
        let postRef = Database.database().reference().child("events").child(poster)
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if var value = snapshot.value as? [String : [String]] {
                value.forEach {
                    if $0.value.first == urlString && $0.value[1] == currentUser?.username {
                        value.removeValue(forKey: $0.key)
                    }
                }
                
               
                postRef.setValue(value) { (error, ref) in
                    if error != nil {
                        completion(false)
                    } else {
                        completion(true)
                    }
                }
            }
        })
    }
    
    func activity(from uuid: String, completion: @escaping ([String : [String]]) -> Void) {
        let postRef = Database.database().reference().child("events").child(uuid)
        postRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : [String]] {
                completion(value)
            } else {
                completion([String: [String]]())
            }
        })
    }
}
