//
//  UsecaseTests.swift
//  
//
//  Created by Tarun Khurana on 10/16/24.
//

import XCTest
import Dependencies
@testable import Search

final class UsecaseTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Usecase_execute_shouldSucceed() async throws {
        // Given
        let userCase = withDependencies {
            $0.repositorySearch = MockSearchRepository(shouldSucceed: true)
        } operation: {
            SearchUseCaseImpl()
        }

        let totalImagesCount = 5
        
        // When
        let images = try await userCase.execute(for: "christmas", page: 1, per_page: 5)
        
        // Then
        XCTAssertEqual(totalImagesCount, images.count)

    }
    
    func test_Usecase_execute_shouldError() async throws {
        // Given
        let userCase = withDependencies {
            $0.repositorySearch = MockSearchRepository(shouldBeError: true)
        } operation: {
            SearchUseCaseImpl()
        }
        var errorSearch: SearchError?
        // When
        do {
            _ = try await userCase.execute(for: "christmas", page: 1, per_page: 5)
        } catch {
            errorSearch = error as? SearchError
        }
        
        // Then
        XCTAssertEqual(errorSearch, SearchError.noDataFound)

    }
    
}
