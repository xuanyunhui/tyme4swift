import Foundation

/// 三候 (Three Phenology Periods)
/// 初候、二候、三候 - The three five-day periods within each solar term
public final class ThreePhenology: LoopTyme {
    /// ThreePhenology names (三候名称)
    public static let NAMES = ["初候", "二候", "三候"]

    /// Initialize with index
    /// - Parameter index: ThreePhenology index (0-2)
    public convenience init(index: Int) {
        self.init(names: ThreePhenology.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: ThreePhenology name (e.g., "初候", "二候", "三候")
    public convenience init(name: String) {
        self.init(names: ThreePhenology.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get ThreePhenology from index
    /// - Parameter index: ThreePhenology index (0-2)
    /// - Returns: ThreePhenology instance
    public static func fromIndex(_ index: Int) -> ThreePhenology {
        return ThreePhenology(index: index)
    }

    /// Get ThreePhenology from name
    /// - Parameter name: ThreePhenology name (e.g., "初候", "二候", "三候")
    /// - Returns: ThreePhenology instance
    public static func fromName(_ name: String) -> ThreePhenology {
        return ThreePhenology(name: name)
    }

    /// Get next three-phenology
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next ThreePhenology instance
    public override func next(_ n: Int) -> ThreePhenology {
        return ThreePhenology.fromIndex(nextIndex(n))
    }
}
