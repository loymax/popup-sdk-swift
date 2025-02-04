//
// GetCustomerNotificationStatus200ResponseMeta.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.GetCustomerNotificationStatus200ResponseMeta")
public typealias GetCustomerNotificationStatus200ResponseMeta = SmartCommSDKAPI.GetCustomerNotificationStatus200ResponseMeta

extension SmartCommSDKAPI {

public struct GetCustomerNotificationStatus200ResponseMeta: Codable, JSONEncodable, Hashable {

    public var count: Int?
    public var total: Int?

    public init(count: Int? = nil, total: Int? = nil) {
        self.count = count
        self.total = total
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case count
        case total
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(count, forKey: .count)
        try container.encodeIfPresent(total, forKey: .total)
    }
}

}
