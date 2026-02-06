// Made by Lumaa

import Foundation

/// API endpoints that uses the `/marketplace/` path
public enum Marketplace: DiscogsEndpoint {
	// MARK: Listing endpoints

	/// View the data associated with a listing or permanently remove a listing from the Marketplace..
	///
	/// - Parameter id: The ID of the listing you are fetching
	///
	/// - When using ``Discogs/HTTPMethod#get``:
	/// - Note: [Authentication](https://www.discogs.com/developers#page:authentication) is __NOT__ required here
	///
	/// If the authorized user is the listing owner the listing will include the weight, `format_quantity`, `external_id`, `location`, and `quantity` keys. Note that quantity is a read-only field for NearMint users, who will see `1` for all quantity values, regardless of their actual count. If the user is authorized, the listing will contain a `in_cart` boolean field indicating whether or not this listing is in their cart.
	///
	/// - When using ``Discogs/HTTPMethod#delete``:
	///
	/// Permanently remove a listing from the Marketplace.
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the listing owner is required.
    case listing(id: Int)

	/// Edit the data associated with a listing.
	///
	/// - Parameters:
	///   - id: The ID of the listing you are fetching
	///   - releaseId: The ID of the release you are posting
	///   - condition: The condition of the release you are posting.
	///   - sleeveCondition: The condition of the sleeve of the item you are posting.
	///   - price: The price of the item (in the seller’s currency).
	///   - comments: Any remarks about the item that will be displayed to buyers.
	///   - allowOffers: Whether or not to allow buyers to make offers on the item. Defaults to `false`.
	///   - status: The status of the listing. Defaults to ``ListingStatus#forSale``. Options are ``ListingStatus#forSale`` (the listing is ready to be shown on the Marketplace) and ``ListingStatus#draft`` (the listing is not ready for public display).
	///   - externalId: A freeform field that can be used for the seller’s own reference. Information stored here will not be displayed to anyone other than the seller. This field is called “Private Comments” on the Discogs website.
	///   - location: A freeform field that is intended to help identify an item’s physical storage location. Information stored here will not be displayed to anyone other than the seller. This field will be visible on the inventory management page and will be available in inventory exports via the website.
	///   - weight: The weight, in grams, of this listing, for the purpose of calculating shipping. Set this field to ``Int#auto`` to have the weight automatically estimated for you.
	///   - formatQuantity: The number of items this listing counts as, for the purpose of calculating shipping. This field is called “Counts As” on the Discogs website. Set this field to ``Int#auto`` to have the quantity automatically estimated for you.
	///
	/// If the listing’s status is not ``ListingStatus#forSale``, ``ListingStatus#draft``, or `Expired`, it cannot be modified – only deleted. To re-list a Sold listing, a new listing must be created.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the listing owner is required.
    case listings(
        id: Int,
		releaseId: Int,
        condition: Condition,
        sleeveCondition: Condition? = nil,
        price: Int,
        comments: String? = nil,
        allowOffers: Bool? = nil,
        status: ListingStatus,
        externalId: String? = nil,
        location: String? = nil,
        weight: Int? = nil,
        formatQuantity: Int? = nil
    )

	/// Create a Marketplace listing.
	///
	/// - Parameters:
	///   - id: The ID of the release you are posting
	///   - condition: The condition of the release you are posting.
	///   - sleeveCondition: The condition of the sleeve of the item you are posting.
	///   - price: The price of the item (in the seller’s currency).
	///   - comments: Any remarks about the item that will be displayed to buyers.
	///   - allowOffers: Whether or not to allow buyers to make offers on the item. Defaults to `false`.
	///   - status: The status of the listing. Defaults to ``ListingStatus#forSale``. Options are ``ListingStatus#forSale`` (the listing is ready to be shown on the Marketplace) and ``ListingStatus#draft`` (the listing is not ready for public display).
	///   - externalId: A freeform field that can be used for the seller’s own reference. Information stored here will not be displayed to anyone other than the seller. This field is called “Private Comments” on the Discogs website.
	///   - location: A freeform field that is intended to help identify an item’s physical storage location. Information stored here will not be displayed to anyone other than the seller. This field will be visible on the inventory management page and will be available in inventory exports via the website.
	///   - weight: The weight, in grams, of this listing, for the purpose of calculating shipping. Set this field to ``Int#auto`` to have the weight automatically estimated for you.
	///   - formatQuantity: The number of items this listing counts as, for the purpose of calculating shipping. This field is called “Counts As” on the Discogs website. Set this field to ``Int#auto`` to have the quantity automatically estimated for you.
	///
	/// The listing will be added to the authenticated user’s Inventory.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) is required
    case newListings(
        id: Int,
        condition: Condition,
        sleeveCondition: Condition? = nil,
        price: Int,
        comments: String? = nil,
        allowOffers: Bool? = nil,
        status: ListingStatus,
        externalId: String? = nil,
        location: String? = nil,
        weight: Int? = nil,
        formatQuantity: Int? = nil
    )

	// MARK: Order endpoints

	/// View the data associated with an order.
	///
	/// The Order resource allows you to manage a seller’s Marketplace orders.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the seller is required.
    case order(id: Int)

	/// Edit the data associated with an order.
	///
	/// The response contains a `next_status` key – an array of valid next statuses for this order, which you can display to the user in (for example) a dropdown control. This also renders your application more resilient to any future changes in the order status logic.\
	/// Changing the order status using this resource will always message the buyer with:
	///
	/// `Seller changed status from Old Status to New Status`
	///
	/// and does not provide a facility for including a custom message along with the change. For more fine-grained control, use the Add a new message resource, which allows you to simultaneously add a message and change the order status.\
	/// If the order status is neither cancelled, Payment Received, nor Shipped, you can change the shipping. Doing so will send an invoice to the buyer and set the order status to Invoice Sent. (For that reason, you cannot set the shipping and the order status in the same request.)
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the seller is required.
    case editOrder(id: Int, status: MarketplaceStatus? = nil, shipping: Int? = nil)

	/// Returns a list of the authenticated user’s orders.
	///
	/// - Parameters:
	///   - status: Only show orders with this status.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///   - createdAfter: Only show orders created after this date.
	///   - createdBefore: Only show orders created before this date.
	///   - archived: Only show orders with a specific archived status. If no key is provided, both statuses are returned.
	///   - sort: Sort items by this field.
	///   - order: Sort items in a particular order.
	///
	/// - Note: Accepts [Pagination parameters](https://www.discogs.com/developers#page:home,header:home-pagination).
    case orders(
		status: MarketplaceStatus? = nil,
		page: Int? = nil,
		perPage: Int? = nil,
		createdAfter: Date? = nil,
		createdBefore: Date? = nil,
		archived: Bool? = nil,
		sort: MarketplaceSort? = nil,
		order: Order? = nil
	)

	/// Returns a list of the order’s messages with the most recent first.
	///
	/// - Parameters:
	///   - id: The ID of the order you are fetching.
	///   - page: The page you want to request.
	///   - perPage: The number of items per page.
	///
	/// - Note: Accepts [Pagination parameters](https://www.discogs.com/developers#page:home,header:home-pagination).
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) as the seller is required.
	case orderMessages(id: Int, page: Int? = nil, perPage: Int? = nil)

	/// Adds a new message to the order’s message log.
	///
	/// - Parameter id: The ID of the order you are fetching.
	///
	/// When posting a new message, you can simultaneously change the order status. If you do, the message will automatically be prepended with:
	///
	/// `Seller changed status from Old Status to New Status`
	///
	/// While `message` and `status` are each optional, one or both must be present.
    case addMessage(id: Int, message: String? = nil, status: MarketplaceStatus? = nil)

	// MARK: Money endpoints

	/// The Fee resource allows you to quickly calculate the fee for selling an item on the Marketplace given a particular currency.
	///
	/// - Parameters:
	///   - price: The price to calculate a fee from.
	///   - currency: Defaults to ``FeeCurrency#usd``.
	case fee(price: Int? = nil, currency: FeeCurrency? = nil)

	/// Retrieve price suggestions for the provided Release ID. If no suggestions are available, an empty object will be returned.
	///
	/// Suggested prices will be denominated in the user’s selling currency.
	///
	/// - Important: [Authentication](https://www.discogs.com/developers#page:authentication) is required, and the user needs to have filled out their seller settings.
    case priceSuggestion(id: Int)

    // MARK: Other marketplace endpoints

	/// Retrieve marketplace statistics for the provided Release ID. These statistics reflect the state of the release in the marketplace _currently_, and include the number of items currently for sale, lowest listed price of any item for sale, and whether the item is blocked for sale in the marketplace.
	///
	/// Authenticated users will by default have the lowest currency expressed in their own buyer currency, configurable in [buyer settings](https://www.discogs.com/settings/buyer).
	///
	/// - Note: [Authentication](https://www.discogs.com/developers#page:authentication) is optional.
    case stats(id: Int)

    public var path: String {
        switch self {
            case .listing(let id):
                return "/marketplace/listings/\(id)"
            case .listings(let id, _, _, _, _, _, _, _, _, _, _, _):
                return "/marketplace/listings/\(id)"
            case .newListings(_, _, _, _, _, _, _, _, _, _, _):
                return "/marketplace/listings"
            case .order(let id), .editOrder(let id, _, _):
                return "/marketplace/orders/\(id)"
            case .orders:
                return "/marketplace/orders"
            case .orderMessages(let id, _, _), .addMessage(let id, _, _):
                return "/marketplace/orders/\(id)/messages"
            case .fee(let price, let currency):
				return price != nil ? "/marketplace/fee/\(price!)/\(currency?.rawValue ?? "")" : "/marketplace/fee"
            case .priceSuggestion(let id):
                return "/marketplace/price_suggestions/\(id)"
            case .stats(let id):
                return "/marketplace/stats/\(id)"
        }
    }

	public var methods: [Discogs.HTTPMethod] {
		switch self {
			case .listing:
				return [.get, .delete]
			case .listings, .newListings, .editOrder, .addMessage:
				return [.post]
			case .order, .orders, .orderMessages, .fee, .priceSuggestion, .stats:
				return [.get]
		}
	}

    public var queries: [URLQueryItem] {
        switch self {
            case .orders(let status, let page, let perPage, let createdAfter, let createdBefore, let archived, let sort, let order):
                let formatter: ISO8601DateFormatter = ISO8601DateFormatter()

                var afterIso: String? = nil
                var beforeIso: String? = nil
                if let createdAfter {
                    afterIso = formatter.string(from: createdAfter)
                }

                if let createdBefore {
                    beforeIso = formatter.string(from: createdBefore)
                }

                return [
                    .init(name: "status", value: status?.rawValue),
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil),
                    .init(name: "created_after", value: afterIso),
                    .init(name: "created_before", value: beforeIso),
                    .init(name: "archived", value: archived != nil ? (archived! ? "true" : "false") : nil),
                    .init(name: "sort", value: sort?.rawValue),
                    order.query
                ]
			case .orderMessages(_, let page, let perPage):
				return [
					.init(name: "page", value: page != nil ? "\(page!)" : nil),
					.init(name: "per_page", value: perPage != nil ? "\(perPage!)" : nil)
				]
            default:
                return []
        }
    }
}

// MARK: - Additional

public enum ListingStatus: String, CaseIterable, Comparable {
	case draft = "Draft"
	case forSale = "For Sale"

	private var order: Int {
		switch self {
			case .draft:
				return 0
			case .forSale:
				return 1
		}
	}

	public static func <(lhs: ListingStatus, rhs: ListingStatus) -> Bool {
		lhs.order < rhs.order
	}
}

public enum MarketplaceStatus: String, CaseIterable, Comparable {
	case all = "All"
    case newOrder = "New Order"
    case buyerContacted = "Buyer Contacted"
    case invoiceSent = "Invoice Sent"
    case paymentPending = "Payment Pending"
    case paymentReceived = "Payment Received"
    case inProgress = "In Progress"
    case shipped = "Shipped"
    case refundSent = "Refund Sent"
    case cancelledUnpaid = "Cancelled (Non-Paying Buyer)"
    case cancelledUnavailable = "Cancelled (Item Unavailable)"
    case cancelledBuyer = "Cancelled (Per Buyer's Request)"
	case cancelledRefund = "Cancelled (Refund Received)"

    private var order: Int {
        switch self {
			case .all:
				return -1
            case .newOrder:
                return 0
            case .buyerContacted:
                return 1
            case .invoiceSent:
                return 2
            case .paymentPending:
                return 3
            case .paymentReceived:
                return 4
            case .inProgress:
                return 5
            case .shipped:
                return 6
            case .refundSent:
                return 7
            case .cancelledUnpaid:
                return 8
            case .cancelledUnavailable:
                return 9
            case .cancelledBuyer:
                return 10
			case .cancelledRefund:
				return 11
        }
    }

    public static func <(lhs: MarketplaceStatus, rhs: MarketplaceStatus) -> Bool {
		lhs.order < rhs.order
	}
}

public enum MarketplaceSort: String, CaseIterable {
    case id = "id"
    case buyer = "buyer"
    case created = "created"
    case status = "status"
    case lastActivity = "last_activity"
}

public enum FeeCurrency: String, CaseIterable {
	case usd = "USD"
	case gbp = "GBP"
	case eur = "EUR"
	case cad = "CAD"
	case aud = "AUD"
	case jpy = "JPY"
	case chf = "CHF"
	case mxn = "MXN"
	case brl = "BRL"
	case nzd = "NZD"
	case sek = "SEK"
	case zar = "ZAR"

	var symbol: String {
		switch self {
			case .usd:
				"$"
			case .gbp:
				"£"
			case .eur:
				"€"
			case .cad:
				"CA$"
			case .aud:
				"A$"
			case .jpy:
				"¥"
			case .chf:
				"CHF"
			case .mxn:
				"MX$"
			case .brl:
				"R$"
			case .nzd:
				"NZ$"
			case .sek:
				"kr"
			case .zar:
				"R"
		}
	}
}

public extension Int {
	static let auto: Int = -221021
}
