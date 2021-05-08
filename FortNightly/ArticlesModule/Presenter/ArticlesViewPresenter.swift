//
//  ArticlesViewPresenter.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation
import UIKit

class ArticlesViewPresenter: ArticlesViewToPresenterProtocol {
    
    weak var view: ArticlesPresenterToViewProtocol?
    var interactor: ArticlesPresenterToInteractorProtocol?
    var router: ArticlesPresenterToRouterProtocol?
    
    /**
     Load News Articles by a source. Example: techcrunch
     */
    func loadNewsArticles(source: String) {
        interactor?.getNewsArticles(bySource: source)
    }
    
    /**
     Load News Articles  by Category and Country. Example Countries: us, ca, cn, in
     */
    func loadNewsArticles(category: String, country: String) {
        interactor?.getBusinessNewsArticles(byCategory: category, country: country)
    }
    
    /**
     Navigate to Article Detail to display the additional information on the selected Article
     */
    func didSelectedArticle(article: Article, navigationController: UINavigationController) {
        router?.showSelectedArticleNews(selectedArticle: article, navigationController: navigationController)
    }
}

//MARK: - Update the Response back to View
extension ArticlesViewPresenter: ArticlesInteractorToPresenterProtocol {
    /**
     Pass the fetched articles back to View
     */
    func fetchedArticlesOnSuccess(newsArticles: [Article]) {
        view?.updateArticlesToView(articles: newsArticles)
    }
    
    /**
     Update View if there is an error to fetch the Articles
     */
    func failedToFetchNewsArticles() {
        view?.failedToGetArticles()
    }
}
