//
//  PropertyDetailViewModel.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/14/21.
//

import Foundation
import Combine

enum PropertiesDetailViewModelState: Equatable {
    case success
    case failure(String)
}

final class PropertyDetailViewModel {
    private let useCase: PropertiesUseCase
    private let navigator: ListingNavigator
    private let propertyId: String
    private var property: Property? = nil
    /// define immutable `stateDidUpdate` property so that subscriber can only read from it.
    private(set) lazy var stateDidUpdate = stateDidUpdateSubject.eraseToAnyPublisher()
    private let stateDidUpdateSubject = PassthroughSubject<PropertiesDetailViewModelState, Never>()
    private var cancellable: [AnyCancellable] = []
    
    init(useCase: PropertiesUseCase, propertyId: String , navigator: ListingNavigator) {
        self.useCase = useCase
        self.propertyId = propertyId
        self.navigator = navigator
    }
    
    //MARK:- Public methods
    public func load() {
        self.useCase.fetchPropertyDetails(propertyId: propertyId)
            .sink { result in
                switch result {
                case .success(let property):
                    self.property = property
                    self.stateDidUpdateSubject.send(.success)
                case .failure(let error):
                    self.stateDidUpdateSubject.send(.failure(error.localizedDescription))
                }
            }.store(in: &cancellable)
    }
    
    public func getPropertyName() -> String {
        return property?.name ?? ""
    }
    
    public func getPropertyAddress() -> String {
        return property?.address ?? ""
    }
    
    public func getPropertyImageUrl() -> String {
        return property?.image ?? ""
    }
}
