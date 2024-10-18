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
    
    public var shouldSucceed: Bool = true
    public var shouldBeEmpty: Bool = false
    public var shouldBeError: Bool = false
    
    public func getImages(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
        if shouldBeError {
            throw SearchError.noDataFound
        }
        if shouldSucceed {
            if let images = await JSONReader().loadJson(filename: "Images") {
                return images
            } else {
                throw SearchError.jsonDeocdingError
            }
        }
        if shouldBeEmpty {
            return []
        }
        throw SearchError.unknown
    }
}
