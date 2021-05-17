//
//  UIDevice+Extension.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 5/17/21.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        guard #available(iOS 11.0, *),
              let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
