//
//  ArticlesViewInteractor.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

class ArticlesViewInteractor: ArticlesPresenterToInteractorProtocol {
    
    weak var presenter: ArticlesInteractorToPresenterProtocol?
    
    func getNewsArticles(bySource: String) {
        
        let requestObject = GetNewsArticlesRequest(topHeadlinesBySource: bySource)
        
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
    
    
}
