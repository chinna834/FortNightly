//
//  ArticlesViewController.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

class ArticlesViewController: UIViewController, FNCustomNavigation {
        
    var presenter: ArticlesViewToPresenterProtocol?
    var previousOffsetValue = false
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingViewTitleLabel: UILabel!
    @IBOutlet weak var loadingViewStatusLabel: UILabel!
    
    //Articles View Data Source
    lazy var datasource: ArticlesViewDataSource = {
        let datasource = ArticlesViewDataSource()
        datasource.delegate = self
        return datasource
    }()
    
    //Create News Articles Table View
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
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update View Color
        view.backgroundColor = .white

        //Configure Navigation
        title = "Front Page"
        configureNavigationBarWithTextAttributes(title: "Front Page")
        addCustomBackButtonToNavigationBar()
        
        //Configure Table View
        newsArticlesTableView.isHidden = true
        view.addSubview(newsArticlesTableView)
        addConstraintsToTableView()
                    
        //Load News Articles by Category
        presenter?.loadNewsArticles(category: ServerKeys.technologyNewsCategoryKey, country: ServerKeys.country_us)
    }
    
    //MARK: - Hook Table View to View Controller
    private func addConstraintsToTableView() {
        NSLayoutConstraint.activate([
            newsArticlesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            newsArticlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            newsArticlesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            newsArticlesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }
}

//MARK: - Display Articles on Table View
extension ArticlesViewController: ArticlesPresenterToViewProtocol {
    func updateArticlesToView(articles: [Article]) {
        loadingView.isHidden = true
        newsArticlesTableView.isHidden = false
        datasource.newsArticles = articles
        newsArticlesTableView.reloadData()
    }
    
    func failedToGetArticles() {
        newsArticlesTableView.isHidden = true
        loadingView.isHidden = false
        loadingViewTitleLabel.text = "Error!"
        loadingViewStatusLabel.text = "Unable to fetch Articles"
        print("Unable to fetch Articles")
    }
}

//MARK: - Data Source Events
extension ArticlesViewController: ArticlesViewDataSourceToView {
    func didSelectedArticle(selectedArticle: Article) {
        guard let currentNavigationController = navigationController else { return }
        presenter?.didSelectedArticle(article: selectedArticle, navigationController: currentNavigationController)
    }
    
    func headerArticleScrolledUp(value: Bool) {
        if value {
            title = ""
            configureNavigationBarWithBrandedImage()
            if !previousOffsetValue {
                newsArticlesTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            }
        }
        else {
            configureNavigationBarWithTextAttributes(title: "Front Page")
            if previousOffsetValue {
                newsArticlesTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
            }
        }
        previousOffsetValue = value
    }
}
