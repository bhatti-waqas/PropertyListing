//
//  StarzPlayFont.swift
//  Starz
//
//  Created by Waqas Naseem on 20/12/2018.
//  Copyright © 2018 StarzPlay Arabia. All rights reserved.
//

import Foundation
import UIKit

public enum CustomFontType: Int {
    case regular = 700

    func getRegular() -> String {
        return "SFProDisplay-Regular"
    }
    
    public func fontName() -> String {
        switch self {
        case .regular:
            return self.getRegular()
        }
    }
    
    public func getFont(_ style: CustomFontStyle) -> UIFont {
        return UIFont(name: self.fontName(), size: style.size) ?? UIFont.systemFont(ofSize: style.size)
    }
}

public enum CustomFontStyle: Int{
    //phone / tablet
    case h1 = 11
    case h2 = 12
    case h3 = 13
    case h4 = 14
    
    private var ipadFontSize: CGFloat {
        switch self {
        case .h1:
            return 60.0
        case .h2:
            return 32.0
        case .h3:
            return 24.0
        case .h4:
            return 20.0
        }
    }
    
    private var phoneFontSize: CGFloat {
        switch self {
        case .h1:
            return 34.0
        case .h2:
            return 24.0
        case .h3:
            return 17
        case .h4:
            return 16.0
        }
    }
    
    public var size: CGFloat {
        return phoneFontSize
    }
}
