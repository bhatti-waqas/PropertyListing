//
//  MobileAsset.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
import UIKit

public enum MobileAsset: String {
    case PlaceHolder = "placeHolder"
    
    func getImage() -> UIImage {
        return self.rawValue.img()
    }
}
