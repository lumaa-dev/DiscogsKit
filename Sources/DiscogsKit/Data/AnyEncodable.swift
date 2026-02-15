// Made by Lumaa

import Foundation

public struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ value: T) {
        self._encode = { encoder in
            try value.encode(to: encoder)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}

// MARK: - ExpressibleBy... conformances (very convenient)

extension AnyEncodable: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}

extension AnyEncodable: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension AnyEncodable: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}

extension AnyEncodable: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
}

extension AnyEncodable: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: AnyEncodable...) {
        self.init(elements)
    }
}
