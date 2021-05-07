//
//  ArticleTableViewCell.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

let kNewsArticleCellIdentifier = "FornNightArticle"

class ArticleTableViewCell: UITableViewCell {
    
    var dateLabel: UILabel!
    var articleDescriptionLabel: UILabel!
    var articleImageView: UIImageView!
    
    private func createViews() {
        dateLabel = Utilities().createCommonLabel(text: nil, font: UIFont.getLightFont(), textColor: .lightGray)
        contentView.addSubview(dateLabel)
        
        articleDescriptionLabel = Utilities().createCommonLabel(text: nil, font: UIFont.getRegularFont(), textColor: .black)
        articleDescriptionLabel.numberOfLines = 0
        articleDescriptionLabel.preferredMaxLayoutWidth = Constants.screenWidth - 100
        contentView.addSubview(articleDescriptionLabel)
                
        articleImageView = Utilities().createCommonImageView(with: UIImage(named: "emptyThumbnail"))
        contentView.addSubview(articleImageView)
    }
    
    private func createConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            articleDescriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            articleDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            articleDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            articleImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.widthAnchor.constraint(equalToConstant: 75),
            articleImageView.bottomAnchor.constraint(equalTo: articleDescriptionLabel.bottomAnchor, constant: 4)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createViews()
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with article: Article) {
        dateLabel.text = "1H"
        
        articleDescriptionLabel.text = article.title ?? ""
        
        if let imageURL = article.urlToImage {
            articleImageView.loadImage(from: imageURL)
        }
    }
}
