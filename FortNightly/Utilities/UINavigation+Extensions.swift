//
//  UINavigation+Extensions.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

protocol FNCustomNavigation {
    func configureNavigationBarWithTextAttributes(title: String)
    func configureNavigationBarWithBrandedImage()
}

extension FNCustomNavigation where Self: UIViewController {
    func configureNavigationBarWithTextAttributes(title: String) {
        self.navigationController?.navigationBar.isTranslucent = false
        let navigationTitleView = CustomNavigationView(frame: CGRect(x: 0, y: 0, width: 200, height: 44), title: title)
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.titleView = navigationTitleView
        }
    }
    
    func configureNavigationBarWithBrandedImage() {
        guard let image = UIImage(named: "FortNightlyIcon") else { return }
        let navigationImageView = CustomNavigationView(frame: CGRect(x: 0, y: 0, width: 45, height: 44), image: image)
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.titleView = navigationImageView
        }
    }
}

class CustomNavigationView: UIView {

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        createNavigationWithImageView(image: image)
    }
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        createNavigationWithTitleView(title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNavigationWithImageView(image: UIImage) {
        
        let imageView = Utilities().createCommonImageView(with: image)
        addSubview(imageView)
                
        let viewsDict = ["Image": imageView]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[Image(30)]-5-|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: viewsDict))
        
        addConstraint(NSLayoutConstraint.init(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    func createNavigationWithTitleView(title: String) {
        let label = Utilities().createCommonLabel(text: title, font: UIFont.getBoldFont(), textColor: .black)
        label.textAlignment = .center
        addSubview(label)
                
        addConstraint(NSLayoutConstraint.init(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint.init(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
}
