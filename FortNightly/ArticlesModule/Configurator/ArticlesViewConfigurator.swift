//
//  Configurator.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

protocol ArticlesViewToPresenterProtocol: AnyObject {
    var view: ArticlesPresenterToViewProtocol? { get set }
    var interactor: ArticlesPresenterToInteractorProtocol? { get set }
    var router: ArticlesPresenterToRouterProtocol? { get set }
    func loadNewsArticles(source: String)
    func loadNewsArticles(category:String, country: String)
}

protocol ArticlesPresenterToViewProtocol: AnyObject {
    func updateArticlesToView(articles: [Article])
    func failedToGetArticles()
}

protocol ArticlesPresenterToInteractorProtocol: AnyObject {
    var presenter: ArticlesInteractorToPresenterProtocol? { get set }
    func getNewsArticles(bySource: String)
    func getBusinessNewsArticles(byCategory: String, country: String)
}

protocol ArticlesInteractorToPresenterProtocol: AnyObject {
    func fetchedArticlesOnSuccess(newsArticles: [Article])
    func failedToFetchNewsArticles()
}

protocol ArticlesPresenterToRouterProtocol: AnyObject {
    static func createArticlesViewModule() -> ArticlesViewController
}
