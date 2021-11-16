//
//  Resource.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 10/19/21.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
    let parameters: [String: CustomStringConvertible]
    var request: URLRequest? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return URLRequest(url: url)
    }

    init(url: URL, parameters: [String: CustomStringConvertible] = [:]) {
        self.url = url
        self.parameters = parameters
    }
}

extension Resource {
    
    static func properties(query: String, page:Int, perPage: Int) -> Resource<PropertyResponseModel> {
        let url = URL(string: query)!
        let params = ["per_page":perPage, "page":page]
        return Resource<PropertyResponseModel>(url: url, parameters: params)
    }
    
    static func propertyDetails(propertyId: String) -> Resource<PropertyDetailResponseModel> {
        let baseUrl = APIURLs.propertiesUrl
        let detailUrl = baseUrl.appending("/\(propertyId)")
        let url = URL(string: detailUrl)!
        return Resource<PropertyDetailResponseModel>(url: url)
    }
}
