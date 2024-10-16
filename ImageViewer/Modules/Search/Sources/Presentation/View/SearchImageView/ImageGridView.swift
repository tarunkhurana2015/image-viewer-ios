//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 10/15/24.
//

import SwiftUI

struct ImageGridView: View {
    
    let imageEntity: ImageEntity
    init(imageEntity: ImageEntity) {
        self.imageEntity = imageEntity
    }
    
    @ViewBuilder
    var body: some View {
        VStack {
            AsyncImage(url: imageEntity.previewImageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(CGFloat(imageEntity.previewWidth) / CGFloat(imageEntity.previewHeight), contentMode: .fit)
                    .transition(.opacity.animation(.easeIn))
            } placeholder: {
                Image("Placeholder", bundle: .module)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxHeight: 500)
            }
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 10.0))
        .shadow(color: .black, radius: 5)
        //.clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

//#Preview {
//    SwiftUIView()
//}
