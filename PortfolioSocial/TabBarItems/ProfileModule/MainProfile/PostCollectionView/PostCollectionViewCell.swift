import Foundation
import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    static var identifier: String = "Cell"
    var imageView = UIImageView()
    var caption = ""
    var numberOfLikes = 0
    var post: Post?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(rgb: 0xFAFAFA)
        imageView.frame = frame
        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
            super.prepareForReuse()
        }
}
