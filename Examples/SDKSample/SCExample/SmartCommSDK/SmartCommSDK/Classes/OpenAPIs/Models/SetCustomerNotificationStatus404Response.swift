//
// SetCustomerNotificationStatus404Response.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.SetCustomerNotificationStatus404Response")
public typealias SetCustomerNotificationStatus404Response = SmartCommSDKAPI.SetCustomerNotificationStatus404Response

extension SmartCommSDKAPI {

public struct SetCustomerNotificationStatus404Response: Codable, JSONEncodable, Hashable {

    public var errors: [SetCustomerNotificationStatus404ResponseErrorsInner]?

    public init(errors: [SetCustomerNotificationStatus404ResponseErrorsInner]? = nil) {
        self.errors = errors
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case errors
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(errors, forKey: .errors)
    }
}

}
