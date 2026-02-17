import Foundation

/// 神兽 (Beast - Four Divine Beasts)
/// 青龙、玄武、白虎、朱雀 - The four celestial guardians
public final class Beast: LoopTyme {
    /// Beast names (神兽名称)
    public static let NAMES = ["青龙", "玄武", "白虎", "朱雀"]

    /// Initialize with index
    /// - Parameter index: Beast index (0-3)
    public convenience init(index: Int) {
        self.init(names: Beast.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Beast name ("青龙", "玄武", "白虎", "朱雀")
    public convenience init(name: String) throws {
        try self.init(names: Beast.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Beast from index
    /// - Parameter index: Beast index (0-3)
    /// - Returns: Beast instance
    public static func fromIndex(_ index: Int) -> Beast {
        return Beast(index: index)
    }

    /// Get Beast from name
    /// - Parameter name: Beast name ("青龙", "玄武", "白虎", "朱雀")
    /// - Returns: Beast instance
    public static func fromName(_ name: String) throws -> Beast {
        return try Beast(name: name)
    }

    /// Get next beast
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Beast instance
    public override func next(_ n: Int) -> Beast {
        return Beast.fromIndex(nextIndex(n))
    }

    /// Get zone (宫)
    /// - Returns: Zone instance
    public func getZone() -> Zone {
        return Zone.fromIndex(index)
    }
}
