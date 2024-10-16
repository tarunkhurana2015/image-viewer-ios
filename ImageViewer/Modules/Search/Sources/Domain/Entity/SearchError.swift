//
//  
//  SearchError.swift
//  ImageViewer
//
//  Created by Tarun Khurana on 10/15/24.
//
//

import Foundation

public enum SearchError: Error {
    case unknown
    case noDataFound
    case urlNotFound
    case jsonDeocdingError
}
