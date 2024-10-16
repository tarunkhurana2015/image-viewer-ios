//
//  
//  SearchView.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct SearchImageView: View {
    
    let store: StoreOf<SearchImageViewReducer>
    @State var moveToTopIndicator: Bool = false
    @State var searchTerm: String = ""
        
    public init(store: StoreOf<SearchImageViewReducer>) {
        self.store = store
    }
        
    public var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        switch store.viewState {
                        case .appeared:
                            VStack(alignment: .center) {
                                Text("Type in the search box to find images")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }
                        case .loading:
                            VStack(alignment: .center) {
                                Text("Loading...")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }
                        case let .loaded(entities):
                            VStack {
                                SearchImageContainerView(store: store, searchTerm: $searchTerm, entities: entities)
                            }
                            
                        case let .error(error, searchTerm):
                            if (error as? SearchError) == .noDataFound {
                                HStack {
                                    Text("Images Not Found for term - ")
                                        .font(.headline)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                    Text("\(searchTerm)")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                }
                            } else {
                                Text("Error: \(error.localizedDescription)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxHeight: .infinity, alignment: .center)
                            }
                        }
                    }
                    .navigationTitle("Search")
                    .onFirstAppear {
                        store.send(.viewAppeared)
                    }
                    .onChange(of: moveToTopIndicator) { _ in
                        proxy.scrollTo("searchimages")
                    }
                }
            }
        }
        .searchable(text: $searchTerm, prompt: "Search for Images")
        .onChange(of: searchTerm) { newValue in
            if newValue.isEmpty { // search text box is cleared
                store.send(.searchCleared)
            } else {
                store.send(.loadData(oldEntities: [], searchTerm: newValue))
            }
        }
    }
}

//#Preview {
//SearchView(
//        store: Store(initialState: SearchViewReducer.State()) {
//        SearchViewReducer()
//        }
//    )
//}
