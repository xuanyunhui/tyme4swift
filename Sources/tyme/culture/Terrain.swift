import Foundation

/// 地势 (Terrain)
/// 十二长生 - The twelve stages of life cycle in Chinese metaphysics
/// 长生、沐浴、冠带、临官、帝旺、衰、病、死、墓、绝、胎、养
public final class Terrain: LoopTyme {
    /// Terrain names (地势名称)
    public static let NAMES = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]

    /// Initialize with index
    /// - Parameter index: Terrain index (0-11)
    public convenience init(index: Int) {
        self.init(names: Terrain.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Terrain name (e.g., "长生", "沐浴", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Terrain.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Get Terrain from index
    /// - Parameter index: Terrain index (0-11)
    /// - Returns: Terrain instance
    public static func fromIndex(_ index: Int) -> Terrain {
        return Terrain(index: index)
    }

    /// Get Terrain from name
    /// - Parameter name: Terrain name (e.g., "长生", "沐浴", etc.)
    /// - Returns: Terrain instance
    public static func fromName(_ name: String) throws -> Terrain {
        return try Terrain(name: name)
    }

    /// Get next terrain
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Terrain instance
    public override func next(_ n: Int) -> Terrain {
        return Terrain.fromIndex(nextIndex(n))
    }

    /// Check if this is a prosperous stage (旺相)
    /// - Returns: true if 长生, 冠带, 临官, 帝旺
    public func isProsperous() -> Bool {
        return index == 0 || index == 2 || index == 3 || index == 4
    }

    /// Check if this is a declining stage (衰败)
    /// - Returns: true if 衰, 病, 死, 墓, 绝
    public func isDeclining() -> Bool {
        return index >= 5 && index <= 9
    }

    /// Check if this is a nurturing stage (养育)
    /// - Returns: true if 胎, 养, 沐浴
    public func isNurturing() -> Bool {
        return index == 1 || index == 10 || index == 11
    }
}
