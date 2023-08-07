//
//  News.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 04.08.2023.
//

import Foundation
// MARK: - Articles
struct Article: Codable, Identifiable{
    let id = UUID().uuidString
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
    
    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String
    }
}


//MARK: - ARTICLE DATA RESPONSE
struct ArticlesResponse: Decodable{
    let articels: [Article]
    enum CodingKeys: String, CodingKey{
        case articles
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articels = try container.decode([Article].self, forKey: .articles)
    }
}

