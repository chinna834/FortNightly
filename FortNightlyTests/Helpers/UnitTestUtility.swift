//
//  UnitTestUtility.swift
//  FortNightlyTests
//
//  Created by Chinna Addepally on 5/8/21.
//

import Foundation
import XCTest

@testable import FortNightly

class UnitTestUtility {
    
    class func jsonObjectForResource(_ resourceName: String) -> Data? {
        guard let url = Bundle(for: Self.self).url(forResource: resourceName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        }
        catch {
            return nil
        }
    }
    
}
