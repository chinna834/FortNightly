//
//  UIImageView+Exetnsions.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
    
    func makeRoundCorners(byRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    /**
     Returns the image if it is available in Cache or downloads the image and updates the cache. Cache key is identified by a URL and return the image
     */
    func loadImage(from urlString: String, isThumbnail: Bool = true) {
        guard let url = URL(string: urlString) else { return }
        image = UIImage(named: "EmptyPlaceholder")
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject), let articleImage = imageFromCache as? UIImage {
            if isThumbnail {
                image = articleImage.scaleUIImageTo(size: CGSize(width: 75, height: 75))
            }
            else {
                image = articleImage
            }
            return
        }
        
        NetworkManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                DispatchQueue.main.async() { [weak self] in
                    if !isThumbnail {
                        self?.image = imageToCache
                    }
                    else {
                        self?.image = imageToCache.scaleUIImageTo(size: CGSize(width: 75, height: 75))
                    }
                }
            case .failure(_):
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(named: "EmptyPlaceholder")
                }
            }
        }
    }
}

