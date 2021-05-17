//
//  UIViewController+Spinner.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 12.01.2021.
//

import Foundation

import UIKit

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.white
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension UITextView {

   func centerVertically() {
       let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
       let size = sizeThatFits(fittingSize)
       let topOffset = (bounds.size.height - size.height * zoomScale) / 2
       let positiveTopOffset = max(1, topOffset)
       contentOffset.y = -positiveTopOffset
   }

}

extension UITableView {
    func registerCells(_ types: [(AnyObject.Type, String)]) {
            for (type, identifier) in types {
                self.register(type, forCellReuseIdentifier: identifier)
            }
        }
}
