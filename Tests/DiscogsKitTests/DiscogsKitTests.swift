// Made by Lumaa

import Foundation
import Testing
@testable import DiscogsKit

@Test 
func getRelease() async throws {
	guard let plist: [String: String] = readSecret(), let key: String = plist["consumerKey"], let secret = plist["consumerSecret"] else { fatalError("Found nil instead of Secret.plist data") }

	let app: Discogs = .init(name: "DiscogsKitTests", version: "1.0.0", consumerKey: key, consumerSecret: secret)
	let data: Data = try await app.send(for: Releases.get(id: 30490723)).0

	print(String(data: data, encoding: .utf8) ?? "*No data returned*")
	#expect(!data.isEmpty)
}

@Test
func search() async throws {
	guard let plist: [String: String] = readSecret(), let token = plist["personalToken"] else { fatalError("Found nil instead of Secret.plist data") }

	let app: Discogs = .init(name: "DiscogsKitTests", version: "1.0.0", personalToken: token)
	let data: Data = try await app.send(for: Database.search(query: "Radiohead", perPage: 1)).0

	print(String(data: data, encoding: .utf8) ?? "*No data returned*")
	#expect(!data.isEmpty)
}

@Test
func reqToken() async throws {
	guard let plist: [String: String] = readSecret(), let key: String = plist["consumerKey"], let secret = plist["consumerSecret"] else { fatalError("Found nil instead of Secret.plist data") }

	let app: Discogs = .init(name: "DiscogsKitTests", version: "1.0.0", consumerKey: key, consumerSecret: secret)
	let data: String? = try await app.requestToken(callbackURLScheme: "amberapp://")

	if let data {
		print(data)
	}
	#expect(data != nil)
}

//@Test
//func acToken() async throws {
//	guard let plist: [String: String] = readSecret(), let key: String = plist["consumerKey"], let secret = plist["consumerSecret"] else { fatalError("Found nil instead of Secret.plist data") }
//
//	let app: Discogs = .init(name: "DiscogsKitTests", version: "1.0.0", consumerKey: key, consumerSecret: secret)
//	let reqTokenQueries: String? = try await app.requestToken(callbackURLScheme: "amberapp://")
//
//	if let reqTokenQueries, let reqToken: String = querify(from: reqTokenQueries).first(where: { $0.name == "oauth_token" })?.value {
//		let data: Data = try await app.accessToken(requestToken: reqToken)
//
//		print(data)
//		#expect(!data.isEmpty)
//	}
//}

private func readSecret() -> [String: String]? {
	if let path = Bundle.module.path(forResource: "Secret", ofType: "plist") {
		let url = URL(fileURLWithPath: path)
		let data = try! Data(contentsOf: url)
		if let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String] {
			return plist
		}
	}

	return nil
}

/// Turns a string-query into an actual array of `URLQueryItem`
///
/// - Returns: An array of `URLQueryItem` corresponding to the `string` parameter
private func querify(from string: String) -> [URLQueryItem] {
	let queriesStr = string.split(separator: "&")

	let queries: [URLQueryItem] = queriesStr.map {
		let q = $0.split(separator: "=")
		return URLQueryItem(name: String(q[0]), value: q.count > 0 ? String(q[1]) : nil)
	}

	return queries
}
