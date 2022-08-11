//
//  Fonts.swift
//  MovieApp
//
//  Created by Alex Ovi on 11.05.2022.
//

import UIKit

final class Fonts
{
    enum `Type`: String {
       case bold = "Poppins-Bold"
       case semi = "Poppins-SemiBold"
       case extraLight = "Poppins-ExtraLightItalic"
    }
    enum Size: Int {
        case small = 12
        case semiMedium = 14
        case medium = 18
        case large = 36
        
    }
    
    static func poppins(type: `Type`, size: Size) -> UIFont {
        return UIFont(name: type.rawValue, size: CGFloat(size.rawValue))!
        
    }

}



