//
//  File.swift
//  
//
//  Created by Tarun Khurana on 10/15/24.
//

/// ImageRemoteModel - Direct mapping model with the api response
import Foundation

struct ImageResponse: Decodable {
    let total: Int
    let totalHits: Int
    let hits: [ImageRemoteModel]
}
struct ImageRemoteModel: Decodable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let previewWidth: Int
    let previewHeight: Int
    let webformatURL: String
    let webformatWidth: Int
    let webformatHeight: Int
    let previewURL: String
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
    let user_id: Int
    let user: String
    let userImageURL: String
}
