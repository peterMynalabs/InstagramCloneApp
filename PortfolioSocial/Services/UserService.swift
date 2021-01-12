//
//  UserService.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

//I have this service as singleton currently, I will prbably refactor this to a protocol later on or maybe even make a GlobalServiceLocator if the number of services becomes bloated, I don't want the interactors to have twenty protocols.
struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]

        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
            let ref = Database.database().reference().child("users").child(uid)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let user = User(snapshot: snapshot) else {
                    return completion(nil)
                }

                completion(user)
            })
        }
}
