//
//  UIViewController+Spinner.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 12.01.2021.
//

import Foundation

import UIKit

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.white
        let indicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.medium)
        indicatorView.startAnimating()
        indicatorView.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(indicatorView)
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
