//
//  ServerKeys.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

struct ServerKeys {
    
    //Base URL and common keys
    static let baseNewsAPIURL = "https://newsapi.org/"
    static let versionPath = "v2/"
    static let newsAPIKey = "cd572d30145d4957b39da7a689f39c26"
//    static let newsAPIKey = "f71af7261c434b5d8be60816ed910d8b" // -> Align Technology provided Key
    
    //Sorted keys
    static let sortByPopularityKey = "popularity"
    static let sortByPublishedAtKey = "publishedAt"
    
    //Sample Category keys
    static let categoryKey = "category"
    static let businessNewsCategoryKey = "business"
    
    //Sample Country key
    static let countryKey = "country"
    static let country_us = "us"
    
    //Sample Domain key
    static let wallStreetJournalKey = "wsj.com"
    
    //Sample Source key
    static let techcrunchSourceKey = "techcrunch"
    
    //API Paths
    static let everythingAboutPath = "everything?"
    static let topHeadlinesPath = "top-headlines?"
    static let sourcesPath = "sources"
    static let domainsPath = "domains"
    
}
