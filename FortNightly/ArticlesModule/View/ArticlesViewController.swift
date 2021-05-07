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
    
    var newsArticlesTableView: UITableView = UITableView(frame: CGRect.zero)
    
    private func createSongsTableView() {
        newsArticlesTableView.translatesAutoresizingMaskIntoConstraints = false
        newsArticlesTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: kNewsArticleCellIdentifier)
        newsArticlesTableView.dataSource = self
        newsArticlesTableView.delegate = self
        newsArticlesTableView.estimatedRowHeight = 150
        newsArticlesTableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(newsArticlesTableView)
    }
    
    private func addConstraintsToTableView() {
        NSLayoutConstraint.activate([
            newsArticlesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            newsArticlesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            newsArticlesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            newsArticlesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
    }

    override func loadView() {
        super.loadView()
        
        //Update View Color
        view.backgroundColor = .white

        //Configure Navigation
        title = "Front Page"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Configure Table View
        createSongsTableView()
        addConstraintsToTableView()
            
        //Load News Articles
        presenter?.loadNewsArticles(source: ServerKeys.techcrunchSourceKey)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        cell.configureCell(with: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel()
    }
}
