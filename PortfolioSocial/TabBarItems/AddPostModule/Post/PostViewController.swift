
import UIKit

class PostViewController: UIViewController {

    // MARK: - Public properties -
    var presenter: PostPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewLoaded()
    }

    var imageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()

    var textView = TextView()

    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: "Back"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(pressedBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Share", comment: "Share"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(pressedShare))
    }

    @objc func pressedBack() {
        presenter.pressedBack()
    }

    @objc func pressedShare() {
        navigationItem.rightBarButtonItem?.action = nil
        removeAllViews()
        presenter.pressedShare(with: imageView.image!, and: textView.textView.text)

    }
    func removeAllViews() {
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        self.showSpinner(onView: view)
    }
}

// MARK: - Extensions -

extension PostViewController: PostViewInterface {
    func setImage(with image: NSObject) {
        var navBarHeight: CGFloat = 0
        imageView.image = image as? UIImage
        setupNavigationBar()

        navBarHeight = (navigationController?.navigationBar.frame.height)!
        if UIDevice.current.hasNotch {
            imageView.frame = CGRect(x: 15, y: navBarHeight + 55, width: 75, height: 75)
            textView.frame = CGRect(x: 100, y: navBarHeight, width: view.frame.width - 110, height: view.frame.height)
        } else {
            imageView.frame = CGRect(x: 15, y: navBarHeight + 35, width: 75, height: 75)
            textView.frame = CGRect(x: 100, y: 0, width: view.frame.width - 110, height: view.frame.height)
        }
        textView.setInformation(labelText: "Write A Caption",
                                information: nil,
                                count: 180,
                                navigationBarHeight: Int(navBarHeight))
        view.addSubview(textView)
        view.addSubview(imageView)
    }

}
