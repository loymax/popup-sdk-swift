//
// GenerateAccessToken200Response.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommSDKAPI.GenerateAccessToken200Response")
public typealias GenerateAccessToken200Response = SmartCommSDKAPI.GenerateAccessToken200Response

extension SmartCommSDKAPI {

public struct GenerateAccessToken200Response: Codable, JSONEncodable, Hashable {

    public var data: GenerateAccessToken200ResponseData?
    public var links: GenerateAccessToken200ResponseLinks?

    public init(data: GenerateAccessToken200ResponseData? = nil, links: GenerateAccessToken200ResponseLinks? = nil) {
        self.data = data
        self.links = links
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case data
        case links
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(links, forKey: .links)
    }
}

}
