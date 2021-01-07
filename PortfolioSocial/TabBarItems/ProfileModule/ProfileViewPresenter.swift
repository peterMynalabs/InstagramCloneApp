//
//  ProfileViewPresenter.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 06.01.2021.
//

import Foundation

typealias AddressViewModel = (title:String, city:String, nameSurname:String, address:String)

class AddressListPresenter {
    weak var view: ProfileViewController?
    var router: AddressListRouterInterface?
    var interactor:AddressListInteractorInterface?
    var addressViewModels:[AddressViewModel]?

}

extension AddressListPresenter:AddressListPresenterInterface{

}
