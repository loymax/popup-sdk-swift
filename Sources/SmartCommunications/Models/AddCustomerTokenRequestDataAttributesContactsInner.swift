//
// AddCustomerTokenRequestDataAttributesContactsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributesContactsInner")
public typealias AddCustomerTokenRequestDataAttributesContactsInner = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributesContactsInner

extension SmartCommunicationsAPI {

public struct AddCustomerTokenRequestDataAttributesContactsInner: Codable, JSONEncodable, Hashable {

    public var type: String?
    public var subtype: String?
    public var value: String?
    public var device: String?

    public init(type: String? = nil, subtype: String? = nil, value: String? = nil, device: String? = nil) {
        self.type = type
        self.subtype = subtype
        self.value = value
        self.device = device
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case type
        case subtype
        case value
        case device
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(subtype, forKey: .subtype)
        try container.encodeIfPresent(value, forKey: .value)
        try container.encodeIfPresent(device, forKey: .device)
    }
}

}
