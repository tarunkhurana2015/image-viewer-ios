//
//  SwiftUIView.swift
//
//
//  Created by Tarun Khurana on 10/15/24.
//

import SwiftUI
import ComposableArchitecture
import Dependencies


struct SearchImageContainerView: View {
    
    let store: StoreOf<SearchImageViewReducer>
    @Environment(\.isSearching) var isSearching
    @Binding var searchTerm: String
    let entities: [ImageEntity]
    let morePagesAvailable: Bool
    
    private let adaptiveColumn: [GridItem] = Array(repeating: .init(.adaptive(minimum: 120), spacing: 15), count: 2)
    
    
    private let singleColumn = [
           GridItem(.flexible()),
       ]
    @State var moveToTopIndicator: Bool = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(searchTerm) Images").id("searchimages")
                            .padding(.leading)
                            .font(.title2)
                            .fontWidth(.condensed)
                            .foregroundColor(.secondary)
                            .frame(alignment: .leading)
                        Spacer()
                    }
                    LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                        ForEach(entities, id: \.id) { entity in
                            NavigationLink(value: entity) {
                                ImageGridView(imageEntity: entity)
                            }
                        }
                    }.padding()
                        .navigationDestination(for: ImageEntity.self) { entity in
                            SearchImageDetailView(entity: entity)
                        }
                    LazyVGrid(columns: singleColumn, spacing: 50) {
                        VStack() {
                            HStack{
                                Spacer()
                                if morePagesAvailable {
                                    ProgressView {
                                        Text("Loading...\(store.page)")
                                            .font(.caption)
                                    }
                                    .onAppear { // on display of the progress view, load the next page
                                        store.send(.loadNextPageData(oldEntities: entities, searchTerm: searchTerm))
                                    }
                                }
                                Spacer()
                            }
                        }
                    }.padding()
                }
            }
            .onChange(of: moveToTopIndicator) { _ in
                proxy.scrollTo("searchimages")
            }
        }
    }
}
