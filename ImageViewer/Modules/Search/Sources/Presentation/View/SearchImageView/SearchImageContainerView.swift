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
    
    private let adaptiveColumn = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    private let singleColumn = [
           GridItem(.flexible()),
       ]
    
    var body: some View {
        VStack {
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
                    ImageGridView(imageEntity: entity)
                }
            }.padding()
            LazyVGrid(columns: singleColumn, spacing: 50) {
                VStack() {
                    HStack{
                        Spacer()
                        ProgressView {
                            Text("Loading...\(store.page)")
                                .font(.caption)
                        }
                        .onAppear { // on display of the progress view, load the next page
                            store.send(.loadNextPageData(oldEntities: entities, searchTerm: searchTerm))
                        }
                        Spacer()
                    }
                }
            }.padding()
        }
        .onChange(of: isSearching, perform: { newValue in
            if !newValue {
                store.send(.loadData(oldEntities: entities, searchTerm: searchTerm))
            }
        })
    }
}
