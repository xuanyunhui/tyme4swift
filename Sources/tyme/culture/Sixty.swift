import Foundation

/// 元（60年=1元）
///
/// Represents the three "Yuan" (元) periods: 上元 (Upper Yuan), 中元 (Middle Yuan), 下元 (Lower Yuan).
/// One Yuan spans 60 years, and three Yuan form one complete cycle.
public final class Sixty: LoopTyme {
    /// Sixty names (三元名称)
    public static let NAMES = ["上元", "中元", "下元"]

    /// Initialize with index
    /// - Parameter index: Sixty index (0-2)
    public convenience init(index: Int) {
        self.init(names: Sixty.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Sixty name ("上元", "中元", or "下元")
    public convenience init(name: String) throws {
        try self.init(names: Sixty.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Sixty from index
    /// - Parameter index: Sixty index (0-2)
    /// - Returns: Sixty instance
    public static func fromIndex(_ index: Int) -> Sixty {
        return Sixty(index: index)
    }

    /// Get Sixty from name
    /// - Parameter name: Sixty name ("上元", "中元", or "下元")
    /// - Returns: Sixty instance
    public static func fromName(_ name: String) throws -> Sixty {
        return try Sixty(name: name)
    }

    /// Get next Sixty
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Sixty instance
    public override func next(_ n: Int) -> Sixty {
        return Sixty.fromIndex(nextIndex(n))
    }
}
