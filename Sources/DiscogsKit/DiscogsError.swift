// Made by Lumaa

import Foundation

/// Errors that can happen when using DiscogsKit.
public enum DiscogsError: Error {
    /// The URL is malformed and cannot be used to make a request.
    case badURL

    /// The HTTP request or the HTTP response is malformed or incorrect.
    /// 
    /// The few reasons can occur for this error to be thrown:
    /// - The HTTP request's status code couldn't be found.
    /// - The HTTP request's status code is not between 200 and 299.
    /// - The HTTP response's couldn't be decoded.
    case badResponse

    /// The HTTP request's method isn't compatible with the associated ``DiscogsEndpoint``.
    case badMethod
}