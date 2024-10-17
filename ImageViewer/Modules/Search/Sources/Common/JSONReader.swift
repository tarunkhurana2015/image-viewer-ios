//
//  File.swift
//  
//
//  Created by Tarun Khurana on 10/16/24.
//

import Foundation

struct JSONReader {
    func loadJson(filename fileName: String) async -> [ImageEntity]? {
        if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ImageResponse.self, from: data)
                return jsonData.hits.map {
                    ImageEntity(id: "\($0.id)", previewImageUrl: URL(string: $0.previewURL), previewWidth: $0.imageWidth, previewHeight: $0.imageHeight, largeImageUrl: URL(string: $0.largeImageURL), tags: $0.tags, postedBy: $0.user)
                }
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
