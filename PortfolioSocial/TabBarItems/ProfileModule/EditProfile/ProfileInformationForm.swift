import Foundation
import UIKit

enum FormItems: String, CaseIterable {
    case name = "Name"
    case username = "Username"
    case occupation = "Occupation"
    case bio = "Bio"
    case nothing = ""
    
    static func withLabel(_ label: String) -> FormItems? {
           return self.allCases.first{ "\($0)" == label }
       }
}

class ProfileInformationForm: UIView, UITextViewDelegate {
    
    var userInformation: UserInformation?
    var listOfTextLabels = [UILabel]()
    var listOfTextViews = [UILabel]()
    var listOfLabelTexts = ["Name", "Username", "Occupation", "Bio"]
    var dictOfTexts: [(String, String)]?
    let textView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
    convenience init(frame: CGRect, userInformation: UserInformation){
        self.init(frame: frame)
        self.userInformation = userInformation
        dictOfTexts = [("Name", userInformation.name), ("Username", userInformation.username), ("Occupation", userInformation.occupation), ("Bio", userInformation.bio)]
        
        var yValue: CGFloat = 0.0
        for (name, information) in dictOfTexts! {
            listOfTextLabels.append(createTitles(text: name, information: information, y: yValue))
            yValue += 50.0
        }
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitles(info: UserInformation) {
        listOfTextViews[0].text = info.name
        listOfTextViews[1].text = info.username
        listOfTextViews[2].text = info.occupation
        listOfTextViews[3].text = info.bio

    }
    
    func createTitles(text: String, information: String?, y: CGFloat) -> UILabel {
        let grayLabel = UILabel()
        grayLabel.backgroundColor = .clear
        
        if let info = information {
            if info == "" {
                grayLabel.text = text
                grayLabel.textColor = UIColor(rgb: 0xC4C3C7)
            } else {
                grayLabel.text = info
                grayLabel.textColor = .black
            }
        } else {
            fatalError()
        }
        
        grayLabel.font = UIFont.systemFont(ofSize: 15)
        grayLabel.textAlignment = .left
        
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.frame = CGRect(x: 20, y: y , width: self.frame.width, height: 50)
        grayLabel.frame = CGRect(x: self.frame.width / 4 + 10, y: y , width: self.frame.width / 4 * 3, height: 50)
              
        addSubview(SeperatorLineView(frame: CGRect(x: self.frame.width / 4, y: y + 50, width: self.frame.width / 4 * 3, height: 1)))
        addSubview(label)
        label.backgroundColor = .clear
        
        addSubview(grayLabel)
        listOfTextViews.append(grayLabel)
        return label
    }
}
