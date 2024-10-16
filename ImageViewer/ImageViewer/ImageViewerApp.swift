//
//  ImageViewerApp.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//

import SwiftUI
import Search
import ComposableArchitecture

@main
struct ImageViewerApp: App {
    var body: some Scene {
        WindowGroup {
            
                SearchImageView(store: Store(initialState: SearchImageViewReducer.State(), reducer: {
                    SearchImageViewReducer()
                }))
            
        }
    }
}
