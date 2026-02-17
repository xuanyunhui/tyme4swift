import Foundation

/// 候日 (Phase Day)
/// Represents a day within a phenological period (候)
/// Each phenological period has 5 days
public final class PhaseDay: LoopTyme {
    /// PhaseDay names (候日名称)
    public static let NAMES = ["一", "二", "三", "四", "五"]

    /// Initialize with index
    /// - Parameter index: PhaseDay index (0-4)
    public convenience init(index: Int) {
        self.init(names: PhaseDay.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: PhaseDay name (e.g., "一", "二", etc.)
    public convenience init(name: String) throws {
        try self.init(names: PhaseDay.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get PhaseDay from index
    /// - Parameter index: PhaseDay index (0-4)
    /// - Returns: PhaseDay instance
    public static func fromIndex(_ index: Int) -> PhaseDay {
        return PhaseDay(index: index)
    }

    /// Get PhaseDay from name
    /// - Parameter name: PhaseDay name (e.g., "一", "二", etc.)
    /// - Returns: PhaseDay instance
    public static func fromName(_ name: String) throws -> PhaseDay {
        return try PhaseDay(name: name)
    }

    /// Get next phase day
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next PhaseDay instance
    public override func next(_ n: Int) -> PhaseDay {
        return PhaseDay.fromIndex(nextIndex(n))
    }

    /// Get day number (1-5)
    /// - Returns: Day number
    public func getDayNumber() -> Int {
        return index + 1
    }
}
