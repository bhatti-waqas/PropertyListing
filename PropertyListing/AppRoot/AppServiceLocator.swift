//
//  AppServiceLocator.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/9/21.
//

import Foundation
import UIKit

let ServiceLocator = AppServiceLocator.shared

///`AppServiceLocator` is responsible to create/manage all dependencies of the application.
final class AppServiceLocator {
    // MARK:- Class Property
    static let shared = AppServiceLocator()
    //MARK:- private Property
    private let useCase: PropertiesUseCase
    
    // MARK:- Init
    private init(){
        //Register dependencies
        let networkService: NetworkServiceProtocol = NetworkService()
        useCase = NetworkPropertiesUseCase(networkService: networkService)
    }
    
    func propertiesViewControllersFactory() -> PropertiesViewControllersFactory {
        return PropertiesViewControllersFactory(useCase: useCase)
    }
}
