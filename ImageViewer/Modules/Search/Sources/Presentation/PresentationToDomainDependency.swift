//
//  
//  PresentationToDomainDependency.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation
import Dependencies

enum SearchUsecaseCaseKey: DependencyKey {
    static var liveValue: SearchUseCase = SearchUseCaseImpl()
    static var testValue: SearchUseCase = SearchUseCaseImpl()
}
extension DependencyValues {
    var useCaseSearch: SearchUseCase {
        get { self[SearchUsecaseCaseKey.self] }
        set { self[SearchUsecaseCaseKey.self] = newValue }
    }
}
