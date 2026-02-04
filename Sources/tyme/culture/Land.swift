import Foundation

/// 九野 (Land - Nine Celestial Fields)
/// 玄天、朱天、苍天、阳天、钧天、幽天、颢天、变天、炎天
/// The nine regions of the sky in Chinese astronomy
public final class Land: LoopTyme {
    /// Land names (九野名称)
    public static let NAMES = ["玄天", "朱天", "苍天", "阳天", "钧天", "幽天", "颢天", "变天", "炎天"]

    /// Initialize with index
    /// - Parameter index: Land index (0-8)
    public convenience init(index: Int) {
        self.init(names: Land.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Land name (e.g., "玄天", "朱天", etc.)
    public convenience init(name: String) {
        self.init(names: Land.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Land from index
    /// - Parameter index: Land index (0-8)
    /// - Returns: Land instance
    public static func fromIndex(_ index: Int) -> Land {
        return Land(index: index)
    }

    /// Get Land from name
    /// - Parameter name: Land name (e.g., "玄天", "朱天", etc.)
    /// - Returns: Land instance
    public static func fromName(_ name: String) -> Land {
        return Land(name: name)
    }

    /// Get next land
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Land instance
    public override func next(_ n: Int) -> Land {
        return Land.fromIndex(nextIndex(n))
    }

    /// Get direction (方位)
    /// - Returns: Direction instance
    public func getDirection() -> Direction {
        return Direction.fromIndex(index)
    }
}
