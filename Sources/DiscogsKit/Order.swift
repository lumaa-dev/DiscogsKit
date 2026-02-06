// Made by Lumaa

import Foundation

/// One of ascending or descending.
public enum Order: String, CaseIterable, Comparable {
	/// Smaller to bigger (1, 2, 3, 4...)
	case ascending = "asc"
	/// Bigger to smaller (4, 3, 2, 1...)
	case descending = "desc"

	private var order: Int8 {
		switch self {
			case .ascending:
				1
			case .descending:
				0
		}
	}

	/// The URL query for this ``Order``.
	/// 
	/// The URL query for sorting items in a specific order is often using the key `sort_order`.
	public var query: URLQueryItem { .init(name: "sort_order", value: self.rawValue) }

	public static func <(lhs: Order, rhs: Order) -> Bool {
		lhs.order < rhs.order
	}
}

extension Optional<Order> {
	/// The URL query for this ``Order``.
	/// 
	/// The URL query for sorting items in a specific order is often using the key `sort_order`.
	public var query: URLQueryItem { .init(name: "sort_order", value: self?.rawValue) }
}
