//
// ModifySubscriptionRequestDataAttributesCategories.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.ModifySubscriptionRequestDataAttributesCategories")
public typealias ModifySubscriptionRequestDataAttributesCategories = SmartCommunicationsAPI.ModifySubscriptionRequestDataAttributesCategories

extension SmartCommunicationsAPI {

public struct ModifySubscriptionRequestDataAttributesCategories: Codable, JSONEncodable, Hashable {

    public var mailingCode: ModifySubscriptionRequestDataAttributesCategoriesMailingCode?

    public init(mailingCode: ModifySubscriptionRequestDataAttributesCategoriesMailingCode? = nil) {
        self.mailingCode = mailingCode
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case mailingCode
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(mailingCode, forKey: .mailingCode)
    }
}

}
