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

public struct SearchDetailView: View {
    
    let entity: ImageEntity
    public init(entity: ImageEntity) {
        self.entity = entity
    }
    
    public var body: some View {
        VStack {
                Text("\(entity)")
        }
    }
}

//#Preview {
//SearchDetailView(entity: ImageEntity(id: 0, url: ""))
//}
