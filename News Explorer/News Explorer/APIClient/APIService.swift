//
//  APIService.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 04.08.2023.
//

import Foundation
import SwiftUI

struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "077d02af1e534954a5e2e7a2432490f4"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    
    func search(for query: String, sortBy: SortBy) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query, sortBy: sortBy))
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else{
            throw generateError(description: "An error occured")
        }
        let apiResponse = try jsonDecoder.decode(ArticlesResponse.self, from: data)
        return apiResponse.articels
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateSearchURL(from query: String, sortBy: SortBy) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/everything?"
        url += "q=\(percentEncodedString)"
        url += "&sortBy=\(sortBy.rawValue)"
        url += "&apiKey=\(apiKey)"

        return URL(string: url)!
    }
    
}
