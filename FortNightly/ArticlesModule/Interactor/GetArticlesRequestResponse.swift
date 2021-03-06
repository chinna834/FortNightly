//
//  GetArticlesRequestResponse.swift
//  FortNightly
//
//  Created by Chinna Addepally on 5/6/21.
//

import Foundation

struct GetNewsArticlesRequest: RequestObject {    

    typealias response = GetNewsArticlesResponse
    
    var host: String = ServerKeys.baseNewsAPIURL + ServerKeys.versionPath
    var path: String
    var url: URL?
    var body: [[String: Any]]?
    var method: String = HTTPMethod.get.rawValue
    var header: [[String : Any]]?

    /**
     Construct the URL request to get the News Articles By a top source
     */
    init(topHeadlinesBySource: String) {
        
        let headlinesPath = "\(ServerKeys.topHeadlinesPath)\(ServerKeys.sourcesPath)=\(topHeadlinesBySource)"
        let apiKeyPath = "&apiKey=\(ServerKeys.newsAPIKey)"
        
        path = headlinesPath + apiKeyPath
        url = URL(string: host + path)
    }
    
    /**
     Construct the URL request to get the top headlines in the business category
     */
    init(topHeadlinesByCategory: String, country: String) {
        let headlinesPath = "\(ServerKeys.topHeadlinesPath)\(ServerKeys.countryKey)=\(country)&\(ServerKeys.categoryKey)=\(topHeadlinesByCategory)"
        let apiKeyPath = "&apiKey=\(ServerKeys.newsAPIKey)"
        
        path = headlinesPath + apiKeyPath
        url = URL(string: host + path)
    }
}

struct GetNewsArticlesResponse: DecodableResponse {
    
    var articlesResponse: RawArticlesServerResponse?
    var error: FNError?
    
    /**
     Parse the articles response using decodable protocol
     */
    static func parse(data: Data, success: Bool) -> GetNewsArticlesResponse? {
        
        var response = GetNewsArticlesResponse()
        
        if success {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(Utilities().getDateFormatter())
                response.articlesResponse = try decoder.decode(RawArticlesServerResponse.self, from: data)
            } catch {
                response.error = FNError(description: Constants.commonError, responseCode: 0, error: error)
            }
        }
        else {
            response.error = FNError(description: Constants.commonError, responseCode: 0, error: nil)
        }
        
        return response
    }
    
}
