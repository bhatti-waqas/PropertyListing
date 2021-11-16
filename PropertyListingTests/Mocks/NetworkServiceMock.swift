//
//  NetworkServiceMock.swift
//  PropertyListingTests
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import XCTest
import Combine
@testable import PropertyListing

class NetworkServiceMock: NetworkServiceProtocol {
    var responses = [String:Any]()
    
    func load<T>(_ resource: Resource<T>) -> AnyPublisher<T, Error> {
        if let response = responses[resource.url.path] as? T {
            return .just(response)
        } else if let error = responses[resource.url.path] as? NetworkLayerError {
            return .fail(error)
        } else {
            return .fail(NetworkLayerError.invalidRequest)
        }
    }
}
