//
//  NewslineViewModel.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 04.08.2023.
//



import Foundation
import SwiftUI

final class NewslineViewModel: ObservableObject{
    @Published var allArticles: [Article] = []
    @Published var searchQuery = ""
    @Published var searchBy: SortBy = .popularity
    @Published var image: UIImage? = nil
    @Published var searchQueryIsEmpty: Bool = true
    private var url: URL? = nil
    private var trimmedSearchQuery: String {
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    
    
// MARK: RECEIVE API
    func searchArticle() async{
        let searchQuery = trimmedSearchQuery
        if searchQuery.isEmpty{
            return
        }
        do {
            let articles = try await NewsAPI.shared.search(for: searchQuery, sortBy: searchBy)
            await MainActor.run(body: {
                self.allArticles = articles
            })
        } catch{
            print(error)
        }
    }
}

//MARK: THE ORDER TO SORT THE ARTICLES IN
@frozen enum SortBy: String{
    case relevancy
    case popularity
    case publishedAt
}

