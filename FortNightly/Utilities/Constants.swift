//
//  Constants.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case post = "POST",
         get = "GET",
         put = "UPDATE",
         delete = "DELETE"
}

struct Constants {
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    
    //Article Header View Height
    static let kHeaderViewHeight: CGFloat = 275.0
    
    //Storyboard
    static let storyboard_main = "Main"
    
    //Common
    static let commonError = "Something went wrong. Please try again."
    static let errorInRequest = "Error sending request"
    
}
