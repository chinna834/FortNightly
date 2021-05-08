//
//  ArticleTableViewCell.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

let kNewsArticleCellIdentifier = "FornNightArticle"

class ArticleTableViewCell: UITableViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = Utilities().createCommonLabel(text: nil, font: UIFont.getLightFont(), textColor: .lightGray)
        return label
    }()
    
    lazy var articleDescriptionLabel: UILabel = {
        let label = Utilities().createCommonLabel(text: nil, font: UIFont.getRegularFont(), textColor: .black)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = Constants.screenWidth - 100
        return label
    }()
    
    lazy var articleImageView: UIImageView = {
        let imageView = Utilities().createCommonImageView(with: UIImage(named: "emptyThumbnail"))
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addComponentsToContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponentsToContentView() {
        //Add to Content Views
        contentView.addSubview(dateLabel)
        contentView.addSubview(articleDescriptionLabel)
        contentView.addSubview(articleImageView)
        
        //Apply Constraints to Sub views
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dateLabel.heightAnchor.constraint(equalToConstant: 17),
            articleDescriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            articleDescriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            articleDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            articleImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.widthAnchor.constraint(equalToConstant: 75),
            articleImageView.bottomAnchor.constraint(equalTo: articleDescriptionLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func configureCell(with article: Article) {
        dateLabel.text = "1H"
        articleDescriptionLabel.text = article.title ?? ""
        if let imageURL = article.urlToImage {
            let transformer = SDImageResizingTransformer(size: CGSize(width: 75, height: 75), scaleMode: .fill)
            articleImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "emptyThumbnail"), context: [SDWebImageContextOption.imageTransformer : transformer])
        }
        else {
            articleImageView.image = UIImage(named: "emptyThumbnail")
        }
    }
}
