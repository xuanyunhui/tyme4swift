import Foundation

/// 十日 (Ten Days)
/// 甲、乙、丙、丁、戊、己、庚、辛、壬、癸
/// The ten days of a traditional Chinese week (旬)
public final class TenDay: LoopTyme {
    /// TenDay names (十日名称)
    public static let NAMES = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]

    /// Initialize with index
    /// - Parameter index: TenDay index (0-9)
    public convenience init(index: Int) {
        self.init(names: TenDay.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: TenDay name (e.g., "甲", "乙", etc.)
    public convenience init(name: String) throws {
        try self.init(names: TenDay.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Get TenDay from index
    /// - Parameter index: TenDay index (0-9)
    /// - Returns: TenDay instance
    public static func fromIndex(_ index: Int) -> TenDay {
        return TenDay(index: index)
    }

    /// Get TenDay from name
    /// - Parameter name: TenDay name (e.g., "甲", "乙", etc.)
    /// - Returns: TenDay instance
    public static func fromName(_ name: String) throws -> TenDay {
        return try TenDay(name: name)
    }

    /// Get next ten day
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next TenDay instance
    public override func next(_ n: Int) -> TenDay {
        return TenDay.fromIndex(nextIndex(n))
    }

    /// Get corresponding HeavenStem
    /// - Returns: HeavenStem instance
    public func getHeavenStem() -> HeavenStem {
        return HeavenStem.fromIndex(index)
    }
}
