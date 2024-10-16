//
//  
//  SearchEntity.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation

public struct ImageEntity: Hashable, Identifiable {
    
    public let id: Int
    let previewImageUrl: URL?
    let previewWidth: Int
    let previewHeight: Int
    let largeImageUrl: URL?
    let tags: String
    let postedBy: String
}
