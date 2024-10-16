//
//  
//  DomainToDataDepedencyInversion.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation
import Dependencies

enum SearchRepositoryKey: DependencyKey {
    static var liveValue: any SearchRepositoryProtocol = SearchRepository()
    static var testValue: any SearchRepositoryProtocol = MockSearchRepository()
    static var previewValue: any SearchRepositoryProtocol = PreviewSearchRepository()
}

extension DependencyValues {
    public var repositorySearch: SearchRepositoryProtocol {
        get { self[SearchRepositoryKey.self] }
        set { self[SearchRepositoryKey.self] = newValue }
    }
}
