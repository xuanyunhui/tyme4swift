import Foundation

/// 宫 (Zone - Four Celestial Palaces)
/// 东、北、西、南 - The four directions/palaces in Chinese astronomy
public final class Zone: LoopTyme {
    /// Zone names (宫名称)
    public static let NAMES = ["东", "北", "西", "南"]

    /// Initialize with index
    /// - Parameter index: Zone index (0-3)
    public convenience init(index: Int) {
        self.init(names: Zone.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Zone name ("东", "北", "西", "南")
    public convenience init(name: String) throws {
        try self.init(names: Zone.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Zone from index
    /// - Parameter index: Zone index (0-3)
    /// - Returns: Zone instance
    public static func fromIndex(_ index: Int) -> Zone {
        return Zone(index: index)
    }

    /// Get Zone from name
    /// - Parameter name: Zone name ("东", "北", "西", "南")
    /// - Returns: Zone instance
    public static func fromName(_ name: String) throws -> Zone {
        return try Zone(name: name)
    }

    /// Get next zone
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Zone instance
    public override func next(_ n: Int) -> Zone {
        return Zone.fromIndex(nextIndex(n))
    }

    public var direction: Direction {
        guard let d = try? Direction.fromName(getName()) else {
            preconditionFailure("Zone: invalid direction lookup")
        }
        return d
    }
    public var beast: Beast { Beast.fromIndex(index) }

    @available(*, deprecated, renamed: "direction")
    public func getDirection() -> Direction { direction }

    @available(*, deprecated, renamed: "beast")
    public func getBeast() -> Beast { beast }
}
