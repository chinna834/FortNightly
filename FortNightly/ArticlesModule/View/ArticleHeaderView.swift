//
//  ArticleHeaderView.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

let kArticleHeaderView = "ArticleHeader"

class ArticleHeaderView: UITableViewHeaderFooterView {
    
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
        
        contentView.addSubview(articleImageView)
               
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: Constants.screenWidth),
            articleImageView.heightAnchor.constraint(equalToConstant: Constants.kHeaderViewHeight),
        ])
    }
    
    func configureArticleImage(with imageURL: String) {
        articleImageView.loadImage(from: imageURL)
    }
}
