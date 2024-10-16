//
//  
//  PreviewSearchEntityRepository.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation

public struct PreviewSearchRepository: SearchRepositoryProtocol {
    public func getImages(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
        throw SearchError.unknown
    }
}
