//
//  NetworkPropertyUseCase.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/13/21.
//

import Foundation
import Combine

final class NetworkPropertiesUseCase: PropertiesUseCase {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
        
    func fetchProperties(page: Int, perPage: Int) -> AnyPublisher<Result<PropertyResponseModel, Error>, Never> {
        return networkService
            .load(Resource<PropertyResponseModel>.properties(query: APIURLs.propertiesUrl, page:page, perPage: perPage ))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<PropertyResponseModel, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func fetchPropertyDetails(propertyId: String) -> AnyPublisher<Result<Property, Error>, Never> {
        let resource = Resource<PropertyDetailResponseModel>.propertyDetails(propertyId: propertyId)
        return networkService
            .load(resource)
            .map { .success($0.data) }
            .catch { error -> AnyPublisher<Result<Property, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
}
