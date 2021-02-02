
import UIKit

final class ProfileScreenViewController: UIViewController {
    
    // MARK: - Public properties -
    
    var presenter: ProfileScreenPresenterInterface!
    var profileImage: UIImage?
    var posts: [PostInformation]?
    var scrollView = UIScrollView()
    let layout = UICollectionViewFlowLayout()
    var editProfileButton = EditProfileButton()
    var userInformation: UserInformation?
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        
        posts = [PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: ""), PostInformation(image: UIImage(named: "Like")!, numberOfLikes: 1, caption: "")]
        
        self.navigationController?.isNavigationBarHidden = false
        
        setupScrollView()
        setupLayoutForCollectionView()
        setupFrames()
        setupProfilePhoto()
        addTargets()

    }

    var userInformationView = UserInformationStack()
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor(rgb: 0xFAFAFA)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setupLayoutForCollectionView() {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width - 2) / 3, height: view.frame.width / 3)
    }
    
    func setupFrames() {
        profilePhoto.frame = CGRect(x: 12, y: 80, width: 95, height: 95)
        
        let userStatisticFrame =  CGRect(x: profilePhoto.frame.maxX + 41, y:  95 / 2 + 57, width: 225.5, height: 32)
        let userStatisticsStack = UserStatisticContainerView(frame: userStatisticFrame, stats: UserStatistics(postCount: 38, followerCount: 1902, followingCount: 13))
        
        let userInformationFrame = CGRect(x: 0, y: profilePhoto.frame.maxY + 12, width: view.frame.width, height: 49)
        userInformation = UserInformation(bio: User.current?.bio ?? "", name: User.current?.name ?? "", occupation: User.current?.occupation ?? "")
        
        guard let info = userInformation else {
            fatalError()
        }
        
         userInformationView = UserInformationStack(frame: userInformationFrame, withInformation: info)

        let editProfileButtonFrame = CGRect(x: 16, y: userInformationView.frame.maxY + 15, width: view.frame.width - 32, height: 29)
        editProfileButton = EditProfileButton(frame: editProfileButtonFrame)
        
        
        let calculatedheight = CGFloat(ceil(Double(posts!.count) / 3.0)) * layout.itemSize.width
        let collectionViewFrame = CGRect(x: 0, y: editProfileButton.frame.maxY + 10, width: self.view.frame.width, height: calculatedheight)
        let postCollectionView = PostCollectionView(frame: collectionViewFrame, collectionViewLayout: layout, posts: posts!)
        postCollectionView.delegate = self
        
        scrollView.addSubview(profilePhoto)
        scrollView.addSubview(userStatisticsStack)
        scrollView.addSubview(userInformationView)
        scrollView.addSubview(editProfileButton)
        scrollView.addSubview(postCollectionView)
    }
    func addTargets() {
        editProfileButton.addTarget(self, action: #selector(onPressEditProfile), for: .touchDown)
    }
    
    func setupProfilePhoto() {
        profilePhoto.layer.cornerRadius = profilePhoto.frame.width / 2
        //refactor
        profilePhoto.addSubview(createButton(withframe: profilePhoto.bounds, calling: #selector(onPressProfile)))
        profilePhoto.isUserInteractionEnabled = true
    }
    
    func createButton(withframe: CGRect, calling: Selector) -> UIButton {
        let button = UIButton(frame: withframe)
        button.backgroundColor = .clear
        button.addTarget(self, action: calling, for: .touchDown)
        return button
    }
    
    let profilePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "back")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    @objc func onPressProfile() {
        self.view.backgroundColor = .red
        print("HeY")
    }
    
    @objc func onPressEditProfile() {
        presenter.pressedEdit(userInformation: userInformation!)
    }
}

// MARK: - Extensions -

extension ProfileScreenViewController: ProfileScreenViewInterface {
    func updateProfileForm(info: UserInformation) {
        userInformationView.updateInformationStack(info: info)
    }
}

extension ProfileScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PostCollectionViewCell
        let cellInformation = cell.post
     }
}
