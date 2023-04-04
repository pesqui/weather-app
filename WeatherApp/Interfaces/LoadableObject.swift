//
//  LoadableObject.swift
//  WeatherApp
//
//  Created by César Augusto Batista Santos on 23/02/23.
//

import Foundation

public enum LoadableObject<ObjectType, ErrorType>: Equatable where ObjectType: Equatable, ErrorType: Error {
    case initial
    case loading
    case loaded(ObjectType)
    case failure(ErrorType)
    
    public static func == (lhs: LoadableObject<ObjectType, ErrorType>, rhs: LoadableObject<ObjectType, ErrorType>) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial), (.loading, .loading), (.failure, .failure):
            return true
        case (.loaded(let lhsObject), .loaded(let rhsObject)):
            return lhsObject == rhsObject
        default:
            return false
        }
    }
}
