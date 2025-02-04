//
// ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategories.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategories")
public typealias ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategories = SmartCommSDKAPI.ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategories

extension SmartCommSDKAPI {

public struct ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategories: Codable, JSONEncodable, Hashable {

    public var mailingCode: ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategoriesMailingCode?

    public init(mailingCode: ModifyCustomerSubscriptionCategoriesRequestDataAttributesCategoriesMailingCode? = nil) {
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
