//
//  
//  SearchUsecase.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation
import Dependencies

protocol SearchUseCase {
    func execute(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity]
}

public struct SearchUseCaseImpl: SearchUseCase {
    
    // MARK: Depdency Inversion Principle
    /*
     NOTES:
     - high level modules should not depend on the low level modules, but should depdend on the abstraction
     - If a high level module depends on the low level module then the code becomes tightly coupled.
     - Changes in one class should not break another class.

     */
    /// Domain Layer <- Data Repositories Layer
    @Dependency(\.repositorySearch) var repositorySearch
    
    func execute(for query: String, page: Int, per_page: Int) async throws -> [ImageEntity] {
        try await repositorySearch.getImages(for: query, page: page, per_page: per_page)
    }
}
