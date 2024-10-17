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
    
    public var shouldSucceed: Bool = false
    public var shouldBeEmpty: Bool = false
    public var shouldBeError: Bool = false
    
    public func getImages(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
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
        if shouldBeError {
            throw SearchError.noDataFound
        }
        throw SearchError.unknown
    }
}
