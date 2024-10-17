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
        
        public init() {}
    }
    
    public enum Action {
        case viewAppeared
        case searchCleared
        case searchCancelled(oldEntities: [ImageEntity], searchTerm: String)
        case loadData(oldEntities: [ImageEntity], searchTerm: String)
        case loadedData(entity: [ImageEntity], searchTerm: String, morePagesAvailable: Bool)
        case loadNextPageData(oldEntities: [ImageEntity], searchTerm: String)
        case errorInLoadingData(error: Error, searchTerm: String)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                state.viewState = .appeared
                state.page = 1
                return .send(.loadData(oldEntities: [], searchTerm: ""))
            case .searchCleared:
                state.viewState = .appeared
                state.page = 1
                return .none
            case let .searchCancelled(oldEntities, _):
                state.viewState = .loaded(entities: oldEntities, morePagesAvailable: true)
                return .none
            case let .loadData(oldEntities, searchTerm):
                if oldEntities.isEmpty {
                    state.page = 1
                }
                let page = state.page
                if searchTerm.isEmpty {
                    state.viewState = .appeared
                    return .none
                }                
                return .run { send in
                    do {
                        let entities = try await useCaseSearch.execute(for: searchTerm.lowercased().replacingOccurrences(of: " ", with: "+"), page: page, per_page: 20)
                        let newEntities = oldEntities + entities // append the new page entities
                        await send(.loadedData(entity: newEntities, searchTerm: searchTerm, morePagesAvailable: true))
                    } catch {
                        if page == 1 { // error on loading the first page
                            await send(.errorInLoadingData(error: error, searchTerm: searchTerm))
                        } else { // error in loading any other page, don't show the error, just show the same data.
                            await send(.loadedData(entity: oldEntities, searchTerm: searchTerm, morePagesAvailable: false))
                        }
                    }
                }
            case let .loadedData(entities, _, morePagesAvailable):
                state.viewState = .loaded(entities: entities, morePagesAvailable: morePagesAvailable)
                return .none
            case let .loadNextPageData(oldEntities, searchTerm):
                state.page += 1 // increment the page count
                return .run { send in
                    try await Task.sleep(nanoseconds: 1_000_000)
                    await send(.loadData(oldEntities: oldEntities, searchTerm: searchTerm))
                }
            case let .errorInLoadingData(error, searchTerm):
                state.viewState = .error(error: error, searchTerm: searchTerm)
                return .none
            }
        }
    }
}


