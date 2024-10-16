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
    @State var searchTerm: String = ""
    
    public init(store: StoreOf<SearchImageViewReducer>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            VStack {
                switch store.viewState {
                case .appeared:
                    VStack(alignment: .leading) {
                        Text("Type in the search box to find images")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                case .loading:
                    VStack() {
                        Text("Loading...")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxHeight: .infinity, alignment: .center)
                    }
                case let .loaded(entities, morePagesAvailable):
                    
                    VStack {
                        SearchImageContainerView(store: store, searchTerm: $searchTerm, entities: entities, morePagesAvailable: morePagesAvailable)
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
        }
        .searchable(text: $searchTerm, prompt: "Search for Images")
        .onChange(of: searchTerm, perform: { newValue in
            if newValue.isEmpty { // search text is cleared
                store.send(.searchCleared)
            } else {
                store.send(.loadData(oldEntities: [], searchTerm: newValue))
            }
        })
    }
}

#Preview {
    SearchImageView(store: Store(initialState: SearchImageViewReducer.State(), reducer: {
        SearchImageViewReducer()
    }))
}
