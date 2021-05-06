//
//  ArticlesViewRouter.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

class ArticlesViewRouter: ArticlesPresenterToRouterProtocol {
    
    static func createArticlesViewModule() -> ArticlesViewController {
       
        let newsArticlesViewController = ArticlesViewController()
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
    
}
