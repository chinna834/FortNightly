//
//  ArticlesViewRouter.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

class ArticlesViewRouter: ArticlesPresenterToRouterProtocol {
    
    static func createArticlesViewModule() -> ArticlesViewController {
       
        let mainStoryboard = Utilities().getStoryboard(storyboardName: "Main")
        guard let newsArticlesViewController = mainStoryboard.instantiateViewController(identifier: "ArticlesVC") as? ArticlesViewController else {
            return ArticlesViewController()
        }
        let presenter: ArticlesViewToPresenterProtocol & ArticlesInteractorToPresenterProtocol = ArticlesViewPresenter()
        let interactor: ArticlesPresenterToInteractorProtocol = ArticlesViewInteractor()
        let router: ArticlesPresenterToRouterProtocol = ArticlesViewRouter()
        
        newsArticlesViewController.presenter = presenter
        
        presenter.view = newsArticlesViewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return newsArticlesViewController
    }
    
    func showSelectedArticleNews(selectedArticle: Article, navigationController: UINavigationController) {
        let articleDetailViewController = ArticleDetailViewRouter.createArticleDetailModule()
        articleDetailViewController.selectedArticle = selectedArticle
        articleDetailViewController.currentCategory = "\(ServerKeys.country_us) - \(ServerKeys.technologyNewsCategoryKey)" //Need to pass this category based on the selection on UI
        navigationController.pushViewController(articleDetailViewController, animated: true)
    }
    
}
