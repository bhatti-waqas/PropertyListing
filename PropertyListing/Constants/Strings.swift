//
//  Strings.swift
//  PropertyListing
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public protocol StringKey {
    var rawValue: String { get }
    func get(suffix:String?) -> String
}

extension StringKey {
    public func get(suffix:String? = nil) -> String {
        return (self.rawValue + (suffix ?? "")).localize()
    }
}

extension StringKey {
    typealias Generic = GenericStrings
    typealias Error = ErrorStrings
}

public enum GenericStrings:String, StringKey {
    case PropertiesTitle = "key_title_properties"
    case AddressTitle = "key_title_address"
}

public enum ErrorStrings: String, StringKey {
    case InvalidRequestError = "key_invalid_request_error"
    case InvalidResponseError = "key_invalid_response_error"
    case InvalidDataError = "key_invalid_data_error"
    case ErrorDecoding = "key_decoding_error"

}

