//
//  ProfileViewRouter.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 06.01.2021.
//

import Foundation
import UIKit


class AddressListRouter {
    weak var presenter: AddressListPresenterInterface?
    weak var navigationController:UINavigationController?
        
    //static func createModule(using navigationController:UINavigationController) -> ProfileViewController{}
}

extension AddressListRouter:AddressListRouterInterface{

}

//static func createModule(using navigationController: UINavigationController) -> ProfileViewController{
//
//        // Create layers
//        let router = AddressListRouter()
//        let presenter = AddressListPresenter()
//        let interactor = AddressListInteractor()
//        let view = ProfileViewController()
//        // Connect layers
//        presenter.interactor = interactor
//        presenter.router = router
//        presenter.view = view
//        view.presenter = presenter
//        interactor.presenter = presenter
//        router.presenter = presenter
//        router.navigationController = navigationController
//
//        return view
//    }
