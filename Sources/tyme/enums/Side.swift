import Foundation

/// 内外 (Side)
/// Inner and Outer
public enum Side: Int, CaseIterable, CustomStringConvertible {
    case inner = 0  // 内
    case outer = 1  // 外

    /// Names for Side
    public static let NAMES = ["内", "外"]

    /// Get name
    public var name: String {
        return Side.NAMES[rawValue]
    }

    /// CustomStringConvertible
    public var description: String {
        return name
    }

    /// Get Side from index
    /// - Parameter index: Index (0=内, 1=外)
    /// - Returns: Side
    public static func fromIndex(_ index: Int) -> Side {
        return index % 2 == 0 ? .inner : .outer
    }

    /// Get Side from name
    /// - Parameter name: Name ("内" or "外")
    /// - Returns: Side
    public static func fromName(_ name: String) -> Side {
        return name == "外" ? .outer : .inner
    }

    /// Check if inner
    public var isInner: Bool {
        return self == .inner
    }

    /// Check if outer
    public var isOuter: Bool {
        return self == .outer
    }
}
