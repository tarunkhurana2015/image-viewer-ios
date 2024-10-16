//
//  
//  SearchDetailView.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import SwiftUI
import ComposableArchitecture

public struct SearchImageDetailView: View {
    
    let entity: ImageEntity
    public init(entity: ImageEntity) {
        self.entity = entity
    }
    
    public var body: some View {
        VStack {
            AsyncImage(url: entity.largeImageUrl) { image in
                VStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .transition(.opacity.animation(.easeIn))
                }
                    
            } placeholder: {
                Image("Placeholder", bundle: .module)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
            }            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
}

#Preview {
    let entity = ImageEntity(id: "1", previewImageUrl: URL(string: ""), previewWidth: 89, previewHeight: 150, largeImageUrl: URL(string: "https://pixabay.com/get/g5ccc7854877b25c6d82509570df8830b5b6699f4cfa477dab5650a4a7bf1bd85fcd04bdf211685af96ba7fbb06d4674b6d47acbd4e43360efc913e540a2470a0_1280.png"), tags: "christmas, xmas", postedBy: "tarunkhurana")
    return SearchImageDetailView(entity: entity)
}
