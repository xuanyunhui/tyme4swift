import Foundation

/// 宜忌 (Taboo)
/// Auspicious and inauspicious activities for a day
public final class Taboo: AbstractCulture {
    private let tabooName: String
    public let luck: Luck

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

    public var auspicious: Bool { luck.auspicious }
    public var inauspicious: Bool { luck.inauspicious }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> Luck { luck }

    @available(*, deprecated, renamed: "auspicious")
    public func isAuspicious() -> Bool { auspicious }

    @available(*, deprecated, renamed: "inauspicious")
    public func isInauspicious() -> Bool { inauspicious }

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
