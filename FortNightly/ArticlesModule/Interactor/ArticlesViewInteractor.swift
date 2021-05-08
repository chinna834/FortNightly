//
//  ArticlesViewInteractor.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

class ArticlesViewInteractor: ArticlesPresenterToInteractorProtocol {
    
    weak var presenter: ArticlesInteractorToPresenterProtocol?
    
    /**
     Common method to send a commonrequest for any kind of News articles
     */
    private func sendCommonRequestForNewsArticles(requestObject: GetNewsArticlesRequest) {
        NetworkManager().send(r: requestObject) { [weak self] (success, response, error) in
            if success {
                guard let articles = response?.articlesResponse?.articles else {
                    self?.presenter?.failedToFetchNewsArticles()
                    return
                }
                self?.presenter?.fetchedArticlesOnSuccess(newsArticles: articles)
            }
            else {
                self?.presenter?.failedToFetchNewsArticles()
            }
        }
    }
    
    /// Get Top news article from the source
    /// - parameter bySource: Provide a source to get the news from
    func getNewsArticles(bySource: String) {
        let requestObject = GetNewsArticlesRequest(topHeadlinesBySource: bySource)
        sendCommonRequestForNewsArticles(requestObject: requestObject)
    }
    
    
    /// Get Top news Articles by Category.
    /// - parameter byCategory: Category of a choice. Example: 'Business' category would give the news on Business
    /// - parameter country: Country of a choice. Example: 'US' country gives all the category news in the country
    func getBusinessNewsArticles(byCategory: String, country: String) {
        let requestObject = GetNewsArticlesRequest(topHeadlinesByCategory: byCategory, country: country)
        sendCommonRequestForNewsArticles(requestObject: requestObject)
    }
}
