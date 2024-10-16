//
//  File.swift
//  
//
//  Created by Tarun Khurana on 10/15/24.
//

import Foundation

protocol URLFactoryProtocol {
    func makeSearchURL(query: String, page: Int, per_page: Int) async -> URL?
}

struct PixabayURLFactory: URLFactoryProtocol {
    public func makeSearchURL(query: String, page: Int, per_page: Int) async -> URL? {
        return URL(string: 
                    PixabayAPI.baseURL + PixabayAPI.basePath +
                   "?" + PixabayAPI.apiKey + "&" +
                   PixabayAPI.searchQuery + query + "&" +
                   PixabayAPI.page + "\(page)" + "&" +
                   PixabayAPI.per_page + "\(per_page)"
        )
    }
}
