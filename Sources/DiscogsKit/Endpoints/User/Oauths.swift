// Made by Lumaa

import Foundation

/// API endpoints that uses the `/oauth/` path.
public enum Oauths: DiscogsEndpoint {
    /// Generate the request token.
    case requestToken

    /// Generate the access token.
    case accessToken

    /// Retrieve basic information about the authenticated user.
    /// 
    /// You can use this resource to find out who you’re authenticated as, and it also doubles as a good sanity check to ensure that you’re using OAuth correctly.
    /// For more detailed information, make another request for the user’s Profile.
    case identity

	/// Redirects your user to the Discogs Authorize page.
	///
	/// This method will open a URL where it will be asked to the user to authorize your app on behalf of their Discogs account. If they accept and authorize, they will receive a verifier key to use as verification. This key is used in the next phase of OAuth authentication.
	///
	/// If you added a callback URL to your Discogs application registration, the user will be redirected to that URL, and you can capture their verifier from the response. The verifier will be used to generate the access token in the next step. You can always edit your application settings to include a callback URL (i.e., you don’t need to re-create a new application).
	///
	/// - Important: This endpoint can only be used by using ``Discogs/authorize()``
	case authorize

    public var path: String { 
        switch self {
            case .requestToken:
                "/oauth/request_token"
            case .accessToken:
                "/oauth/access_token"
            case .identity:
                "/oauth/identity"
			case .authorize:
				"/oauth/authorize"
        }
    }

	public var url: URL? {
		switch self {
			case .authorize:
				URL(string: "https://www.discogs.com\(self.path)")
			default:
				URL(string: "https://api.discogs.com\(self.path)")
		}
	}

	public var methods: [Discogs.HTTPMethod] {
		switch self {
			case .authorize:
				return []
			case .requestToken:
				return [.post]
			default:
				return [.get]
		}
	}
}
