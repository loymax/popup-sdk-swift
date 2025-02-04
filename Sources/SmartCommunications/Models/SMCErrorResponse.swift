//
// SMCErrorResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

@available(*, deprecated, renamed: "SmartCommunicationsAPI.SMCErrorResponse")
public typealias SMCErrorResponse = SmartCommunicationsAPI.SMCErrorResponse

extension SmartCommunicationsAPI {

public struct SMCErrorResponse: Codable, JSONEncodable, Hashable {

    /** Список ошибок. */
    public var errors: [SMCErrorDetails]?

    public init(errors: [SMCErrorDetails]? = nil) {
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
