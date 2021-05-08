//
//  Date+Extensions.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/8/21.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
