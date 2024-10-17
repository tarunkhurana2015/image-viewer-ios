//
//  RepositoryTests.swift
//  
//
//  Created by Tarun Khurana on 10/16/24.
//

import XCTest
import Dependencies
@testable import Search
@testable import Network

final class RepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Repository_getImages_suceess() async throws {
        // Given
        let repository = withDependencies {
            $0.networkURLSession = MockNetworkURLSession()
        } operation: {
            SearchRepository()
        }
        let totalImagesCount = 5
        
        // When
        let images = try await repository.getImages(for: "christmas", page: 1, per_page: 5)
        
        // Then
        XCTAssertEqual(totalImagesCount, images.count)
    }
    
    func test_Repository_getImages_error() async throws {
        // Given
        let repository = withDependencies {
            $0.networkURLSession = MockNetworkURLSession(shouldBeError: true)
        } operation: {
            SearchRepository()
        }
        var networkError: NetworkError?
        // When
        do {
            _ = try await repository.getImages(for: "christmas", page: 1, per_page: 5)
        } catch {
            networkError = error as? NetworkError
        }
        
        // Then
        XCTAssertNotNil(networkError)
    }

}
