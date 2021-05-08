//
//  ArticleDetailViewController.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/7/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    var selectedArticle: Article?
    var currentCategory: String?
    
    //Create Article Image View
    lazy var articleImageView: UIImageView = {
        let imageView = Utilities().createCommonImageView(with: UIImage(named: "emptyPlaceholder"))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    //Create Article Category Label
    lazy var articleCategoryLabel: UILabel = {
        let label = Utilities().createCommonLabel(text: currentCategory, font: UIFont.getMediumFont(size: 15), textColor: .black)
        return label
    }()
    
    //Create Article Title Label
    lazy var articleTitleLabel: UILabel = {
        let label = Utilities().createCommonLabel(text: selectedArticle?.title, font: UIFont.getMediumFont(), textColor: .black)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = Constants.screenWidth - 24
        return label
    }()
    
    //Create Article Content Label
    lazy var articleContentLabel: UILabel = {
        let label = Utilities().createCommonLabel(text: selectedArticle?.content, font: UIFont.getRegularFont(), textColor: .darkGray)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = Constants.screenWidth - 24
        return label
    }()
    
    //Create Article Info Stack View and add all the labels to stack view
    lazy var articleInfoStackView: UIStackView = {
        let stackView = Utilities().createVerticalStackView(views: [articleCategoryLabel, articleTitleLabel, articleContentLabel], spacing: 12)
        return stackView
    }()
    
    //MARK: - Load View
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        hookComponentsToView()
        loadArticleImage()
    }

    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Add Image View and Stack View to View
    private func hookComponentsToView() {
        view.addSubview(articleImageView)
        view.addSubview(articleInfoStackView)
        
        let viewsDict = ["ImageView": articleImageView, "StackView": articleInfoStackView]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[ImageView]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[StackView]-12-|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ImageView(250)]-12-[StackView]-12@250-|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
    }
    
    //MARK: - Load Article Image using SDWebImage
    func loadArticleImage() {
        if let imageURLPath = selectedArticle?.urlToImage, let url = URL(string: imageURLPath) {
            let transformer = SDImageResizingTransformer(size: CGSize(width: Constants.screenWidth, height: Constants.kHeaderViewHeight), scaleMode: .fill)
            articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "emptyPlaceholder"), context: [SDWebImageContextOption.imageTransformer : transformer])
        }
        else {
            articleImageView.image = UIImage(named: "emptyPlaceholder")
        }
    }
}
