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
    
    private let adaptiveColumn = [
        GridItem(.flexible(), spacing: 15, alignment: .bottom),
        GridItem(.flexible(), spacing: 15, alignment: .bottom)
    ]
    
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
                            ImageGridView(imageEntity: entity)
                        }
                    }.padding()
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
