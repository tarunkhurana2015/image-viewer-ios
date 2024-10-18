import XCTest
import Foundation
import ComposableArchitecture
import Dependencies
@testable import Search


extension SearchImageViewReducer.State: Equatable {
    public static func == (lhs: SearchImageViewReducer.State, rhs: SearchImageViewReducer.State) -> Bool {
        return true
    }
}
@MainActor
final class ReducerTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Reducer_Action_Appeared() async throws {
        // Given
        let store = TestStore(initialState: SearchImageViewReducer.State()) {
            SearchImageViewReducer()
        }
        // When
        await store.send(.viewAppeared)
        
        // Then
        await store.receive(\.loadData)
    }
    
    func test_Reducer_Action_searchCleared() async throws {
        // Given
        let store = TestStore(initialState: SearchImageViewReducer.State()) {
            SearchImageViewReducer()
        }
        // When
        await store.send(.searchCleared)
        
    }
    
    func test_Reducer_Action_searchCancelled() async throws {
        // Given
        let store = TestStore(initialState: SearchImageViewReducer.State()) {
            SearchImageViewReducer()
        }
        let entity = ImageEntity(id: "1", previewImageUrl: URL(string: "https://pixabay.com/get/g5ccc7854877b25c6d82509570df8830b5b6699f4cfa477dab5650a4a7bf1bd85fcd04bdf211685af96ba7fbb06d4674b6d47acbd4e43360efc913e540a2470a0_1280.png"), previewWidth: 89, previewHeight: 150, largeImageUrl: URL(string: ""), tags: "christmas, xmas", postedBy: "tarunkhurana")
        // When
        await store.send(.searchCancelled(oldEntities: [entity]))
        
        // Then
        await store.receive(\.loadData)
    }
    
    func test_Reducer_Action_loadData() async throws {
        // Given
        let store = TestStore(initialState: SearchImageViewReducer.State()) {
            SearchImageViewReducer()
        }

        // When
        await store.send(.loadData(oldEntities: [], searchTerm: "christmas"))
        
        // Then
        await store.receive(\.loadedData)
    }
    
    func test_Reducer_Action_loadedData() async throws {
        // Given
        let store = TestStore(initialState: SearchImageViewReducer.State()) {
            SearchImageViewReducer()
        }

        // When
        await store.send(.loadedData(entity: [], searchTerm: "christmas", morePagesAvailable: true))
        
        // Then
        
    }
    
}
