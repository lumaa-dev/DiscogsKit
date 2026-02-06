// Made by Lumaa

import Foundation

/// API endpoints that uses the `/database/` path
public enum Database: DiscogsEndpoint {
	/// Issue a search query to Discogs database.
	///
	/// - Parameters:
	///   - query: Your search query.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///   - type: One of `release`, `master`, `artist`, `label`.
	///   - title: Search by combined “Artist Name - Release Title” title field.
	///   - releaseTitle: Search release titles.
	///   - credit: Search release credits.
	///   - artist: Search artist names.
	///   - anv: Search artist ANV.
	///   - label: Search label names.
	///   - genre: Search genres.
	///   - style: Search styles.
	///   - country: Search release country.
	///   - year: Search release year.
	///   - format: Search formats.
	///   - catno: Search catalog number.
	///   - barcode: Search barcodes.
	///   - track: Search track titles.
	///   - submitter: Search submitter username.
	///   - contributor: Search contributor usernames.
	///
	/// Issue a search query to our database
	/// 
	/// This endpoint accepts [pagination parameters](https://www.discogs.com/developers#page:home,header:home-pagination).
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) (as any user) is required.
	case search(
		query: String? = nil,
		page: Int? = nil,
		perPage: Int? = nil,
		type: SearchType? = nil,
		title: String? = nil,
		releaseTitle: String? = nil,
		credit: String? = nil,
		artist: String? = nil,
		anv: String? = nil,
		label: String? = nil,
		genre: String? = nil,
		style: String? = nil,
		country: String? = nil,
		year: Int? = nil,
		format: String? = nil,
		catno: String? = nil,
		barcode: String? = nil,
		track: String? = nil,
		submitter: String? = nil,
		contributor: String? = nil
	)

	public var path: String { "/database/search" }
	public var methods: [Discogs.HTTPMethod] { [.get] }
	public var queries: [URLQueryItem] {
		switch self {
			case .search(
				let query,
				let page,
				let perPage,
				let type,
				let title,
				let releaseTitle,
				let credit,
				let artist,
				let anv,
				let label,
				let genre,
				let style,
				let country,
				let year,
				let format,
				let catno,
				let barcode,
				let track,
				let submitter,
				let contributor
			):
				return [
					.init(name: "query", value: query),
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
					.init(name: "type", value: type?.rawValue),
					.init(name: "title", value: title),
					.init(name: "release_title", value: releaseTitle),
					.init(name: "credit", value: credit),
					.init(name: "artist", value: artist),
					.init(name: "anv", value: anv),
					.init(name: "label", value: label),
					.init(name: "genre", value: genre),
					.init(name: "style", value: style),
					.init(name: "country", value: country),
					.init(name: "year", value: year != nil ? "\(year!)" : nil),
					.init(name: "format", value: format),
					.init(name: "catno", value: catno),
					.init(name: "barcode", value: barcode),
					.init(name: "track", value: track),
					.init(name: "submitter", value: submitter),
					.init(name: "contributor", value: contributor)
				]
		}
	}
}

// MARK: - Additional

/// One of `release`, `master`, `artist`, `label`.
///
/// Discogs `type` parameter for the ``Database/search(query:type:title:releaseTitle:credit:artist:anv:label:genre:style:country:year:format:catno:barcode:track:submitter:contributor:)`` endpoint.
public enum SearchType: String, CaseIterable {
    case release = "release"
    case master = "master"
    case artist = "artist"
    case label = "label"
}
