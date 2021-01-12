//
//  UserDefaults+isFirstLaunch..swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 11.01.2021.
//

import Foundation

extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
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
