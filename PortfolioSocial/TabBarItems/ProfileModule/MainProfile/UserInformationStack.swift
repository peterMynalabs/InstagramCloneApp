//
//  UserInformationStack.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 21.01.2021.
//

import Foundation
import UIKit

struct UserInformation {
    var name: String
    var occupation: String
    var username = User.current?.username ?? ""
    var bio: String
}

class UserInformationStack: UIView {
    
    var information: UserInformation?
    let nameLabel = UILabel()
    let occupationLabel = UILabel()
    let bioLabel = UILabel()
    var height: CGFloat = 0
    
   override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, withInformation information: UserInformation) {
        self.init(frame: frame)
        self.information = information
        addNameLabel()
        addOccupationLabel()
        addBioLabel()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: height)
    }
    
    func updateInformationStack(info: UserInformation) {
        height = 0
        updateNameLabel(with: info.name, and: nameLabel.font)
        updateOccupationLabel(with: info.occupation, and: occupationLabel.font)
        updateBioLabel(with: info.bio, and: bioLabel.font)
    }
    
    func addNameLabel() {
        let nameLabelFont = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.font = nameLabelFont
        nameLabel.textColor = .black
        nameLabel.lineBreakMode = .byClipping
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
 
    func updateNameLabel(with text: String?, and font: UIFont) {
        nameLabel.text = text!
        nameLabel.frame.size.width = frame.width
        nameLabel.sizeToFit()
        height += nameLabel.frame.height + 5
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
    }

    func addOccupationLabel() {
        let occupationLabelFont = UIFont.systemFont(ofSize: 12)
        occupationLabel.font = occupationLabelFont
        occupationLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        occupationLabel.lineBreakMode = .byClipping
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(occupationLabel)
    }
    
    func updateOccupationLabel(with text: String?, and font: UIFont) {
        occupationLabel.text = text!
        occupationLabel.frame.size.width = frame.width
        occupationLabel.sizeToFit()
        height += occupationLabel.frame.height + 5
        occupationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        occupationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        occupationLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
    }
    
    func addBioLabel() {
        let bioLabelFont = UIFont.systemFont(ofSize: 12)
        bioLabel.font = bioLabelFont
        bioLabel.numberOfLines = 0
        bioLabel.textColor = .black
        bioLabel.lineBreakMode = .byWordWrapping
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bioLabel)
    }
    
    func updateBioLabel(with text: String?, and font: UIFont) {
        bioLabel.text = text!
        bioLabel.frame.size.width = frame.width
        bioLabel.sizeToFit()
        height += bioLabel.frame.height + 5
        bioLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        bioLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 5).isActive = true
        bioLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
        bioLabel.widthAnchor.constraint(equalToConstant: bioLabel.frame.height).isActive = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
