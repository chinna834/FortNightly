//
//  ArticlesViewController.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

class ArticlesViewController: UIViewController, FNCustomNavigation {
        
    var presenter: ArticlesViewToPresenterProtocol?
    
    lazy var datasource: ArticlesViewDataSource = {
        let datasource = ArticlesViewDataSource()
        datasource.delegate = self
        return datasource
    }()
    
    lazy var newsArticlesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: kNewsArticleCellIdentifier)
        tableView.register(ArticleHeaderView.self, forHeaderFooterViewReuseIdentifier: kArticleHeaderView)
        tableView.dataSource = datasource
        tableView.delegate = datasource
        tableView.estimatedRowHeight = 150
        tableView.estimatedSectionHeaderHeight = Constants.kHeaderViewHeight
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func loadView() {
        super.loadView()
        
        //Update View Color
        view.backgroundColor = .white

        //Configure Navigation
        title = "Front Page"
        configureNavigationBarWithTextAttributes(title: "Front Page")
        
        //Configure Table View
        view.addSubview(newsArticlesTableView)
        addConstraintsToTableView()
                    
        //Load News Articles by Category
        presenter?.loadNewsArticles(category: ServerKeys.businessNewsCategoryKey, country: ServerKeys.country_us)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func addConstraintsToTableView() {
        NSLayoutConstraint.activate([
            newsArticlesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            newsArticlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            newsArticlesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            newsArticlesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }
}

extension ArticlesViewController: ArticlesPresenterToViewProtocol {
    func updateArticlesToView(articles: [Article]) {
        datasource.newsArticles = articles
        newsArticlesTableView.reloadData()
    }
    
    func failedToGetArticles() {
        print("Unable to fetch Articles")
    }
}

extension ArticlesViewController: ArticlesViewDataSourceToView {
    func didSelectedArticle(selectedArticle: Article) {
        guard let currentNavigationController = navigationController else { return }
        presenter?.didSelectedArticle(article: selectedArticle, navigationController: currentNavigationController)
    }
    
    func headerArticleScrolledUp(value: Bool) {
        if value {
            title = ""
            configureNavigationBarWithBrandedImage()
        }
        else {
            configureNavigationBarWithTextAttributes(title: "Front Page")
        }
    }
}
