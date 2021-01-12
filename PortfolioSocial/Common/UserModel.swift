//
//  AuthViewController.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 07.01.2021.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot


class LoginNavigationController: UINavigationController {
}

class User {

    let uid: String
    let username: String

    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }

        self.uid = snapshot.key
        self.username = username
    }
    
    private static var _current: User?

    // 2
    static var current: User? {
        // 3
      

        // 4
        return _current
    }

    // MARK: - Class Methods

    // 5
    static func setCurrent(_ user: User) {
        _current = user
    }
}

