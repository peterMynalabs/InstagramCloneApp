//
//  UserInformationStack.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 21.01.2021.
//

import Foundation
import UIKit

struct UserInformation {
    var bio: String
    var name: String
    var occupation: String
}

class UserInformationStack: UIView {
    
    var information: UserInformation?
    let nameLabel = UILabel()
    let occupationLabel = UILabel()
    let bioLabel = UILabel()


    
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
    
    //refactorable
    func addNameLabel() {
        
        let nameLabelFont = UIFont.boldSystemFont(ofSize: 12)
        let heightOfName = information?.name.heightOfString(usingFont: nameLabelFont)

        nameLabel.text = information?.name
        nameLabel.font = nameLabelFont
        
        nameLabel.textColor = .black
        nameLabel.lineBreakMode = .byClipping
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: heightOfName!).isActive = true
    }
    
    func addOccupationLabel() {
        let occupationLabelFont = UIFont.systemFont(ofSize: 12)
        let heightOfOccupation = information?.occupation.heightOfString(usingFont: occupationLabelFont)

        occupationLabel.text = information?.occupation
        occupationLabel.font = occupationLabelFont
        
        occupationLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        occupationLabel.lineBreakMode = .byClipping
        
        occupationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(occupationLabel)
        
        occupationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        occupationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        occupationLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
        occupationLabel.heightAnchor.constraint(equalToConstant: heightOfOccupation!).isActive = true
    }
    
    func addBioLabel() {
        let bioLabelFont = UIFont.systemFont(ofSize: 12)
        let heightOfBio = information?.bio.heightOfString(usingFont: bioLabelFont)

        bioLabel.text = information?.bio
        bioLabel.font = bioLabelFont
        
        bioLabel.textColor = .black
        bioLabel.lineBreakMode = .byClipping
        
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(bioLabel)
        
        bioLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18).isActive = true
        bioLabel.topAnchor.constraint(equalTo: occupationLabel.bottomAnchor, constant: 5).isActive = true
        bioLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -36).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: heightOfBio!).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
