//
//  APIRequest.swift
//  News Explorer
//
//  Created by Yehor Nesterov on 05.08.2023.
//
// url: https://newsapi.org/v2/everything
// Api key: 077d02af1e534954a5e2e7a2432490f4


import Foundation

class APIRequest{
    //MARK: SHARED SINGLETON INSTANCE
    static let shared = APIRequest()
    
    //MARK: GETTING URL BY SERCHED THEME AND SORT TYPE
    func getUrl(sortBy: SortBy, searchedText: String) -> URL{
        var urlString: String{
            var string = "https://newsapi.org/v2/everything?q=\(searchedText)&sortBy=\(sortBy.rawValue)&apiKey=077d02af1e534954a5e2e7a2432490f4"
            return string
        }
        return URL(string: urlString)!
        
    }
}
