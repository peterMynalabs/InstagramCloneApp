//
//  TextView.swift
//  PortfolioSocial
//
//  Created by Peter Shaburov on 3/9/21.
//

import Foundation
import UIKit


class TextView: UIView {
    private let maxHeight: CGFloat = 100
    private let minHeight: CGFloat = 50
    var numCount = 150

    var textView = UITextView()
    var seperatorLine = SeperatorLineView()
    var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textView.font = UIFont.systemFont(ofSize: 13)
       

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInformation(labelText: String, information: String?, count: Int, navigationBarHeight: Int) {
        numCount = count
        textView.text = information ?? ""
        textView.frame.origin = CGPoint(x: 15, y: 25 + navigationBarHeight)
        textView.frame.size.width = frame.width - 15
        textView.sizeToFit()
        textView.frame.size.width =  frame.width - 15
        addSubview(textView)
        textView.delegate = self
        seperatorLine.frame = CGRect(x: 0, y: textView.frame.maxY + 5, width: frame.width - 15, height: 1)
        addSubview(seperatorLine)
        mainLabel.frame.origin = CGPoint(x: frame.width - 40, y: seperatorLine.frame.maxY + 3)
        if let info = information {
            mainLabel.text = String(count - info.count)
        } else {
            mainLabel.text = String(count)
        }
        mainLabel.sizeToFit()
        mainLabel.frame.size.width = 30
        addSubview(mainLabel)
    }
    
   
}
extension TextView: UITextViewDelegate {
    func textViewShouldReturn(_ textField: UITextView) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var height = self.minHeight
        if textView.contentSize.height <= self.minHeight {
            height = self.minHeight
        } else if textView.contentSize.height >= self.maxHeight {
            height = self.maxHeight
        } else {
            height = textView.contentSize.height
        }
        
        if textView.text.widthOfString(usingFont: UIFont.systemFont(ofSize: 13)) - 10 > textView.frame.width {
            textView.frame.size.height = height
            seperatorLine.frame.origin.y = textView.frame.maxY + 5
            mainLabel.frame.origin.y = textView.frame.maxY + 8
        } else if textView.text.widthOfString(usingFont: UIFont.systemFont(ofSize: 13)) == 0  && textView.text != "" {
            seperatorLine.frame.origin.y = textView.frame.maxY - 5
            mainLabel.frame.origin.y = textView.frame.maxY - 8
        }
      
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        mainLabel.text = String(numCount - updatedText.count)
        
        return updatedText.count < numCount
    }
}
