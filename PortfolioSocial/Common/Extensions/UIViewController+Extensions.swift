//
//  UIViewController+.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 4/14/21.
//

import Foundation
import UIKit

extension UIViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 2) / 3, height: view.frame.width / 3)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        } else if section == 1 {
            return CGSize(width: collectionView.frame.size.width, height: 133)
        } else {
            return CGSize(width: collectionView.frame.size.width, height: 100)
        }
    }
}
