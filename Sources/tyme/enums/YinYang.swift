import Foundation

/// 阴阳 (YinYang)
/// The fundamental duality in Chinese philosophy
public enum YinYang: Int, CaseIterable, CustomStringConvertible {
    case yang = 0  // 阳
    case yin = 1   // 阴

    /// Names for YinYang
    public static let NAMES = ["阳", "阴"]

    /// Get name
    public var name: String {
        return YinYang.NAMES[rawValue]
    }

    /// CustomStringConvertible
    public var description: String {
        return name
    }

    /// Get YinYang from index
    /// - Parameter index: Index (0=阳, 1=阴)
    /// - Returns: YinYang
    public static func fromIndex(_ index: Int) -> YinYang {
        return index % 2 == 0 ? .yang : .yin
    }

    /// Get YinYang from name
    /// - Parameter name: Name ("阳" or "阴")
    /// - Returns: YinYang
    public static func fromName(_ name: String) -> YinYang {
        return name == "阴" ? .yin : .yang
    }

    /// Get opposite YinYang
    /// - Returns: Opposite YinYang
    public func opposite() -> YinYang {
        return self == .yang ? .yin : .yang
    }

    /// Check if Yang
    public var isYang: Bool {
        return self == .yang
    }

    /// Check if Yin
    public var isYin: Bool {
        return self == .yin
    }
}
