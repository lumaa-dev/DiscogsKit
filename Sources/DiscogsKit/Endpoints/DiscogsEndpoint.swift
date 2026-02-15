// Made by Lumaa

import Foundation

/// Represents any endpoint towards the [Discogs API](https://www.discogs.com/developers).
public protocol DiscogsEndpoint {

	/// API Path for this endpoint.
	///
	/// The path is added to `https://api.discogs.com/` and always has to start with a `/`.
	var path: String { get }

	/// HTTP methods useable for this endpoint.
	var methods: [Discogs.HTTPMethod] { get }

	/// URL queries for this endpoint.
	var queries: [URLQueryItem] { get }

	/// Request body for this endpoint.
	var body: AnyEncodable? { get }

	/// API URL for this endpoint.
	var url: URL? { get }
}

public extension DiscogsEndpoint {
	var queries: [URLQueryItem] { return [] }
	var body: AnyEncodable? { return nil }

	var url: URL? {
		guard var url: URL = URL(string: "https://api.discogs.com\(self.path)") else { return nil }
		url.append(queryItems: self.queries)

		return url
	}
}
