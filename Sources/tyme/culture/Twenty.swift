import Foundation

/// 二十 (Twenty)
/// 二十日 - The twenty days of a lunar month
public final class Twenty: LoopTyme {
    /// Twenty names (二十日名称)
    public static let NAMES = [
        "初一", "初二", "初三", "初四", "初五",
        "初六", "初七", "初八", "初九", "初十",
        "十一", "十二", "十三", "十四", "十五",
        "十六", "十七", "十八", "十九", "二十"
    ]

    /// Initialize with index
    /// - Parameter index: Twenty index (0-19)
    public convenience init(index: Int) {
        self.init(names: Twenty.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Twenty name (e.g., "初一", "初二", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Twenty.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Twenty from index
    /// - Parameter index: Twenty index (0-19)
    /// - Returns: Twenty instance
    public static func fromIndex(_ index: Int) -> Twenty {
        return Twenty(index: index)
    }

    /// Get Twenty from name
    /// - Parameter name: Twenty name (e.g., "初一", "初二", etc.)
    /// - Returns: Twenty instance
    public static func fromName(_ name: String) throws -> Twenty {
        return try Twenty(name: name)
    }

    /// Get next twenty
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Twenty instance
    public override func next(_ n: Int) -> Twenty {
        return Twenty.fromIndex(nextIndex(n))
    }

    /// Get day number (1-20)
    /// - Returns: Day number
    public func getDayNumber() -> Int {
        return index + 1
    }
}
