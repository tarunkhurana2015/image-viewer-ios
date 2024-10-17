import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    
    func test_Integration_NetworkURLSession_success() async throws {
        // Given
        let baseURL = "https://pixabay.com"
        let basePath = "/api?key=46538329-cc1bd35cc295c61648cf5e9e6&q=christmas&page=1&per_page=5"
        let networkSession = DefaultNetworkURLSession()
        let UrlRequest = URLRequest(url: URL(string: baseURL+basePath)!)
        
        // When
        let data = try await networkSession.request(UrlRequest)
        
        // Then
        XCTAssertTrue(!data.isEmpty) 
    }
    
}
