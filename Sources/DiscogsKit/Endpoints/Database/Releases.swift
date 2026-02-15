// Made by Lumaa

import Foundation

/// API endpoints that uses the `/releases/` path
public enum Releases: DiscogsEndpoint {
	/// Get a release.
	/// - Parameter id: The Release ID.
	///
	/// The Release resource represents a particular physical or digital object released by one or more Artists.
	case get(id: Int)

	/// Retrieves or deletes the release’s rating for a given user.
	/// - Parameters:
	///   - id: The Release ID.
	///   - user: The username of the rating you are trying to request.
	///
	/// The Release Rating endpoint retrieves, updates, or deletes the rating of a release for a given user.
	case rating(id: Int, user: String)

	/// Updates the release’s rating for a given user.
	/// - Parameters:
	///   - id: The Release ID.
	///   - user: The username of the rating you are trying to request.
	///   - rating: The new rating for a release between 1 and 5.
	///
	/// The Release Rating endpoint retrieves, updates, or deletes the rating of a release for a given user.
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the user is required.
	case setRating(id: Int, user: String, rating: Int)

	/// Retrieves the community release rating average and count.
	/// - Parameter id: The Release ID.
	///
	/// The Community Release Rating endpoint retrieves the average rating and the total number of user ratings for a given release.
	case communityRating(id: Int)

	/// Retrieves the release’s “have” and “want” counts.
	/// - Parameter id: The Release ID.
	///
	/// The Release Stats endpoint retrieves the total number of “haves” (in the community’s collections) and “wants” (in the community’s wantlists) for a given release.
	case stats(id: Int)


	public var path: String {
		switch self {
			case .get(let id):
				"/releases/\(id)"
			case .rating(let id, let user), .setRating(let id, let user, _):
				"/releases/\(id)/rating/\(user)"
			case .communityRating(let id):
				"/releases/\(id)/rating"
			case .stats(let id):
				"/releases/\(id)/stats"
		}
	}

	public var methods: [Discogs.HTTPMethod] {
		switch self {
			case .rating, .communityRating, .stats:
				return [.get]
			case .get:
				return [.get, .delete]
			case .setRating:
				return [.put]
		}
	}

	public var body: AnyEncodable? {
		switch self {
			case .setRating(_, _, let rating):
				return .init(ReleaseSetRating(rating: rating))
			default:
				return nil
		}
	}
}

private struct ReleaseSetRating: Encodable {
	let rating: Int

	init(rating: Int) {
		self.rating = max(min(rating, 5), 0)
	}
}
