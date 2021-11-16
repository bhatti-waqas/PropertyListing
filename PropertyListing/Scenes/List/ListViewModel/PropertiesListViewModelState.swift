//
//  PropertiesListViewModelProtocol.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/13/21.
//

import Foundation
import Combine

enum PropertiesListViewModelState: Equatable {
    case success([PropertyRowViewModel])
    case failure(String)
}
