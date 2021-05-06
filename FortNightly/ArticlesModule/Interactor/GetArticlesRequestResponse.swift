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
                response.articlesResponse = try JSONDecoder().decode(RawArticlesServerResponse.self, from: data)
            } catch {
                print(error)
            }
        }
        else {
            let err = FNError(description: Constants.commonError, responseCode: 0, error: nil)
            response.error = err
        }
        
        return response
    }
    
}
