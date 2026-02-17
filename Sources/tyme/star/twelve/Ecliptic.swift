import Foundation

/// 黄道黑道 (Ecliptic - Yellow Road / Black Road)
/// Represents auspicious (黄道) and inauspicious (黑道) days
public final class Ecliptic: LoopTyme {
    /// Ecliptic names (黄道黑道名称)
    public static let NAMES = ["黄道", "黑道"]

    /// Initialize with index
    /// - Parameter index: Ecliptic index (0=黄道, 1=黑道)
    public convenience init(index: Int) {
        self.init(names: Ecliptic.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Ecliptic name ("黄道" or "黑道")
    public convenience init(name: String) throws {
        try self.init(names: Ecliptic.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Ecliptic from index
    /// - Parameter index: Ecliptic index (0=黄道, 1=黑道)
    /// - Returns: Ecliptic instance
    public static func fromIndex(_ index: Int) -> Ecliptic {
        return Ecliptic(index: index)
    }

    /// Get Ecliptic from name
    /// - Parameter name: Ecliptic name ("黄道" or "黑道")
    /// - Returns: Ecliptic instance
    public static func fromName(_ name: String) throws -> Ecliptic {
        return try Ecliptic(name: name)
    }

    /// Get next ecliptic
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Ecliptic instance
    public override func next(_ n: Int) -> Ecliptic {
        return Ecliptic.fromIndex(nextIndex(n))
    }

    public var luck: Luck { Luck.fromIndex(index) }

    /// Check if auspicious (黄道)
    public func isAuspicious() -> Bool { index == 0 }

    /// Check if inauspicious (黑道)
    public func isInauspicious() -> Bool { index == 1 }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> Luck { luck }
}
