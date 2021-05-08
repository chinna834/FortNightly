//
//  ArticleModel.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

struct RawArticlesServerResponse: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

struct Source: Decodable {
    var id: String?
    var name: String?
}

struct Article: Decodable {
    
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?
    
}
