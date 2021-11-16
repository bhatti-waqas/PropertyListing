//
//  PropertiesUseCaseMock.swift
//  PropertyListingTests
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import XCTest
import Combine
@testable import PropertyListing

class PropertiesUseCaseMock: PropertiesUseCase {
    var fetchPropertiesWithReturnValue: AnyPublisher<Result<PropertyResponseModel, Error>, Never>!
    var fetchPropertyDetailsReturnValue: AnyPublisher<Result<Property, Error>, Never>!
    
    func fetchProperties(page: Int, perPage: Int) -> AnyPublisher<Result<PropertyResponseModel, Error>, Never> {
        return fetchPropertiesWithReturnValue
    }
    
    func fetchPropertyDetails(propertyId: String) -> AnyPublisher<Result<Property, Error>, Never> {
        return fetchPropertyDetailsReturnValue
    }
}
