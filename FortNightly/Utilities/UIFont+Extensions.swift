//
//  UIFont+Extensions.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

extension UIFont {
    
    static func getRegularFont() -> UIFont {
        return UIFont(name: "Merriweather-Regular", size: 15.0) ?? UIFont.systemFont(ofSize: 17)
    }
    
    static func getBoldFont() -> UIFont {
        return UIFont(name: "Merriweather-Bold", size: 17.0) ?? UIFont.systemFont(ofSize: 17, weight: .bold)
    }
    
    static func getLightFont() -> UIFont {
        return UIFont(name: "Merriweather-Light", size: 16) ?? UIFont.systemFont(ofSize: 17, weight: .light)
    }
    
}
