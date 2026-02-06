// Made by Lumaa

import Foundation

/// The condition of a physical media, whether it's sleeve or the music itself.
public enum Condition: String, CaseIterable, Comparable {
    case mint = "Mint (M)"
    case nearMint = "Near Mint (NM)"
    case veryGoodPlus = "Very Good Plus (VG+)"
    case veryGood = "Very Good (VG)"
    case goodPlus = "Good Plus (G+)"
    case good = "Good (G)"
    case fair = "Fair (F)"
    case poor = "Poor (P)"

    case generic = "Generic"
    case notGraded = "Not Graded"
    case noCover = "No Cover"

    private var order: Int {
        switch self {
            case .mint:
                0
            case .nearMint:
                1
            case .veryGoodPlus:
                2
            case .veryGood:
                3
            case .goodPlus:
                4
            case .good:
                5
            case .fair:
                6
            case .poor:
                7

            default:
                -1
        }
    }

    public static func <(lhs: Condition, rhs: Condition) -> Bool {
		lhs.order < rhs.order
	}
}