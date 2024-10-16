//
//  File.swift
//  
//
//  Created by Tarun Khurana on 10/15/24.
//

import Foundation

protocol PixabayImageDecoderFactoryProtocol {
    func decodeImage<T: Decodable>(data: Data) async throws -> T
}

struct PixabayImageDecoderFactory: PixabayImageDecoderFactoryProtocol {
    public func decodeImage<T: Decodable>(data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw SearchError.jsonDeocdingError
        }
    }
}
