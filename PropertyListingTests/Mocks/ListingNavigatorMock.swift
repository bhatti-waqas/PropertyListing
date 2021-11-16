//
//  ListingNavigatorMock.swift
//  PropertyListingTests
//
//  Created by Waqas Naseem on 10/31/21.
//

@testable import PropertyListing

final class ListingNavigatorMock: ListingNavigator {
    private(set) var showDetailsDidCall = false
    
    func showDetails(with propertyId: String) {
        showDetailsDidCall = true
    }
}
