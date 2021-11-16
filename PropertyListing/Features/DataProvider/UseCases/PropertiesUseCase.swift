//
//  PropertyUseCase.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/13/21.
//

import Foundation
import Combine

protocol PropertiesUseCase {
    func fetchProperties(page: Int, perPage: Int) -> AnyPublisher<Result<PropertyResponseModel, Error>, Never>
    func fetchPropertyDetails(propertyId: String) -> AnyPublisher<Result<Property, Error>, Never>
}
