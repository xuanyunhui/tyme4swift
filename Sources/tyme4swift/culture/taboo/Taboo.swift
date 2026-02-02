import Foundation

/// 宜忌 (Taboo)
/// Auspicious and inauspicious activities for a day
public final class Taboo: AbstractCulture {
    private let tabooName: String
    private let luck: Luck

    /// Initialize with name and luck
    /// - Parameters:
    ///   - name: Taboo name
    ///   - luck: Luck (吉 or 凶)
    public init(name: String, luck: Luck) {
        self.tabooName = name
        self.luck = luck
        super.init()
    }

    /// Get name
    /// - Returns: Taboo name
    public override func getName() -> String {
        return tabooName
    }

    /// Get luck
    /// - Returns: Luck instance
    public func getLuck() -> Luck {
        return luck
    }

    /// Check if auspicious (宜)
    public func isAuspicious() -> Bool {
        return luck.isAuspicious()
    }

    /// Check if inauspicious (忌)
    public func isInauspicious() -> Bool {
        return luck.isInauspicious()
    }

    /// Create auspicious taboo
    /// - Parameter name: Taboo name
    /// - Returns: Taboo instance
    public static func auspicious(_ name: String) -> Taboo {
        return Taboo(name: name, luck: Luck.fromIndex(0))
    }

    /// Create inauspicious taboo
    /// - Parameter name: Taboo name
    /// - Returns: Taboo instance
    public static func inauspicious(_ name: String) -> Taboo {
        return Taboo(name: name, luck: Luck.fromIndex(1))
    }
}
