// Made by Lumaa

import Foundation

public enum Labels: DiscogsEndpoint {
	/// Get a label.
	/// - Parameter id: The Label ID.
	///
	/// The Label resource represents a label, company, recording studio, location, or other entity involved with Artists and Releases. Labels were recently expanded in scope to include things that aren’t labels – the name is an artifact of this history.
	case get(id: Int)

	/// Returns a list of Releases associated with the label.
	/// - Parameters:
	///   - id: The Label ID.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///
	/// Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
	case releases(id: Int, page: Int? = nil, perPage: Int? = nil)

	public var path: String {
		switch self {
			case .get(let id):
				"/labels/\(id)"
			case .releases(let id, _, _):
				"/labels/\(id)/releases"
		}
	}
	public var methods: [Discogs.HTTPMethod] { return [.get] }
	public var queries: [URLQueryItem] {
		switch self {
			case .releases(_, let page, let perPage):
				return [
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil)
				]
			default:
				return []
		}
	}
}
