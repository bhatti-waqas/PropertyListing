//
//  PropertiesUseCaseTests.swift
//  PropertyListingTests
//
//  Created by Waqas Naseem on 10/20/21.
//

import Foundation
import XCTest
import Combine
@testable import PropertyListing

class PropertiesUseCaseTests: XCTestCase {
    
    private let networkService = NetworkServiceMock()
    private var useCase: PropertiesUseCase!
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        useCase = NetworkPropertiesUseCase(networkService: networkService)
    }
    
    func test_fetchPropertiesSucceeds() {
        // Given
        var result: Result<PropertyResponseModel, Error>!
        let expectation = self.expectation(description: "Properties")
        let propertiesResponseModel = getMockPropertiesResponse()
        networkService.responses["/api/properties"] = propertiesResponseModel
        //when
        useCase.fetchProperties(page: 1, perPage: 10).sink(receiveValue: { value in
            result = value
            expectation.fulfill()
        }).store(in: &cancellables)
        
        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .success = result! else {
            XCTFail()
            return
        }
    }
    
    func test_loadCarsFailes_onNetworkError() {
        // Given
        var result: Result<PropertyResponseModel, Error>!
        let expectation = self.expectation(description: "Properties")
        networkService.responses["/api/properties"] = NetworkLayerError.invalidResponse

        //when
        useCase.fetchProperties(page: 1, perPage: 10).sink(receiveValue: { value in
            result = value
            expectation.fulfill()
        }).store(in: &cancellables)
        // Then
        self.waitForExpectations(timeout: 2.0, handler: nil)
        guard case .failure = result! else {
            XCTFail()
            return
        }
    }
}
//MARK: MockResponseBuilder
extension PropertiesUseCaseTests {
    
    private func getMockPropertiesResponse() -> PropertyResponseModel {
        do {
            let path = Bundle(for: PropertiesUseCaseTests.self).path(forResource: "Properties", ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode(PropertyResponseModel.self, from: data)
        } catch {
            fatalError("Error: \(error)")
        }
    }
}
