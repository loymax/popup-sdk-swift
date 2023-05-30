//
// PopupResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public final class PopupResponse: Codable, JSONEncodable, Hashable {

    public var popupId: Int64
    public var navlink: String
    public var reference: String?
    public var content: PopupResponseContent?
    public var style: PopupResponseStyle?

    public init(popupId: Int64, navlink: String, reference: String? = nil, content: PopupResponseContent? = nil, style: PopupResponseStyle? = nil) {
        self.popupId = popupId
        self.navlink = navlink
        self.reference = reference
        self.content = content
        self.style = style
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case popupId = "popup_id"
        case navlink
        case reference
        case content
        case style
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(popupId, forKey: .popupId)
        try container.encode(navlink, forKey: .navlink)
        try container.encodeIfPresent(reference, forKey: .reference)
        try container.encodeIfPresent(content, forKey: .content)
        try container.encodeIfPresent(style, forKey: .style)
    }

    public static func == (lhs: PopupResponse, rhs: PopupResponse) -> Bool {
        lhs.popupId == rhs.popupId &&
        lhs.navlink == rhs.navlink &&
        lhs.reference == rhs.reference &&
        lhs.content == rhs.content &&
        lhs.style == rhs.style
        
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(popupId.hashValue)
        hasher.combine(navlink.hashValue)
        hasher.combine(reference?.hashValue)
        hasher.combine(content?.hashValue)
        hasher.combine(style?.hashValue)
        
    }
}

