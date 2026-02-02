import Foundation

/// 藏干类型 (HideHeavenStemType)
/// Types of hidden heaven stems in earth branches
public enum HideHeavenStemType: Int, CaseIterable, CustomStringConvertible {
    case main = 0      // 本气
    case middle = 1    // 中气
    case residual = 2  // 余气

    /// Names for HideHeavenStemType
    public static let NAMES = ["本气", "中气", "余气"]

    /// Get name
    public var name: String {
        return HideHeavenStemType.NAMES[rawValue]
    }

    /// CustomStringConvertible
    public var description: String {
        return name
    }

    /// Get HideHeavenStemType from index
    /// - Parameter index: Index (0=本气, 1=中气, 2=余气)
    /// - Returns: HideHeavenStemType
    public static func fromIndex(_ index: Int) -> HideHeavenStemType {
        let i = index % 3
        switch i {
        case 0: return .main
        case 1: return .middle
        default: return .residual
        }
    }

    /// Get HideHeavenStemType from name
    /// - Parameter name: Name ("本气", "中气", or "余气")
    /// - Returns: HideHeavenStemType
    public static func fromName(_ name: String) -> HideHeavenStemType {
        switch name {
        case "中气": return .middle
        case "余气": return .residual
        default: return .main
        }
    }

    /// Check if main
    public var isMain: Bool {
        return self == .main
    }

    /// Check if middle
    public var isMiddle: Bool {
        return self == .middle
    }

    /// Check if residual
    public var isResidual: Bool {
        return self == .residual
    }
}
