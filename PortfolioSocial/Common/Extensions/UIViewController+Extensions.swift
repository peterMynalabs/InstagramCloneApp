//
//  UIViewController+.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/14/21.
//

import Foundation
import UIKit

extension UIViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            
        return CGSize(width: (view.frame.width - 2) / 3, height: view.frame.width / 3)
        }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            if(section==0) {
                return CGSize.zero
            } else if (section==1) {
                return CGSize(width:collectionView.frame.size.width, height:133)
            } else {
                return CGSize(width:collectionView.frame.size.width, height:100)
            }
        }
    }
extension UINavigationController {

  public func pushViewController(viewController: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }

}
extension UIDevice {
    /// Returns `true` if the device has a notch
    var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}
