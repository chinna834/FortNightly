//
//  ArticlesViewController.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import UIKit

class ArticlesViewController: UIViewController, FNCustomNavigation {
        
    var presenter: ArticlesViewToPresenterProtocol?
    var newsArticles = [Article]()
    
    lazy var newsArticlesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: kNewsArticleCellIdentifier)
        tableView.register(ArticleHeaderView.self, forHeaderFooterViewReuseIdentifier: kArticleHeaderView)
        tableView.dataSource = self
        tableView.delegate = self
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
        newsArticles = articles
        newsArticlesTableView.reloadData()
    }
    
    func failedToGetArticles() {
        print("Unable to fetch Articles")
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kNewsArticleCellIdentifier) as? ArticleTableViewCell,
              let article = newsArticles[safe: indexPath.row]
              else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.configureCell(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kArticleHeaderView) as? ArticleHeaderView
        let firstIndexpath = IndexPath(row: 0, section: section)
        if let firstArticle = newsArticles[safe: firstIndexpath.row], let imageURL = firstArticle.urlToImage {
            header?.configureArticleImage(with: imageURL)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentNavigationController = navigationController, let selectedArticle = newsArticles[safe: indexPath.row] else { return }
        presenter?.didSelectedArticle(article: selectedArticle, navigationController: currentNavigationController)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
}

/**
 Determing the Scroll and Update the Navigation title Accordingly
 */
extension ArticlesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var offset: CGFloat = 0.0
        
        let targetHeight = Constants.kHeaderViewHeight + 64 //Overall Navigation Bar Height and Header View Height
        offset = scrollView.contentOffset.y / CGFloat(targetHeight)

        if offset > 1 {offset = 1}
        
        if offset > 0.5 {
            title = ""
            configureNavigationBarWithBrandedImage()
        } else {
            configureNavigationBarWithTextAttributes(title: "Front Page")
        }
    }
}
