import Foundation

/// 建除十二值神 (Duty - Twelve Day Officers)
/// 建、除、满、平、定、执、破、危、成、收、开、闭
/// Used to determine auspicious activities for each day
public final class Duty: LoopTyme {
    /// Duty names (十二值神名称)
    public static let NAMES = ["建", "除", "满", "平", "定", "执", "破", "危", "成", "收", "开", "闭"]

    /// Initialize with index
    /// - Parameter index: Duty index (0-11)
    public convenience init(index: Int) {
        self.init(names: Duty.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Duty name (e.g., "建", "除", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Duty.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Duty from index
    /// - Parameter index: Duty index (0-11)
    /// - Returns: Duty instance
    public static func fromIndex(_ index: Int) -> Duty {
        return Duty(index: index)
    }

    /// Get Duty from name
    /// - Parameter name: Duty name (e.g., "建", "除", etc.)
    /// - Returns: Duty instance
    public static func fromName(_ name: String) throws -> Duty {
        return try Duty(name: name)
    }

    /// Get next duty
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Duty instance
    public override func next(_ n: Int) -> Duty {
        return Duty.fromIndex(nextIndex(n))
    }
}
