//
//  Property.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 11/13/21.
//

import Foundation

struct Property: Decodable {
    public var id: String
    public var name: String?
    public var address: String
    public var image: String?
}

struct Meta: Decodable {
    let currentPage: Int
    let lastPage: Int
    
    enum CodingKeys : String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}

struct PropertyResponseModel: Decodable {
    let data: [Property]
    let meta: Meta
}

struct PropertyDetailResponseModel: Decodable {
    let data: Property
}
