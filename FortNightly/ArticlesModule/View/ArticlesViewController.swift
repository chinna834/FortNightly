//
//  ArticlesViewController.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    var presenter: ArticlesViewToPresenterProtocol?
    var newsArticles = [Article]()

    override func loadView() {
        super.loadView()
            
        presenter?.loadNewsArticles(source: ServerKeys.techcrunchSourceKey)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
    }
}

extension ArticlesViewController: ArticlesPresenterToViewProtocol {
    
    func updateArticlesToView(articles: [Article]) {
        newsArticles = articles
        print(newsArticles.count)
    }
    
    func failedToGetArticles() {
        print("Unable to fetch Articles")
    }
}
