//
//  ListingViewModelDelegate.swift
//  ListingChallenge
//
//  Created by Waqas Naseem on 11/9/21.
//

import Foundation

public protocol ListingViewModelDelegate : AnyObject {
    func onViewModelReady()
    func onViewModelError(with error: Error)
}

protocol ListingNavigator: AnyObject {
    func showDetails(with propertyId: String)
}
