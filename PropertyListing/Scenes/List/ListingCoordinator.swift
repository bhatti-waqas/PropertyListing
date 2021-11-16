//
//  ListingCoordinator.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/9/21.
//

import UIKit

final class ListingCoordinator: BaseCoordinator<AppNavigationController> {
    
    override func start() {
        let factory = ServiceLocator.propertiesViewControllersFactory()
        let listingViewController = factory.makePropertyListViewController(navigator: self)
        rootViewController.pushViewController(listingViewController, animated: true)
    }
}

extension ListingCoordinator: ListingNavigator {
    func showDetails(with propertyId: String) {
        let factory = ServiceLocator.propertiesViewControllersFactory()
        let propertyDetailViewController = factory.makePropertyDetailViewController(navigator: self, propertyId: propertyId)
        rootViewController.pushViewController(propertyDetailViewController, animated: true)
    }
}
