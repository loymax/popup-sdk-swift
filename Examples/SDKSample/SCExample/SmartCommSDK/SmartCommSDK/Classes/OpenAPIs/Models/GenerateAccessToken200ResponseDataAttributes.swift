//
// GenerateAccessToken200ResponseDataAttributes.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.GenerateAccessToken200ResponseDataAttributes")
public typealias GenerateAccessToken200ResponseDataAttributes = SmartCommSDKAPI.GenerateAccessToken200ResponseDataAttributes

extension SmartCommSDKAPI {

public struct GenerateAccessToken200ResponseDataAttributes: Codable, JSONEncodable, Hashable {

    public var accessToken: String?
    public var user: GenerateAccessToken200ResponseDataAttributesUser?

    public init(accessToken: String? = nil, user: GenerateAccessToken200ResponseDataAttributesUser? = nil) {
        self.accessToken = accessToken
        self.user = user
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case accessToken = "access_token"
        case user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(accessToken, forKey: .accessToken)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

}
