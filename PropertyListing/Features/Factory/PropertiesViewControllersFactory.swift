//
//  ListingViewControllersFactory.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/9/21.
//

import Foundation
import UIKit

final class PropertiesViewControllersFactory {
    // MARK:- Private Properties
    private let useCase: PropertiesUseCase
    
    // MARK:- Init
    init(useCase: PropertiesUseCase) {
        self.useCase = useCase
    }
    
    // MARK:- Public Methods
    func makePropertyListViewController(navigator: ListingCoordinator) -> ListViewController {
        let viewModel: PropertiesListViewModel = PropertiesListViewModel(useCase: useCase, navigator: navigator)
        let listView: ListView = ListView()
        let viewController = ListViewController(with: viewModel, rootView: listView)
        return viewController
    }
    
    func makePropertyDetailViewController(navigator: ListingCoordinator, propertyId: String) -> PropertyDetailsViewController {
        let viewModel: PropertyDetailViewModel = PropertyDetailViewModel(useCase: useCase, propertyId: propertyId, navigator: navigator)
        let detailView: PropertyDetailsView = PropertyDetailsView()
        let viewController = PropertyDetailsViewController(with: viewModel, rootView: detailView)
        return viewController
    }
}
