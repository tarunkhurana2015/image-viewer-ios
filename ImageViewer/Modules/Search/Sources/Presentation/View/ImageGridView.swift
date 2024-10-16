//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 10/15/24.
//

import SwiftUI
import CachedAsyncImage

struct ImageGridView: View {
    
    let imageEntity: ImageEntity
    init(imageEntity: ImageEntity) {
        self.imageEntity = imageEntity
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    @ViewBuilder
    var body: some View {
        VStack {
            CachedAsyncImage(url: imageEntity.previewImageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .transition(.opacity.animation(.easeIn))
            } placeholder: {
                Image("Placeholder", bundle: .module)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxHeight: 150)
            }
            
            // adding a fixed width / height as the images are not consistent in size
            .frame(width: 150, height: 150)
            HStack {
                VStack(alignment: .leading) {
                    Text(imageEntity.tags)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    Text(imageEntity.postedBy)
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
                .frame(height: 20,alignment: .topLeading)
                .padding()
                Spacer()
            }
        }
        .background(colorScheme == .dark ? .black : .white, in: RoundedRectangle(cornerRadius: 5))
        .clipShape(RoundedRectangle(cornerRadius: 5, style: .circular))
        .shadow(color: colorScheme == .dark ? .white : .black, radius: 1)
        
    }
}

#Preview {
    let entity = ImageEntity(id: "1", previewImageUrl: URL(string: "https://pixabay.com/get/g5ccc7854877b25c6d82509570df8830b5b6699f4cfa477dab5650a4a7bf1bd85fcd04bdf211685af96ba7fbb06d4674b6d47acbd4e43360efc913e540a2470a0_1280.png"), previewWidth: 89, previewHeight: 150, largeImageUrl: URL(string: ""), tags: "christmas, xmas", postedBy: "tarunkhurana")
    return ImageGridView(imageEntity: entity)
}
