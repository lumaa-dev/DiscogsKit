// Made by Lumaa

import Foundation

/// API endpoints that uses the `/masters/` path
public enum Masters: DiscogsEndpoint {
	/// Get a master release.
	/// - Parameter id: The Master ID.
	///
	/// The Master resource represents a set of similar Releases. Masters (also known as “master releases”) have a “main release” which is often the chronologically earliest.
	case get(id: Int)

	/// Retrieves a list of all Releases that are versions of this master.
	/// - Parameters:
	///   - id: The Master ID.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///   - format: The format to filter.
	///   - label: The label to filter
	///   - released: The release year to filter
	///   - country: The country to filter
	///   - sort: Sort items by this field
	///   - order: Sort items in a particular order (``Order/ascending`` or ``Order/descending``)
	///
	/// Retrieves a list of all Releases that are versions of this master.
	/// 
	/// Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
	case versions(
		id: Int,
		page: Int? = nil,
		perPage: Int? = nil,
		format: String? = nil,
		label: String? = nil,
		released: Int? = nil,
		country: String? = nil,
		sort: MastersSort? = nil,
		order: Order? = nil
	)

	public var path: String {
		switch self {
			case .get(let id):
				"/masters/\(id)"
			case .versions(let id, _, _, _, _, _, _, _, _):
				"/masters/\(id)/versions"
		}
	}

	public var methods: [Discogs.HTTPMethod] { [.get] }
	public var queries: [URLQueryItem] {
		switch self {
			case .versions(_, let page, let perPage, let format, let label, let released, let country, let sort, let order):
				return [
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
					.init(name: "format", value: format),
					.init(name: "label", value: label),
					.init(name: "released", value: released != nil ? "\(released!)" : nil),
					.init(name: "country", value: country),
					.init(name: "sort", value: sort?.rawValue),
					order.query
				]
			default:
				return []
		}
	}
}

// MARK: - Additional
public enum MastersSort: String, CaseIterable {
	/// (i.e. year of the release)
	case released = "released"
	case title = "title"
	case format = "format"
	case label = "label"
	/// (i.e. catalog number of the release)
	case catno = "catno"
	case country = "country"
}
