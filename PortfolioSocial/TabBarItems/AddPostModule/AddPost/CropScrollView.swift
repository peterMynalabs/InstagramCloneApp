//
//  AddPostHeader.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/31/21.
//

import Foundation
import UIKit

class CropScrollView: UIScrollView {

    var imageView = UIImageView()
    var imageToDisplay: UIImage? = nil {
        didSet {
            zoomScale = 1.0
            minimumZoomScale = 1.0
            imageView.image = imageToDisplay
            imageView.frame.size = sizeForImageToDisplay()
            imageView.center = center
            contentSize = imageView.frame.size
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            updateLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfigurations()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateLayout() {
        imageView.center = center
        var frame = imageView.frame
        if frame.origin.x < 0 {
            frame.origin.x = 0
        }
        if frame.origin.y < 0 {
            frame.origin.y = 0
        }
        imageView.frame = frame
    }

    func zoom() {
        if zoomScale <= 1.0 {
            setZoomScale(zoomScaleWithNoWhiteSpaces(), animated: true)
        } else {
            setZoomScale(minimumZoomScale, animated: true)
        }
        updateLayout()
    }

    private func viewConfigurations() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceHorizontal = true
        alwaysBounceVertical = true
        decelerationRate = UIScrollView.DecelerationRate.fast
        delegate = self
        maximumZoomScale = 5.0
        addSubview(imageView)
    }

    private func sizeForImageToDisplay() -> CGSize {
        var actualWidth = imageToDisplay!.size.width
        var actualHeight = imageToDisplay!.size.height
        var imgRatio = actualWidth / actualHeight
        let maxRatio = frame.size.width / frame.size.height
        if imgRatio != maxRatio {
            if imgRatio < maxRatio {
                imgRatio = frame.size.height / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = frame.size.height
            } else {
                imgRatio = frame.size.width / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = frame.size.width
            }
        } else {
            imgRatio = frame.size.width / actualWidth
            actualHeight = imgRatio * actualHeight
            actualWidth = frame.size.width
        }

        return CGSize(width: actualWidth, height: actualHeight)
    }

    private func zoomScaleWithNoWhiteSpaces() -> CGFloat {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        return max(widthScale, heightScale)
    }
}

extension CropScrollView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateLayout()
    }
}
