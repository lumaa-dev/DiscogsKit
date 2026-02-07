// Made by Lumaa

import Foundation
import AuthenticationServices
import SwiftUI

/// Represents a Discogs instance, with the API's requirements.
/// 
/// ``Discogs`` represents an application's usage of the Discogs API, under its terms, and is used to communicate with the API.
public final class Discogs {
    private var name: String
    private var version: String
    private var about: URL

    private var userAgent: String {
        "\(self.name)/\(self.version) +\(self.about.absoluteString)"
    }

    public var consumerKey: String? = nil
    public var consumerSecret: String? = nil
	public var token: String? = nil // user token

	private var secretToken: String? = nil

	/// Create a Discogs instance with the app's name, version and URL. Also requires the consumer key and the consumer secret.
	public init(name: String, version: String, aboutURL: URL = URL(string: "https://github.com/lumaa-dev/DiscogsKit")!, consumerKey: String? = nil, consumerSecret: String? = nil, personalToken: String? = nil) {
        self.name = name
        self.version = version
        self.about = aboutURL
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
		self.token = personalToken
    }

    /// Send a GET request to a specific Discogs endpoint.
    /// - Parameter endpoint: The Discogs endpoint to send a request to.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
    /// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
    /// - Returns: May return any decodable structs.
    public func get<Response: Decodable>(for endpoint: any DiscogsEndpoint) async throws -> Response? {
        guard endpoint.methods.contains(Discogs.HTTPMethod.get) else { throw DiscogsError.badMethod }

        let data: Data = try await self.send(for: endpoint.path, using: .get, queries: endpoint.queries).0
        let decoder: JSONDecoder = JSONDecoder()
        return try? decoder.decode(Response.self, from: data)
    }

	/// Send a GET request to a specific Discogs endpoint.
	/// - Parameter endpoint: The Discogs endpoint to send a request to.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
	public func get(for endpoint: any DiscogsEndpoint) async throws {
		guard endpoint.methods.contains(Discogs.HTTPMethod.get) else { throw DiscogsError.badMethod }

		_ = try await self.send(for: endpoint.path, using: .get, queries: endpoint.queries)
		return
	}

    /// Send a POST request to a specific Discogs endpoint.
    /// - Parameters:
    ///   - endpoint: The Discogs endpoint to send a request to.
    ///   - body: The body to send along with the request.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
    /// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
    /// - Returns: May return any decodable structs.
    public func post<Response: Decodable>(for endpoint: any DiscogsEndpoint) async throws -> Response? {
        guard endpoint.methods.contains(Discogs.HTTPMethod.post) else { throw DiscogsError.badMethod }

        let data: Data = try await self.send(for: endpoint.path, using: .post, body: endpoint.body ?? EmptyBody()).0
        let decoder: JSONDecoder = JSONDecoder()
        return try? decoder.decode(Response.self, from: data)
    }

	/// Send a POST request to a specific Discogs endpoint.
	/// - Parameters:
	///   - endpoint: The Discogs endpoint to send a request to.
	///   - body: The body to send along with the request.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
	public func post(for endpoint: any DiscogsEndpoint) async throws {
		guard endpoint.methods.contains(Discogs.HTTPMethod.post) else { throw DiscogsError.badMethod }

		_ = try await self.send(for: endpoint.path, using: .post, body: endpoint.body ?? EmptyBody())
		return
	}

    /// Send a PUT request to a specific Discogs endpoint.
    /// - Parameters:
    ///   - endpoint: The Discogs endpoint to send a request to.
    ///   - body: The body to send along with the request.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
    /// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
    /// - Returns: May return any decodable structs.
    public func put<Response: Decodable>(for endpoint: any DiscogsEndpoint) async throws -> Response? {
        guard endpoint.methods.contains(Discogs.HTTPMethod.put) else { throw DiscogsError.badMethod }

        let data: Data = try await self.send(for: endpoint.path, using: .put, body: endpoint.body ?? EmptyBody()).0
        let decoder: JSONDecoder = JSONDecoder()
        return try? decoder.decode(Response.self, from: data)
    }

	/// Send a PUT request to a specific Discogs endpoint.
	/// - Parameters:
	///   - endpoint: The Discogs endpoint to send a request to.
	///   - body: The body to send along with the request.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
	public func put(for endpoint: any DiscogsEndpoint) async throws {
		guard endpoint.methods.contains(Discogs.HTTPMethod.put) else { throw DiscogsError.badMethod }

		_ = try await self.send(for: endpoint.path, using: .put, body: endpoint.body ?? EmptyBody())
		return
	}

    /// Send a DELETE request to a specific Discogs endpoint.
    /// - Parameter endpoint: The Discogs endpoint to send a request to.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
    /// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
    /// - Returns: May return any decodable structs.
    public func delete<Response: Decodable>(for endpoint: any DiscogsEndpoint) async throws -> Response? {
        guard endpoint.methods.contains(Discogs.HTTPMethod.delete) else { throw DiscogsError.badMethod }

        let data: Data = try await self.send(for: endpoint.path, using: .delete).0
        let decoder: JSONDecoder = JSONDecoder()
        return try? decoder.decode(Response.self, from: data)
    }

	/// Send a DELETE request to a specific Discogs endpoint.
	/// - Parameter endpoint: The Discogs endpoint to send a request to.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Throws: ``DiscogsError/badMethod`` if the method isn't compatible with the `endpoint`.
	public func delete(for endpoint: any DiscogsEndpoint) async throws {
		guard endpoint.methods.contains(Discogs.HTTPMethod.delete) else { throw DiscogsError.badMethod }

		_ = try await self.send(for: endpoint.path, using: .delete)
		return
	}

    /// Send an HTTP request to a specific `path`, with a `body`.
    /// - Parameters:
    ///   - path: API Path.
    ///   - method: HTTP method to use.
    ///   - body: The body to send along with the request.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
    /// - Returns: Returns the response's data and HTTP response.
    public func send(for path: String = "/", using method: Discogs.HTTPMethod = .get, queries: [URLQueryItem] = [], body: any Encodable = EmptyBody()) async throws -> (Data, HTTPURLResponse) {
        let req: URLRequest = try self.makeRequest(for: path, using: method, queries: queries, body: body)
		return try await self.makeCall(using: req)
    }

	/// Send an HTTP request to a specific `path`, with a `body`.
	/// - Parameters:
	///   - path: API Path.
	///   - method: HTTP method to use.
	///   - body: The body to send along with the request.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Returns: Returns the response's data and HTTP response.
	public func send(for endpoint: any DiscogsEndpoint, using method: Discogs.HTTPMethod = .get) async throws -> (Data, HTTPURLResponse) {
		guard endpoint.methods.contains(method) else { throw DiscogsError.badMethod }

		let body: Encodable = endpoint.body ?? EmptyBody()
		let req: URLRequest = try self.makeRequest(for: endpoint.path, using: method, queries: endpoint.queries, body: body)

		return try await self.makeCall(using: req)
	}

    /// Creates a pre-configured `URLRequest` for [Discogs's API](https://www.discogs.com/developers) and respects its guidelines.
    ///
    /// - Parameters:
    ///   - path: The API path.
    ///   - method: The HTTP method to use.
    ///   - body: The data to send along with the `POST` or `PUT` method.
    /// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
    /// - Returns: An all-ready to use `URLRequest`.
    public func makeRequest<Body: Encodable>(for path: String = "/", using method: Discogs.HTTPMethod = .get, queries: [URLQueryItem] = [], body: Body = EmptyBody()) throws -> URLRequest {
        guard var apiURL: URL = URL(string: "https://api.discogs.com\(path)") else { throw DiscogsError.badURL }
        apiURL.append(queryItems: queries)

		let auth: String = self.token != nil ? "Discogs token=\(self.token!)" : "Discogs key=\(self.consumerKey!), secret=\(self.consumerSecret!)"

        var req: URLRequest = .init(url: apiURL)
        req.httpMethod = method.rawValue
        req.setValue(self.userAgent, forHTTPHeaderField: "User-Agent")
		req.setValue(auth, forHTTPHeaderField: "Authorization")

        if method.hasBody {
            let encoder: JSONEncoder = JSONEncoder()
            let bodyData: Data = try encoder.encode(body)
            req.httpBody = bodyData
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return req
    }

	/// Creates a pre-configured `URLRequest` for [Discogs's API](https://www.discogs.com/developers) and respects its guidelines.
	///
	/// - Parameters:
	///   - path: The API path.
	///   - method: The HTTP method to use.
	///   - body: The data to send along with the `POST` or `PUT` method.
	/// - Throws: ``DiscogsError/badURL`` if the URL is malformed or incorrect.
	/// - Returns: An all-ready to use `URLRequest`.
	public func makeRequest(for endpoint: any DiscogsEndpoint, using method: Discogs.HTTPMethod = .get) throws -> URLRequest {
		guard var apiURL: URL = URL(string: "https://api.discogs.com\(endpoint.path)") else { throw DiscogsError.badURL }
		apiURL.append(queryItems: endpoint.queries)

		let auth: String = self.token != nil ? "Discogs token=\(self.token!)" : "Discogs key=\(self.consumerKey!), secret=\(self.consumerSecret!)"

		var req: URLRequest = .init(url: apiURL)
		req.httpMethod = method.rawValue
		req.setValue(self.userAgent, forHTTPHeaderField: "User-Agent")
		req.setValue(auth, forHTTPHeaderField: "Authorization")

		if method.hasBody, let body: Encodable = endpoint.body {
			let encoder: JSONEncoder = JSONEncoder()
			let bodyData: Data = try encoder.encode(body)
			req.httpBody = bodyData
			req.setValue("application/json", forHTTPHeaderField: "Content-Type")
		}

		return req
	}

	/// Calls a request req using DiscogsKit's handler
	/// - Parameter req: The request to call
	/// - Throws: ``DiscogsError/badResponse`` if the URL response is malformed, incorrect, or returned an error.
	/// - Returns: Returns the response's data and HTTP response.
	public func makeCall(using req: URLRequest) async throws -> (Data, HTTPURLResponse) {
		let (data, res) = try await URLSession.shared.data(for: req)

		if let httpRes: HTTPURLResponse = res as? HTTPURLResponse {
			if httpRes.statusCode < 200 || httpRes.statusCode > 299 {
				if let str = String(data: data, encoding: .utf8) {
					print("[Error \(httpRes.statusCode)] \(str)")
				}
				throw DiscogsError.badResponse
			}

			return (data, httpRes)
		}

		throw DiscogsError.badResponse
	}

	/// Requests the user to authenticate using their Discogs account, through [discogs.com](https://discogs.com/), using Apple's [Authentication Services](https://developer.apple.com/documentation/authenticationservices) API.
	public func authorize(using webAuthenticationSession: WebAuthenticationSession, callbackURLScheme: String) async throws -> URL {
		guard let reqToken: String = try await self.requestToken(callbackURLScheme: callbackURLScheme), let token: String = URLComponents(string: "?\(reqToken)")?.queryItems?.first(where: { $0.name == "oauth_token" })?.value else {
			throw DiscogsError.badResponse
		}

		guard var authorizeURL: URL = Oauths.authorize.url else { throw DiscogsError.badURL }
		authorizeURL.append(queryItems: [.init(name: "oauth_token", value: token)])

		var newURL: String = callbackURLScheme
		if !callbackURLScheme.hasPrefix("http") {
			newURL = newURL.replacing(/:\/\/.+/, with: "")
		}

		if let secret: String = URLComponents(string: "?\(reqToken)")?.queryItems?.first(where: { $0.name == "oauth_token" })?.value {
			self.secretToken = secret
		}

		return try await webAuthenticationSession.authenticate(using: authorizeURL, callback: newURL)

	}

	public func requestToken(callbackURLScheme: String) async throws -> String? {
		var req: URLRequest = try self.makeRequest(for: Oauths.requestToken)
		req = self.timedRequest(using: req, callback: callbackURLScheme)
		if var auth: String = req.value(forHTTPHeaderField: "Authorization") {
			auth += ",oauth_signature=\"\(self.consumerSecret!)&\""
			req.setValue(auth, forHTTPHeaderField: "Authorization")
		}

		let data: Data = try await self.makeCall(using: req).0
		return String(data: data, encoding: .utf8)
	}

	public func accessToken(oauthToken: String, verifierToken: String) async throws -> Data {
		guard let secretToken else { throw DiscogsError.missingStep }

		var req: URLRequest = try self.makeRequest(for: Oauths.accessToken, using: .post)
		req = self.timedRequest(using: req)
		if var auth: String = req.value(forHTTPHeaderField: "Authorization") {
			auth += ",oauth_token=\"\(oauthToken)\",oauth_verifier=\"\(verifierToken)\",oauth_signature=\"\(self.consumerSecret!)&\(secretToken)\""
			req.setValue(auth, forHTTPHeaderField: "Authorization")
			print("New auth: \(auth)")
		}

		return try await self.makeCall(using: req).0
	}

	/// Creates a "timed" request (usable with ``Oauths/requestToken`` for example)
	///
	/// Example here: [Documentation](https://www.discogs.com/developers#page:authentication,header:authentication-access-token-url)
	/// - Returns: The "timed" request
	private func timedRequest(using request: URLRequest, callback: String? = nil) -> URLRequest {
		var authHeader: String = "OAuth oauth_consumer_key=\"\(self.consumerKey!)\",oauth_nonce=\"\(UUID().uuidString)\",oauth_signature_method=\"PLAINTEXT\",oauth_timestamp=\"\(Int(Date.now.timeIntervalSince1970))\",oauth_version=\"1.0\""
		if let callback {
			authHeader += ",oauth_callback=\"\(callback)\""
		}

		var req: URLRequest = request
		req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		req.setValue(authHeader, forHTTPHeaderField: "Authorization")

		return req
	}

	/// All useable HTTP methods for Discogs's API.
    public enum HTTPMethod: String, CaseIterable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"

		/// Returns true if the HTTP method can have a body in its request or not.
		///
		/// Returns true for ``post`` and ``put``.\
		/// Returns false for ``get`` and ``delete``.
        public var hasBody: Bool {
            switch self {
                case .get, .delete:
                    return false
                case .post, .put:
                    return true
            }
        }
    }

    /// An empty `Encodable` struct to use as an empty `Body` in ``Discogs#makeRequest(for:using:queries:body:)``.
    public struct EmptyBody: Encodable {
        public init () {}
    }
}

private extension WebAuthenticationSession {
	func authenticate(using url: URL, callback: String, browserSession: WebAuthenticationSession.BrowserSession = .shared) async throws -> URL {
		if #available(iOS 17.4, macOS 14.4, watchOS 10.4, tvOS 17.4, visionOS 1.0, *) {
			return try await self.authenticate(
				using: url,
				callback: .customScheme(callback),
				preferredBrowserSession: .ephemeral,
				additionalHeaderFields: [:]
			)
		} else {
			return try await self.authenticate(
				using: url,
				callbackURLScheme: callback,
				preferredBrowserSession: browserSession
			)
		}
	}
}
