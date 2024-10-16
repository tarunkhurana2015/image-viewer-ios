//
//  
//  MockSearchRepository.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation

public struct MockSearchRepository: SearchRepositoryProtocol {
    public func getImages(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
        throw SearchError.unknown
    }
    
    // Implement the Mock Json fetch
}
