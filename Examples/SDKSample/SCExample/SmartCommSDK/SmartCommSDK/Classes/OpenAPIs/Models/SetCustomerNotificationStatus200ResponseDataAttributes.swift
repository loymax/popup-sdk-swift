//
// SetCustomerNotificationStatus200ResponseDataAttributes.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.SetCustomerNotificationStatus200ResponseDataAttributes")
public typealias SetCustomerNotificationStatus200ResponseDataAttributes = SmartCommSDKAPI.SetCustomerNotificationStatus200ResponseDataAttributes

extension SmartCommSDKAPI {

public struct SetCustomerNotificationStatus200ResponseDataAttributes: Codable, JSONEncodable, Hashable {

    public var status: String?

    public init(status: String? = nil) {
        self.status = status
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case status
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(status, forKey: .status)
    }
}

}
