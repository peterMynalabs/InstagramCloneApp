
import Foundation
import UIKit

class ProfileViewController: ViewController {
    
    
    var presenter: AddressListPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func checkIfLoggedIn() {
        let defaults = UserDefaults.standard
        defaults.set(false , forKey: "isLoggedIn")
    }
    
}

extension ProfileViewController:AddressListViewInterface{
}
    
    

