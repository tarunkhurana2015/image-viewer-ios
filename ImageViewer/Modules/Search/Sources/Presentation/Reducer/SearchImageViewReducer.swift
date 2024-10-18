//
//  
//  SearchViewReducer.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation
import ComposableArchitecture
import Dependencies

@Reducer
public struct SearchImageViewReducer {
        
    @Dependency(\.useCaseSearch) var useCaseSearch
    
    public init() {}
    
    @ObservableState
    public struct State {
        
        public enum ViewState {
            case appeared
            case loading
            case loaded(entities: [ImageEntity], morePagesAvailable: Bool)
            case error(error: Error, searchTerm: String)
        }
        
        var viewState: ViewState = .appeared
        // Pagination support
        var page: Int = 1
        // search term
        var lastSearchTerm: String = ""
        
        public init() {}
    }
    
    public enum Action {
        case viewAppeared
        case searchCleared
        case searchCancelled(oldEntities: [ImageEntity])
        case loadData(oldEntities: [ImageEntity], searchTerm: String)
        case loadedData(entity: [ImageEntity], searchTerm: String, morePagesAvailable: Bool)
        case loadNextPageData(oldEntities: [ImageEntity], searchTerm: String)
        case errorInLoadingData(error: Error, searchTerm: String)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared: // View Appeared Action (reset the initial values)
                state.viewState = .appeared
                state.page = 1
                state.lastSearchTerm = ""
                return .send(.loadData(oldEntities: [], searchTerm: ""))
            case .searchCleared: // When the search box clear button is clicked (reset the values)
                state.viewState = .appeared
                state.page = 1
                state.lastSearchTerm = ""
                return .none
            case let .searchCancelled(oldEntities): // when the cancel button is pressed (load the data with the old entities and preserver the search term)
                return .send(.loadData(oldEntities: oldEntities, searchTerm: state.lastSearchTerm))
            case let .loadData(oldEntities, searchTerm): // load data from network
                if oldEntities.isEmpty {
                    state.page = 1
                }
                let page = state.page
                if searchTerm.isEmpty {
                    state.viewState = .appeared
                    return .none
                }                
                state.lastSearchTerm = searchTerm
                return .run { send in
                    do {
                        let entities = try await useCaseSearch.execute(for: searchTerm.lowercased().replacingOccurrences(of: " ", with: "+"), page: page, per_page: 20)
                        let newEntities = oldEntities + entities // append the new page entities
                        await send(.loadedData(entity: newEntities, searchTerm: searchTerm, morePagesAvailable: true)) // still more pages can be downloaded
                    } catch {
                        if page == 1 { // error on loading the first page
                            await send(.errorInLoadingData(error: error, searchTerm: searchTerm)) // error occured
                        } else { // error in loading any other page, don't show the error, just show the same data.
                            await send(.loadedData(entity: oldEntities, searchTerm: searchTerm, morePagesAvailable: false)) // no more pages can be downloaded
                        }
                    }
                }
            case let .loadedData(entities, _, morePagesAvailable): // loaded data from network
                state.viewState = .loaded(entities: entities, morePagesAvailable: morePagesAvailable)
                return .none
            case let .loadNextPageData(oldEntities, searchTerm): // load next page from network
                state.page += 1 // increment the page count
                let newSearchTerm = searchTerm.isEmpty ? state.lastSearchTerm : searchTerm
                return .run { send in
                    await send(.loadData(oldEntities: oldEntities, searchTerm: newSearchTerm))
                }
            case let .errorInLoadingData(error, searchTerm):
                state.viewState = .error(error: error, searchTerm: searchTerm)
                return .none
            }
        }
    }
}


