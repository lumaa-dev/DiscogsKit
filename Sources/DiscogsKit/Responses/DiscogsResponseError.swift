// Made by Lumaa

import Foundation

/// Common Discogs API error response
/// 
/// The Discogs API documentation shows error the same way:
/// ```json
/// {
///     "message": "You don't have permission to access this resource."
/// }
/// ```
/// - Note: This is a sample error showed on [the documentation](https://www.discogs.com/developers#page:user-collection,header:user-collection-delete-instance-from-folder).
public struct DiscogsResponseError: Decodable {
    public let message: String

    private init(message: String) {
        self.message = message
    }

    public init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<Self.CodingKeys> = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
    }

    public enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}