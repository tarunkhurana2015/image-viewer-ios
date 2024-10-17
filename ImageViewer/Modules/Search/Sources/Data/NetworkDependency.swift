//
//  File.swift
//  
//
//

import Foundation
import Dependencies
import Network

struct NetworkURLSessionKey: DependencyKey {
    
    static var liveValue: any NetworkURLSession = DefaultNetworkURLSession()    

}
extension DependencyValues {
    public var networkURLSession: NetworkURLSession {
        get { self[NetworkURLSessionKey.self] }
        set { self[NetworkURLSessionKey.self] = newValue }
    }
}
