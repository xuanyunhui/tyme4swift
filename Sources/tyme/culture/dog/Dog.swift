import Foundation

/// 三伏 (Dog Days)
/// The three periods of hot weather in summer
/// 初伏、中伏、末伏
public final class Dog: LoopTyme {
    /// Dog day names (三伏名称)
    public static let NAMES = ["初伏", "中伏", "末伏"]

    /// Initialize with index
    /// - Parameter index: Dog index (0-2)
    public convenience init(index: Int) {
        self.init(names: Dog.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Dog name (e.g., "初伏", "中伏", "末伏")
    public convenience init(name: String) throws {
        try self.init(names: Dog.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Dog from index
    /// - Parameter index: Dog index (0-2)
    /// - Returns: Dog instance
    public static func fromIndex(_ index: Int) -> Dog {
        return Dog(index: index)
    }

    /// Get Dog from name
    /// - Parameter name: Dog name (e.g., "初伏", "中伏", "末伏")
    /// - Returns: Dog instance
    public static func fromName(_ name: String) throws -> Dog {
        return try Dog(name: name)
    }

    /// Get next dog period
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Dog instance
    public override func next(_ n: Int) -> Dog {
        return Dog.fromIndex(nextIndex(n))
    }
}
