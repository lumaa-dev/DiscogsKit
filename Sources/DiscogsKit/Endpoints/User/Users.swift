// Made by Lumaa

import Foundation

/// API endpoints that uses the `/users/` path.
public enum Users: DiscogsEndpoint {
    /// Retrieve a user by username.
	///
	/// - Parameter username: The username of whose profile you are requesting.
    ///
    /// If authenticated as the requested user, the `email` key will be visible, and the num_list count will include the user’s private lists.
    /// 
    /// If authenticated as the requested user or the user’s collection/wantlist is public, the `num_collection` / `num_wantlist` keys will be visible.
    case get(username: String)

    /// Edit a user’s profile data.
    /// 
    /// - Parameters:
    ///    - username: The username of the user.
    ///    - name: The real name of the user.
    ///    - homePage: The user’s website.
    ///    - location: The geographical location of the user.
    ///    - profile: Biographical information about the user.
    /// 
    /// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) (as any user) is required.
    case set(username: String, name: String? = nil, homePage: String? = nil, location: String? = nil, profile: String? = nil)

    /// Retrieve a user’s submissions by username.
    /// 
    /// - Parameter username: The username of the submissions you are trying to fetch.
    /// 
    /// The Submissions resource represents all edits that a user makes to releases, labels, and artist. Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
    case submissions(username: String, page: Int? = nil, perPage: Int? = nil)

    /// Retrieve a user’s contributions by username.
    /// 
    /// Parameters:
    ///    - username: The username of the submissions you are trying to fetch.
    ///    - sort: Sort items by this field
    ///    - order: Sort items in a particular order (``Order/ascending`` or ``Order/descending``)
    /// 
    /// The Contributions resource represents releases, labels, and artists submitted by a user. Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
    case contributions(username: String, page: Int? = nil, perPage: Int? = nil, sort: ContributionsSort? = nil, order: Order? = nil)

    /// Returns a User’s Lists.
    /// 
    /// - Parameter username: The username of the Lists you are trying to fetch.
    /// 
    /// The List resource allows you to view a User’s Lists. Private Lists will only display when authenticated as the owner. Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
    case lists(username: String)

    /// Get a seller’s inventory.
    /// 
    /// Returns the list of listings in a user’s inventory. Accepts [Pagination parameters](https://www.discogs.com/developers#page:home,header:home-pagination).
    /// 
    /// Basic information about each listing and the corresponding release is provided, suitable for display in a list. For detailed information about the release, make another API call to fetch the corresponding Release.
    /// 
    /// If you are not authenticated as the inventory owner, only items that have a status of For Sale will be visible.\
    /// If you are authenticated as the inventory owner you will get additional `weight`, `format_quantity`, `external_id`, `location`, and `quantity` keys. Note that `quantity` is a read-only field for NearMint users, who will see `1` for all quantity values, regardless of their actual count. If the user is authorized, the listing will contain a in_cart boolean field indicating whether or not this listing is in their cart.
    case inventory(username: String, page: Int? = nil, perPage: Int? = nil, status: String? = nil, sort: InventoryList? = nil, order: Order? = nil)

    /// Returns the list of releases in a user’s wantlist.
    ///
    /// - Parameter username: The username of the wantlist you are trying to fetch.
	///
	/// Basic information about each release is provided, suitable for display in a list. For detailed information, make another API call to fetch the corresponding release.
	///
	/// If the wantlist has been made private by its owner, you must be authenticated as the owner to view it.
	///
	/// The `notes` field will be visible if you are authenticated as the wantlist owner.
	///
	/// - Note: Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
	case wants(username: String, page: Int? = nil, perPage: Int? = nil)

    /// Add a release to a user’s wantlist.
    ///
    /// - Parameters:
    ///   - username: The username of the wantlist you are trying to fetch.
    ///   - id: The ID of the release you are adding.
    ///   - notes: User notes to associate with this release.
    ///   - rating: User’s rating of this release, from `0` (unrated) to `5` (best). Defaults to `0`.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the wantlist owner is required.
    case addWant(username: String, id: Int, notes: String? = nil, rating: Int? = nil)

    /// Edits a release to a user's wantlist.
    ///
	/// - Parameters:
	///   - username: The username of the wantlist you are trying to fetch.
	///   - id: The ID of the release you are deleting.
	///   - notes: User notes to associate with this release.
	///   - rating: User’s rating of this release, from `0` (unrated) to `5` (best). Defaults to `0`.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the wantlist owner is required.
    case editWant(username: String, id: Int, notes: String? = nil, rating: Int? = nil)

    /// Removes a release from a user’s wantlist.
    ///
    /// - Parameters:
	///   - username: The username of the wantlist you are trying to fetch.
	///   - id: The ID of the release you are editing.
	///   - notes: User notes to associate with this release.
	///   - rating: User’s rating of this release, from `0` (unrated) to `5` (best). Defaults to `0`.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the wantlist owner is required.
    case deleteWant(username: String, id: Int, notes: String? = nil, rating: Int? = nil)

    public var path: String {
        switch self {
            case .get(let username), .set(let username, _, _, _, _):
                "/users/\(username)"
            case .submissions(let username, _, _):
                "/users/\(username)/submissions"
            case .contributions(let username, _, _, _, _):
                "/users/\(username)/contributions"
            case .lists(let username):
                "/users/\(username)/lists"
            case .inventory(let username, _, _, _, _, _):
                "/users/\(username)/inventory"
            case .wants(let username, _, _):
                "/users/\(username)/wants"
            case .addWant(let username, let releaseID, _, _),
                 .editWant(let username, let releaseID, _, _),
                 .deleteWant(let username, let releaseID, _, _):
                "/users/\(username)/wants/\(releaseID)"
        }
    }

    public var methods: [Discogs.HTTPMethod] {
        switch self {
            case .get, .submissions, .contributions, .lists, .inventory, .wants:
                return [.get]
            case .set:
                return [.post]
            case .addWant:
                return [.put]
            case .editWant:
                return [.post]
            case .deleteWant:
                return [.delete]
        }
    }

    public var queries: [URLQueryItem] {
        switch self {
			case .wants(_, let page, let perPage):
				return [
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil)
				]
            case .addWant(_, _, let notes, let rating), .editWant(_, _, let notes, let rating), .deleteWant(_, _, let notes, let rating):
                return [
                    .init(name: "notes", value: notes),
                    .init(name: "rating", value: rating != nil ? "\(rating!)" : nil)
                ]
            case .contributions(_, let page, let perPage, let sort, let order):
                return [
                    .init(name: "page", value: page != nil ? "\(page!)" : nil),
                    .init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
                    .init(name: "sort", value: sort?.rawValue),
                    order.query
                ]
            case .submissions(_, let page, let perPage):
                return [
                    .init(name: "page", value: page != nil ? "\(page!)" : nil),
                    .init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil)
                ]
            case .inventory(_, let page, let perPage, let status, let sort, let order):
                return [
                    .init(name: "page", value: page != nil ? "\(page!)" : nil),
                    .init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
                    .init(name: "status", value: status),
                    .init(name: "sort", value: sort?.rawValue),
                    order.query
                ]
            default:
                return []
        }
    }

	/// API endpoints that uses the `/users/{username}/collections` path.
	typealias Collections = UserCollections
}


// MARK: - Additional
public enum ContributionsSort: String, CaseIterable {
    case label = "label"
    case artist = "artist"
    case title = "title"
    case catno = "catno"
    case format = "format"
    case rating = "rating"
    case year = "year"
    case added = "added"
}

public enum InventoryList: String, CaseIterable {
    case listed = "listed"
    case price = "price"
    /// (i.e. the title of the release)
    case item = "item"
    case artist = "artist"
    case label = "label"
    case catno = "catno"
    case audio = "audio"
    /// (when authenticated as the inventory owner)
    case status = "status"
    /// (when authenticated as the inventory owner)
    case location = "location"
}
