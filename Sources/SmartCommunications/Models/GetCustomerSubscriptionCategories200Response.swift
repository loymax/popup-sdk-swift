//
// GetCustomerSubscriptionCategories200Response.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.GetCustomerSubscriptionCategories200Response")
public typealias GetCustomerSubscriptionCategories200Response = SmartCommunicationsAPI.GetCustomerSubscriptionCategories200Response

extension SmartCommunicationsAPI {

public enum GetCustomerSubscriptionCategories200Response: Codable, JSONEncodable, Hashable {
    case typeCustomerSubscriptionCategories(CustomerSubscriptionCategories)
    case typeSMCErrorResponse(SMCErrorResponse)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeCustomerSubscriptionCategories(let value):
            try container.encode(value)
        case .typeSMCErrorResponse(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(CustomerSubscriptionCategories.self) {
            self = .typeCustomerSubscriptionCategories(value)
        } else if let value = try? container.decode(SMCErrorResponse.self) {
            self = .typeSMCErrorResponse(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of GetCustomerSubscriptionCategories200Response"))
        }
    }
}

}
