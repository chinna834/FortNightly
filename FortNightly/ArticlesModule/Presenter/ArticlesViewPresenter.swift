//
//  ArticlesViewPresenter.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

class ArticlesViewPresenter: ArticlesViewToPresenterProtocol {
    
    weak var view: ArticlesPresenterToViewProtocol?
    var interactor: ArticlesPresenterToInteractorProtocol?
    var router: ArticlesPresenterToRouterProtocol?
    
    func loadNewsArticles(source: String) {
        interactor?.getNewsArticles(bySource: source)
    }
    
    func loadNewsArticles(category: String, country: String) {
        interactor?.getBusinessNewsArticles(byCategory: category, country: country)
    }
}

extension ArticlesViewPresenter: ArticlesInteractorToPresenterProtocol {
    
    func fetchedArticlesOnSuccess(newsArticles: [Article]) {
        view?.updateArticlesToView(articles: newsArticles)
    }
    
    func failedToFetchNewsArticles() {
        view?.failedToGetArticles()
    }
}
