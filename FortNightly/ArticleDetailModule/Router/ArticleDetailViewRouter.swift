//
//  ArticleDetailViewRouter.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/7/21.
//

import Foundation

class ArticleDetailViewRouter: ArticleDetailViewPresenterToRouter {
    static func createArticleDetailModule() -> ArticleDetailViewController {
        let articleDetailViewController = ArticleDetailViewController()
        return articleDetailViewController
    }
}
