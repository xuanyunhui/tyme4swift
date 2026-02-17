import Foundation

/// 旬 (Ten-day period / Xun)
///
/// Represents the six "Xun" (旬) periods in the sexagenary cycle.
/// Each Xun covers 10 consecutive sexagenary cycle elements starting from a "Jia" (甲) stem day.
/// The six Xun are named after their starting sexagenary element:
/// 甲子旬, 甲戌旬, 甲申旬, 甲午旬, 甲辰旬, 甲寅旬
public final class Ten: LoopTyme {
    /// Ten names (六旬名称)
    public static let NAMES = ["甲子", "甲戌", "甲申", "甲午", "甲辰", "甲寅"]

    /// Initialize with index
    /// - Parameter index: Ten index (0-5)
    public convenience init(index: Int) {
        self.init(names: Ten.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Ten name (e.g., "甲子", "甲戌", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Ten.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Ten from index
    /// - Parameter index: Ten index (0-5)
    /// - Returns: Ten instance
    public static func fromIndex(_ index: Int) -> Ten {
        return Ten(index: index)
    }

    /// Get Ten from name
    /// - Parameter name: Ten name (e.g., "甲子", "甲戌", etc.)
    /// - Returns: Ten instance
    public static func fromName(_ name: String) throws -> Ten {
        return try Ten(name: name)
    }

    /// Get next Ten
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Ten instance
    public override func next(_ n: Int) -> Ten {
        return Ten.fromIndex(nextIndex(n))
    }
}
