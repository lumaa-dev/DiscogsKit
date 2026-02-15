// Made by Lumaa

import Foundation

/// API endpoints that uses the `/users/{username}/collections` path.
public enum UserCollections: DiscogsEndpoint {
	/// Retrieve a list of folders in a user’s collection.
	///
	/// - Parameter username: The username of the collection you are trying to retrieve.
	///
	/// The Collection resource allows you to view and manage a user’s collection.\
	/// A collection is arranged into folders. Every user has two permanent folders already:
	///
	/// - ID `0`, the “All” folder, which cannot have releases added to it, and
	/// - ID `1`, the “Uncategorized” folder.
	///
	/// Because it’s possible to own more than one copy of a release, each with its own notes, grading, and so on, each instance of a release in a folder has an instance ID.\
	/// Through the Discogs website, users can create custom notes fields. There is not yet an API method for creating and deleting these fields, but they can be listed, and the values of the fields on any instance can be modified.
	///
	/// - Important: If the collection has been made private by its owner, authentication as the collection owner is required. If you are not authenticated as the collection owner, only folder ID 0 (the “All” folder) will be visible (if the requested user’s collection is public).
	case folders(username: String)

	/// Create a new folder in a user’s collection.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to retrieve.
	///   - name: The name of the newly-created folder.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case createFolder(username: String, name: String)

	/// Retrieve metadata about a folder in a user’s collection.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to request.
	///   - id: The ID of the folder to request.
	///
	/// If `folder_id` is not `0`.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case folder(username: String, id: UInt)

	/// Edit a folder’s metadata.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to modify.
	///   - id: The ID of the folder to modify.
	///
	/// Folders `0` and `1` cannot be renamed.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	@available(iOS, introduced: 26.0, deprecated: 26.1, message: "Missing parameter, might not work properly.")
	case editFolder(username: String, id: UInt)

	/// View the user’s collection folders which contain a specified release.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to view.
	///   - id: The ID of the release to request.
	///
	/// This will also show information about each release instance.
	///
	/// The `release_id` must be non-zero.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required if the owner’s collection is private.
	case foldersWithReleases(username: String, id: UInt)

	/// Returns the list of item in a folder in a user’s collection.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to request.
	///   - id: The ID of the folder to request.
	///   - sort: Sort items by this field
	///   - order: Sort items in a particular order
	///
	/// Basic information about each release is provided, suitable for display in a list. For detailed information, make another API call to fetch the corresponding release.
	///
	/// If you are not authenticated as the collection owner, only public notes fields will be visible.
	///
	/// - Note: Accepts [Pagination](https://www.discogs.com/developers#page:home,header:home-pagination) parameters.
	/// - Important: If `folder_id` is not `0`, or the collection has been made private by its owner, [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case releases(username: String, id: UInt, page: UInt? = nil, perPage: UInt? = nil, sort: ReleasesSort? = nil, order: Order? = nil)

	/// Add a release to a folder in a user’s collection.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to modify.
	///   - folderId: The ID of the folder to modify.
	///   - releaseId: The ID of the release you are adding.
	///
	/// The `folder_id` must be non-zero – you can use `1` for “Uncategorized”.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case addReleaseInFolder(username: String, folderId: UInt, releaseId: UInt)

	/// Change the rating on a release and/or move the instance to another folder.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to modify.
	///   - folderId: The ID of the folder to modify (this parameter is set in the request body and is set if you want to move the instance to this folder).
	///   - releaseId: The ID of the release you are modifying.
	///   - instanceId: The ID of the instance.
	///   - rating: The rating of the instance you are supplying.
	///
	/// This endpoint potentially takes 2 `folder_id` parameters: one in the URL (which is the folder you are requesting, and is required), and one in the request body (representing the folder you want to move the instance to, which is optional)
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case rateRelease(username: String, folderId: UInt, releaseId: UInt, instanceId: UInt, rating: UInt8 = 0)

	/// Remove an instance of a release from a user’s collection folder.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to modify.
	///   - folderId: The ID of the folder to modify.
	///   - releaseId: The ID of the release you are modifying.
	///   - instanceId: The ID of the instance.
	///
	/// To move the release to the “Uncategorized” folder instead, use the ``rateRelease(username:folderId:releaseId:instanceId:rating:)`` endpoint.
	case deleteInstance(username: String, folderId: UInt, releaseId: UInt, instanceId: UInt)

	/// Retrieve a list of user-defined collection notes fields.
	///
	/// These fields are available on every release in the collection.
	///
	/// If you are not authenticated as the collection owner, only fields with public set to true will be visible.
	///
	/// - Important: If the collection has been made private by its owner, [authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case customFields(username: String)

	/// Change the value of a notes field on a particular instance.
	///
	/// - Parameters:
	///   - username: The username of the collection you are trying to modify.
	///   - value: The new value of the field. If the field’s type is `dropdown`, the `value` must match one of the values in the field’s list of options.
	///   - folderId: The ID of the folder to modify.
	///   - releaseId: The ID of the release you are modifying.
	///   - instanceId: The ID of the instance.
	///   - fieldId: The ID of the field.
	case editFields(username: String, value: String, folderId: UInt, releaseId: UInt, instanceId: UInt, fieldId: UInt)

	/// Returns the minimum, median, and maximum value of a user’s collection.
	///
	/// - Parameter username: The username of the collection you are trying to modify.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the collection owner is required.
	case value(username: String)

	public var path: String {
		switch self {
			case .folders(let username), .createFolder(let username, _):
				return "/users/\(username)/collection/folders"
			case .folder(let username, let id), .editFolder(let username, let id):
				return "/users/\(username)/collection/folders/\(id)"
			case .foldersWithReleases(let username, let id):
				return "/users/\(username)/collection/releases/\(id)"
			case .releases(let username, let id, _, _, _, _):
				return "/users/\(username)/collection/folders/\(id)/releases"
			case .addReleaseInFolder(let username, let folderId, let releaseId):
				return "/users/\(username)/collection/folders/\(folderId)/releases/\(releaseId)"
			case .rateRelease(let username, let folderId, let releaseId, let instanceId, _), .deleteInstance(let username, let folderId, let releaseId, let instanceId):
				return "/users/\(username)/collection/folders/\(folderId)/releases/\(releaseId)/instances/\(instanceId)"
			case .customFields(let username):
				return "/users/\(username)/collection/fields"
			case .editFields(let username, _, let folderId, let releaseId, let instanceId, let fieldId):
				return "/users/\(username)/collection/folders/\(folderId)/releases/\(releaseId)/instances/\(instanceId)/fields/\(fieldId)"
			case .value(let username):
				return "/users/\(username)/collection/value"
		}
	}

	public var methods: [Discogs.HTTPMethod] {
		switch self {
			case .folders, .folder, .foldersWithReleases, .releases, .customFields, .value:
				return [.get]
			case .createFolder, .addReleaseInFolder, .editFields, .rateRelease:
				return [.post]
			case .editFolder:
				return [.post, .delete]
			case .deleteInstance:
				return [.delete]
		}
	}

	public var queries: [URLQueryItem] {
		switch self {
			case .releases(_, _, let page, let perPage, let sort, let order):
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

	public var body: AnyEncodable? {
		switch self {
			case .createFolder(_, let name):
				return .init(NewFolderBody(name: name))
			case .rateRelease(_, _, _, _, let rating):
				return .init(RatingBody(rating: rating))
			case .editFields(_, let value, _, _, _, _):
				return .init(EditFieldsBody(value: value))
			default:
				return nil
		}
	}
}

// MARK: - Additional

public enum ReleasesSort: String, CaseIterable {
	case label = "label"
	case artist = "artist"
	case title = "title"
	case catno = "catno"
	case format = "format"
	case rating = "rating"
	case added = "added"
	case year = "year"
}

private struct EditFieldsBody: Encodable {
	let value: String

	init(value: String) {
		self.value = value
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys.self)
		try container.encode(self.value, forKey: .value)
	}

	enum CodingKeys: CodingKey {
		case value
	}
}

private struct NewFolderBody: Encodable {
	let name: String

	init(name: String) {
		self.name = name
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys.self)
		try container.encode(self.name, forKey: .name)
	}

	enum CodingKeys: CodingKey {
		case name
	}
}

private struct RatingBody: Encodable {
	let rating: UInt8

	init(rating: UInt8) {
		self.rating = rating
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: Self.CodingKeys.self)
		try container.encode(self.rating, forKey: .rating)
	}

	enum CodingKeys: CodingKey {
		case rating
	}
}

