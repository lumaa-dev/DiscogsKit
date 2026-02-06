// Made by Lumaa

import Foundation

/// API endpoints that uses the `/artists/` path
public enum Artists: DiscogsEndpoint {
	/// Get an artist.
	/// - Parameter id: The Artist ID.
	///
	/// The Artist resource represents a person in the Discogs database who contributed to a Release in some capacity.
	case get(id: Int)
	
	/// Get an artist’s releases.
	/// - Parameters:
	///   - id: The Artist ID.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///   - sort: Sort items by this field.
	///   - order: Sort items in a particular order (``Order/ascending`` or ``Order/descending``).
	///
	/// Returns a list of Releases and Masters associated with the Artist.
	///
	/// Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination).
	case releases(id: Int, page: Int? = nil, perPage: Int? = nil, sort: ArtistsSort? = nil, order: Order? = nil)

	public var path: String {
		switch self {
			case .get(let id):
				"/artists/\(id)"
			case .releases(let id, _, _, _, _):
				"/artists/\(id)/releases"
		}
	}

	public var methods: [Discogs.HTTPMethod] { return [.get] }
	public var queries: [URLQueryItem] {
		switch self {
			case .releases(_, let page, let perPage, let sort, let order):
				return [
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
					.init(name: "sort", value: sort?.rawValue),
					order.query
				]
			default:
				return []
		}
	}
}

// MARK: - Additional
public enum ArtistsSort: String, CaseIterable {
	/// (i.e. year of the release)
	case year
	/// (i.e. title of the release)
	case title
	case format
}
