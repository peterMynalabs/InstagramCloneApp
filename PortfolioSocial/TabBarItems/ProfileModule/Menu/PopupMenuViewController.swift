//
//  PopupSettings.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 2/10/21.
//

import Foundation
import UIKit

enum Menu: String, CaseIterable {
    case settings = "Settings"
    case archive = "Archive"
    case activity = "Your activity"
    case qrCode = "QR Code"
    case saved = "Saved"
    case closeFriends = "Close friends"
    case discover = "Discover people"
    case updateMessaging = "Update Messaging"
}

class PopupMenuViewController: UIViewController  {
    
    var selectionHandler: ((_ selected: Menu) -> Void)?

    let cellReuseIdentifier = "cell"
    let tableView = UITableView()
    var listOfCellTitles = [String]()
    
    let popupBox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .clear
        self.definesPresentationContext = true
        setupArrayOfTitles()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        setupViews()
    }
    
    
    func setupArrayOfTitles() {
        for value in Menu.allCases {
            listOfCellTitles.append(value.rawValue)
        }
    }
    
    func setupViews() {
        view.addSubview(popupBox)
        popupBox.layer.cornerRadius = 15
        popupBox.clipsToBounds = true
        popupBox.heightAnchor.constraint(equalToConstant: 55 * 11).isActive = true
        popupBox.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupBox.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        popupBox.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.leftAnchor.constraint(equalTo: popupBox.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: popupBox.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: popupBox.topAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: popupBox.bottomAnchor, constant: 20).isActive = true
    }
}

extension PopupMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell: UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        // set the text from the data model
        cell.textLabel?.text = listOfCellTitles[indexPath.row]
        cell.imageView?.image = UIImage(named: listOfCellTitles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectionHandler = selectionHandler else {
            fatalError()
        }
        selectionHandler(Menu.init(rawValue: listOfCellTitles[indexPath.row]) ?? .settings)
    }
}
