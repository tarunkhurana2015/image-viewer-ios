//
//  
//  SearchRepository.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation
import Dependencies

public struct SearchRepository: SearchRepositoryProtocol {
    
    @Dependency(\.networkURLSession) var networkURLSession
    
    public func getImages(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
        do {
            guard let url = await PixabayURLFactory().makeSearchURL(query: query, page: page, per_page: per_page) else {
                throw SearchError.urlNotFound
            }
            let request = URLRequest(url: url)
            let data = try await networkURLSession.request(request)
            let imageData: ImageResponse = try await PixabayImageDecoderFactory().decodeImage(data: data)
            if imageData.hits.isEmpty {
                throw SearchError.noDataFound
            }
            return imageData.hits.map {
                ImageEntity(id: UUID().uuidString, previewImageUrl: URL(string: $0.previewURL), previewWidth: $0.previewWidth, previewHeight: $0.previewHeight, largeImageUrl: URL(string: $0.largeImageURL), tags: $0.tags, postedBy: $0.user)
            }
            
        } catch {
            throw error
        }
    }
}
