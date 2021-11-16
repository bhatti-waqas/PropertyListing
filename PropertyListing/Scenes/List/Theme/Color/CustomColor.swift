//
//  CustomColor.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/16/21.
//

import Foundation
import UIKit

public enum CustomColor: Int {
    case clear = 1
    case themeColor = 2
    case grey = 3
    
    var colorCode: String {
        switch self {
        case .themeColor:
            return "#E5E5E5"
        case .grey:
            return "#262626"
        default:
            return ""
        }
    }
    
    var color: UIColor {
        switch self {
        case .clear:
            return UIColor.clear
        default:
            return UIColor.color(self.colorCode) ?? UIColor.clear
        }
    }
}
