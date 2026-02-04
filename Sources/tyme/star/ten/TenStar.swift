import Foundation

/// 十神 (Ten Gods / Ten Stars)
/// Used in BaZi (Four Pillars of Destiny) analysis
/// Represents relationships between heavenly stems
public final class TenStar: LoopTyme {
    /// Star names (十神名称)
    public static let NAMES = ["比肩", "劫财", "食神", "伤官", "偏财", "正财", "七杀", "正官", "偏印", "正印"]

    /// Initialize with index
    /// - Parameter index: Star index (0-9)
    public convenience init(index: Int) {
        self.init(names: TenStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "比肩", "劫财", etc.)
    public convenience init(name: String) {
        self.init(names: TenStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get TenStar from index
    /// - Parameter index: Star index (0-9)
    /// - Returns: TenStar instance
    public static func fromIndex(_ index: Int) -> TenStar {
        return TenStar(index: index)
    }

    /// Get TenStar from name
    /// - Parameter name: Star name (e.g., "比肩", "劫财", etc.)
    /// - Returns: TenStar instance
    public static func fromName(_ name: String) -> TenStar {
        return TenStar(name: name)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next TenStar instance
    public override func next(_ n: Int) -> TenStar {
        return TenStar.fromIndex(nextIndex(n))
    }
}
