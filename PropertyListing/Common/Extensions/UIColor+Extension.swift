//
//  UIColor+Extension.swift
//  ListingChallenge
//
//  Created by Waqas Naseem on 11/9/21.
//

import UIKit

extension UIColor {
        
    public static func color(_ hexString: String, alpha: CGFloat = 1) -> UIColor? {
        if (hexString.count > 7 || hexString.count < 7) { return nil }
        let r, g, b : CGFloat
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber >> 16) & 0xff) / 255
                g = CGFloat((hexNumber >> 08) & 0xff) / 255
                b = CGFloat((hexNumber >> 00) & 0xff) / 255
                
                return UIColor(red: r, green: g, blue: b, alpha: alpha)
            }
        }
        return nil
    }
}
