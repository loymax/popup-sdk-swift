//
// AddCustomerTokenRequestDataAttributes.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributes")
public typealias AddCustomerTokenRequestDataAttributes = SmartCommunicationsAPI.AddCustomerTokenRequestDataAttributes

extension SmartCommunicationsAPI {

public struct AddCustomerTokenRequestDataAttributes: Codable, JSONEncodable, Hashable {

    public var contacts: [AddCustomerTokenRequestDataAttributesContactsInner]?

    public init(contacts: [AddCustomerTokenRequestDataAttributesContactsInner]? = nil) {
        self.contacts = contacts
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case contacts
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(contacts, forKey: .contacts)
    }
}

}
