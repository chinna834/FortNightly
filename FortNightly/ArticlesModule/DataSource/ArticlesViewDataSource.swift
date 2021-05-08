//
//  ArticlesViewDataSource.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/8/21.
//

import Foundation

protocol ArticlesViewDataSourceToView: AnyObject {
    func didSelectedArticle(selectedArticle: Article)
    func headerArticleScrolledUp(value: Bool)
}

class ArticlesViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var newsArticles = [Article]()
    weak var delegate: ArticlesViewDataSourceToView?
    var offset: CGFloat = 0.0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kNewsArticleCellIdentifier) as? ArticleTableViewCell,
              let article = newsArticles[safe: indexPath.row]
              else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.configureCell(with: article, showImage: offset > 0.5)
        }
        else {
            cell.configureCell(with: article)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: kArticleHeaderView) as? ArticleHeaderView
        let firstIndexpath = IndexPath(row: 0, section: section)
        if let firstArticle = newsArticles[safe: firstIndexpath.row] {
            header?.configureArticleImage(with: firstArticle.urlToImage)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedArticle = newsArticles[safe: indexPath.row] else { return }
        delegate?.didSelectedArticle(selectedArticle: selectedArticle)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UITableViewHeaderFooterView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetHeight = Constants.kHeaderViewHeight + 64 //Overall Navigation Bar Height and Header View Height
        offset = scrollView.contentOffset.y / CGFloat(targetHeight)
        if offset > 1 { offset = 1 }
        if offset > 0.5 {
            delegate?.headerArticleScrolledUp(value: true)
        } else {
            delegate?.headerArticleScrolledUp(value: false)
        }
    }
}
