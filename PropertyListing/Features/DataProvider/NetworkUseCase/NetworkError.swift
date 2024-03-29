//
//  NetworkError.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/9/21.
//

import Foundation

public enum NetworkError: Error {
    // Error cases
    case notAuthenticated
    case forbidden
    case notFound
    case networkProblem(Error)
    case unknown(HTTPURLResponse?)
    case userCancelled
    
    public var isAuthError: Bool {
        switch self {
        case .notAuthenticated: return true
        default: return false
        }
    }
    
    // MARK: - Initializers
    public init(error: Error) {
        self = .networkProblem(error)
    }
    
    public init(response: URLResponse?) {
        guard let response = response as? HTTPURLResponse else {
            self = .unknown(nil)
            return
        }
        switch response.statusCode {
        case NetworkError.notAuthenticated.statusCode: self = .notAuthenticated
        case NetworkError.forbidden.statusCode: self = .forbidden
        case NetworkError.notFound.statusCode: self = .notFound
        default: self = .unknown(response)
        }
    }
    
    public var statusCode: Int {
        switch self {
        case .notAuthenticated:  return 401
        case .forbidden:         return 403
        case .notFound:          return 404
        case .networkProblem: return 10001
        case .unknown:        return 10002
        case .userCancelled:     return 99999
        }
    }
}

// MARK: - Equatable
extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}
