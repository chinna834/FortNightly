//
//  Utilities.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class Utilities {
    
    func getDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    func getStoryboard(storyboardName: String) -> UIStoryboard {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        return storyboard
    }
    
    func createCommonLabel(text: String?, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textColor = textColor
        return label
    }
    
    func createCommonImageView(with defaultImage: UIImage?) -> UIImageView {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = defaultImage
        
        return imageView
    }
    
    func createVerticalStackView(views: [UIView] = [], spacing: CGFloat = 12) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.axis = .vertical
        return stackView
    }
}
