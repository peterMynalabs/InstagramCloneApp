//
//  UserDefaults+isFirstLaunch..swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//

import Foundation


// Bad, Bad Bad this need to be redone, but not right now....

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    static func isloggedIn() -> Bool {
        let hasBeenLoggedIn = "hasBeenLoggedIn"
        let isLoggedIn =  !UserDefaults.standard.bool(forKey: hasBeenLoggedIn)
        if (isLoggedIn){
            UserDefaults.standard.set(true, forKey: hasBeenLoggedIn)
            UserDefaults.standard.synchronize()
        }
        return isLoggedIn
    }
}
