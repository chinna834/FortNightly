//
//  ArticleHeaderView.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

let kArticleHeaderView = "ArticleHeader"

class ArticleHeaderView: UITableViewHeaderFooterView {
    
    lazy var customBackgroundView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var articleImageView: UIImageView = {
        let imageView = Utilities().createCommonImageView(with: nil)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHeaderView() {
        
        contentView.addSubview(customBackgroundView)
       
        customBackgroundView.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: Constants.screenWidth),
            articleImageView.heightAnchor.constraint(equalToConstant: 275),
            
            customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureArticleImage(with imageURL: String) {
        articleImageView.loadImage(from: imageURL)
    }
}
