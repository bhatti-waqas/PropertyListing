//
//  PropertiesListViewModelTests.swift
//  PropertyListingTests
//
//  Created by Waqas Naseem on 10/18/21.
//

import XCTest
import Combine
@testable import PropertyListing

class PropertiesListViewModelTests: XCTestCase {
       
    private let navigator = ListingNavigatorMock()
    private let useCase = PropertiesUseCaseMock()
    private var viewModel: PropertiesListViewModel!
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        viewModel = PropertiesListViewModel(useCase: useCase, navigator: navigator)
    }
    
    // Test successfully  looading of Cars
    func testViewDidLoad_whenFetchingSuccessful_shouldHaveSuccessState() {
        let expectation = self.expectation(description: "Properties")
        let propertyResponseModel = getMockPropertiesResponse()
        var hasShownSuccessStage = false
        useCase.fetchPropertiesWithReturnValue = .just(.success(propertyResponseModel))
        
        viewModel.stateDidUpdate.sink(receiveValue: { value in
            guard case .success = value else { return }
            hasShownSuccessStage =  true
            expectation.fulfill()
        }).store(in: &cancellables)
        
        //when
        viewModel.load()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(hasShownSuccessStage)
    }
    
    func test_hasErrorState_whenDataLoadingIsFailed() {
        let expectation = self.expectation(description: "properites")
        var isErrorStateTriggered = false
        
        useCase.fetchPropertiesWithReturnValue = .just(.failure(NetworkLayerError.invalidResponse))
        
        viewModel.stateDidUpdate.sink(receiveValue: { value in
            guard case .failure = value else { return }
            isErrorStateTriggered =  true
            expectation.fulfill()
        }).store(in: &cancellables)
        
        //when
        viewModel.load()
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertTrue(isErrorStateTriggered)
    }
}

extension PropertiesListViewModelTests {
    
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

