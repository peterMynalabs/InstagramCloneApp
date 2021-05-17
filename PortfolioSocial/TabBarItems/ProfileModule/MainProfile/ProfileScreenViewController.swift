
import UIKit
import SDWebImage
import Foundation

class ProfileScreenViewController: UICollectionViewController {
    
    // MARK: - Public properties -
    var presenter: ProfileScreenPresenterInterface!
    var header: PostCollectionViewParrallaxHeader?
    var refreshControl = UIRefreshControl()
    
    private var layout = UICollectionViewFlowLayout()
    // MARK: - Lifecycle -
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutForCollectionView()
        setupCollectionView()
        setupRefreshControl()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    func setupLayoutForCollectionView() {
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Menu"), style: .plain, target: self, action: #selector(pressSettings))
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width - 2) / 3, height: view.frame.width / 3)
        layout.sectionHeadersPinToVisibleBounds = true
        collectionView.collectionViewLayout = layout
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(rgb: 0xFAFAFA)
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        collectionView.register(PostCollectionViewParrallaxHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "firstHeader")
        collectionView.register(PostCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "secondHeader")
        
        collectionView.backgroundColor = UIColor(rgb: 0xFAFAFA)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 250, right: 0)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBarController?.tabBar.frame.height)!).isActive = true
    }
    
    @objc func pressSettings() {
        let popupController = PopupMenuViewController()
        popupController.modalPresentationStyle = .popover
        popupController.selectionHandler = { [weak self] (selection) in
            self?.presenter.selectedMenuItem(with: selection)
            popupController.dismiss(animated: true, completion: nil)
        }
        self.present(popupController, animated: true, completion: nil)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.viewReloaded()
    }
}

extension ProfileScreenViewController {
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        } else if section == 1 {
            return CGSize(width:collectionView.frame.size.width, height: 230)
        } else {
            return CGSize(width:collectionView.frame.size.width, height: 44)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return presenter.postList?.count ?? 9
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = ProfilePostViewController()
        controller.postList = presenter.postList!
        controller.index = indexPath.item
        self.navigationController?.pushViewController(controller, animated: true)
        controller.tableView.scrollToRow(at: IndexPath(row: indexPath.item, section: 0), at: .top, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            let section = indexPath.section
            switch section {
            case 1:
                let firstheader: PostCollectionViewParrallaxHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "firstHeader", for: indexPath) as! PostCollectionViewParrallaxHeader
                firstheader.parrallaxDelegate = self
                reusableview = firstheader
                
            case 2:
                let secondHeader: PostCollectionViewHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "secondHeader", for: indexPath) as! PostCollectionViewHeader
                reusableview = secondHeader
            default:
                return reusableview
            }
        }
        return reusableview
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as! PostCollectionViewCell
        
        let shimmerView = UIView(frame: myCell.frame)
        
        if let posts = presenter.postList  {
            shimmerView.stopShimmeringEffect()
            myCell.imageView.frame = myCell.bounds
            let slice = posts[indexPath.item]
            myCell.imageView.sd_setImage(with: URL(string: slice.imageURL), completed: nil)
            myCell.contentView.backgroundColor = UIColor(rgb: 0xEDEDED)
            myCell.post = posts[indexPath.item]
            return myCell
        }
        shimmerView.backgroundColor = UIColor(rgb: 0xEDEDED)
        myCell.backgroundColor = .white
        myCell.backgroundView = shimmerView
        
        shimmerView.startShimmeringEffect()
        return myCell
    }
}

// MARK: - Extensions -

extension ProfileScreenViewController: ProfileScreenViewInterface {
    
    func updateProfileForm(info: UserInformation) {
        header?.setupUserInformationView(with: info)
    }
    
    func updatePosts() {
        refreshControl.endRefreshing()
        self.header = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1)) as? PostCollectionViewParrallaxHeader
        self.presenter.headerViewExists()
    }
    
    func setupProfilePhoto(with image: String) {
        header?.updateProfileImage(with: image)
    }
    
    func setupUserStatisticView(with info: UserStatistics) {
        header?.setupUserStatisticView(with: info)
    }
    
    func setupEditProfileButton() {
        if !presenter.isEditHidden {
            header?.setupEditProfileButton()
        } else {
            header?.setupFollowButton(with: presenter.uuid)
            presenter.buttonLoaded(completion: { [weak self] (isFollowed) in
                if isFollowed {
                    self?.header?.followButton.unfollow()
                } else {
                    self?.header?.followButton.follow()
                }
            })
        }
        collectionView.reloadData()
    }
}

extension ProfileScreenViewController: PostCollectionViewParrallaxHeaderDelegate {
    func pressedEdit() {
        presenter.pressedEdit()
    }
    
    func pressedFollow(with username: String, isFollowing: Bool) {
        presenter.pressedFollow(isFollowing: isFollowing, username: username)
    }
}



