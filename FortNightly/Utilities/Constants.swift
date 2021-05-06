//
//  Constants.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST",
         get = "GET",
         put = "UPDATE",
         delete = "DELETE"
}

struct Constants {
    
    //Storyboard
    static let storyboard_main = "Main"
    
    //ViewController Identifiers
    
    
    //Common
    static let commonError = "Something went wrong. Please try again."
    static let errorInRequest = "Error sending request"
    
}
