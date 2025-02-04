//
// GetCustomerNotificationStatus200Response.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.GetCustomerNotificationStatus200Response")
public typealias GetCustomerNotificationStatus200Response = SmartCommunicationsAPI.GetCustomerNotificationStatus200Response

extension SmartCommunicationsAPI {

public enum GetCustomerNotificationStatus200Response: Codable, JSONEncodable, Hashable {
    case typeCustomerNotificationStatus(CustomerNotificationStatus)
    case typeSMCErrorResponse(SMCErrorResponse)

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .typeCustomerNotificationStatus(let value):
            try container.encode(value)
        case .typeSMCErrorResponse(let value):
            try container.encode(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(CustomerNotificationStatus.self) {
            self = .typeCustomerNotificationStatus(value)
        } else if let value = try? container.decode(SMCErrorResponse.self) {
            self = .typeSMCErrorResponse(value)
        } else {
            throw DecodingError.typeMismatch(Self.Type.self, .init(codingPath: decoder.codingPath, debugDescription: "Unable to decode instance of GetCustomerNotificationStatus200Response"))
        }
    }
}

}
