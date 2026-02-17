import Foundation

/// 数九 (Nine)
/// The nine periods of cold weather in winter
/// 一九、二九、三九、四九、五九、六九、七九、八九、九九
public final class Nine: LoopTyme {
    /// Nine names (数九名称)
    public static let NAMES = ["一九", "二九", "三九", "四九", "五九", "六九", "七九", "八九", "九九"]

    /// Initialize with index
    /// - Parameter index: Nine index (0-8)
    public convenience init(index: Int) {
        self.init(names: Nine.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Nine name (e.g., "一九", "二九", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Nine.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Nine from index
    /// - Parameter index: Nine index (0-8)
    /// - Returns: Nine instance
    public static func fromIndex(_ index: Int) -> Nine {
        return Nine(index: index)
    }

    /// Get Nine from name
    /// - Parameter name: Nine name (e.g., "一九", "二九", etc.)
    /// - Returns: Nine instance
    public static func fromName(_ name: String) throws -> Nine {
        return try Nine(name: name)
    }

    /// Get next nine period
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Nine instance
    public override func next(_ n: Int) -> Nine {
        return Nine.fromIndex(nextIndex(n))
    }
}
