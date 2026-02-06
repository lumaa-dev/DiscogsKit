<div align="center">
    <h1>DiscogsKit</h1>
    <img width=128 height=128 src="./.github/assets/DiscogsKit_Icon.png" />
</div>

DiscogsKit is a Swift package for calling the Discogs API. It provides a `Discogs` client, a `DiscogsEndpoint` protocol, and strongly-typed endpoint enums for Database, Releases, Artists, Labels, Masters, Marketplace, and Users.

All the provided endpoints are documented word-for-word like in the [official documentation](http://www.discogs.com/developers/).

## Requirements
- Swift 6.0+
- Platforms:
  - iOS 17.0+
  - macOS 14.0+
  - tvOS 17.0+
  - watchOS 10.0+
  - visionOS 1.0+

## Installation
Add DiscogsKit as a Swift Package dependency in your project, or include this repository directly.

## Quick Start
1. Initialize a client
```swift
// Non-authenticated
let discogs: Discogs = Discogs(name: "DiscogsKit", version: "1.0.0", consumerKey: "abcdefgh123", consumerSecret: "foobar123")

// Authenticated using personal token
let discogs: Discogs = Discogs(name: "DiscogsKit", version: "1.0.0", personalToken: "abcdefgh1234foobar5678")
```

2. Call endpoints
```swift
// Does not require authentication
let release: ReleaseResponse = try await discogs.get(for: Releases.get(id: 30490723))

// Requires authentication
let search: SearchResponse = try await discogs.get(for: Database.search(query: "Radiohead"))
```

> NOTE:
> In this example here, `ReleaseResponse` and `SearchResponse` aren't from DiscogsKit.

## Client Overview
The `Discogs` client manages authentication headers, builds requests, and performs calls against `https://api.discogs.com/`.

- `get`, `post`, `put`, `delete` methods support typed `Decodable` responses and fire-and-forget variants.
- `send(for:using:queries:body:)` and `send(for:using:)` return `(Data, HTTPURLResponse)`.
- `makeRequest(...)` builds `URLRequest` with `User-Agent` and `Authorization`.
- `authorize(using:callbackURLScheme:)` supports OAuth flow using [Authentication Services](https://developer.apple.com/documentation/authenticationservices).

## Authentication
- Use `consumerKey` + `consumerSecret` for key/secret authentication.
- Use `personalToken` for token authentication.
- The client sends the `Authorization: Discogs token=...` header when a token is present, or `Authorization: Discogs key=..., secret=...` header otherwise.

## Swift Testing
Tests live in `Tests/DiscogsKitTests`. 

A `Secret_TEMPLATE.plist` is provided at `Tests/DiscogsKitTests/Data/Secret_TEMPLATE.plist` for `consumerKey`, `consumerSecret`, and `personalToken` used in `DiscogsKitTests.swift`.

The `Secret_TEMPLATE.plist` file needs to be filled with actual tokens and keys, and renamed to `Secret.plist`.

# Copyright
© Lumaa 2026