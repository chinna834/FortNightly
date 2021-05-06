//
//  FNError.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

struct FNError: Error {
    var errorDescription: String!
    var errorCode: Int!
    var serverError: Error?
    
    init(description: String, responseCode: Int, error: Error?) {

        self.errorDescription = description
        self.errorCode = responseCode
        self.serverError = error
    }
}
