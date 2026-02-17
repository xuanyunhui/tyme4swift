import Foundation

/// 吉凶 (Luck - Auspicious/Inauspicious)
/// Represents fortune status in Chinese metaphysics
public final class Luck: LoopTyme {
    /// Luck names (吉凶名称)
    public static let NAMES = ["吉", "凶"]

    /// Initialize with index
    /// - Parameter index: Luck index (0=吉, 1=凶)
    public convenience init(index: Int) {
        self.init(names: Luck.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Luck name ("吉" or "凶")
    public convenience init(name: String) throws {
        try self.init(names: Luck.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Luck from index
    /// - Parameter index: Luck index (0=吉, 1=凶)
    /// - Returns: Luck instance
    public static func fromIndex(_ index: Int) -> Luck {
        return Luck(index: index)
    }

    /// Get Luck from name
    /// - Parameter name: Luck name ("吉" or "凶")
    /// - Returns: Luck instance
    public static func fromName(_ name: String) throws -> Luck {
        return try Luck(name: name)
    }

    /// Get next luck
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Luck instance
    public override func next(_ n: Int) -> Luck {
        return Luck.fromIndex(nextIndex(n))
    }

    public var auspicious: Bool { index == 0 }
    public var inauspicious: Bool { index == 1 }

    @available(*, deprecated, renamed: "auspicious")
    public func isAuspicious() -> Bool { auspicious }

    @available(*, deprecated, renamed: "inauspicious")
    public func isInauspicious() -> Bool { inauspicious }
}
