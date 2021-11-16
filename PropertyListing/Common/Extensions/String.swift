//
//  String.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

//MARK: String+UI
extension String {
        
    func img() -> UIImage {
        return UIImage(named: self) ?? UIImage()
    }
    
    func imgView() -> UIImageView {
        return UIImageView(image: UIImage(named: self) ?? UIImage())
    }
}

//MARK: String+Localizations
extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
