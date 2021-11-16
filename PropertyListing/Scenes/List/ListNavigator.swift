//
//  ListNavigator.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/16/21.
//

import Foundation

protocol ListingNavigator: AnyObject {
    func showDetails(with propertyId: String)
}
