import Foundation

/// 旬 (Decad/Ten-day Period)
/// 上旬、中旬、下旬 - The three ten-day periods of a month
public final class Phase: LoopTyme {
    /// Phase names (旬名称)
    public static let NAMES = ["上旬", "中旬", "下旬"]

    /// Initialize with index
    /// - Parameter index: Phase index (0-2)
    public convenience init(index: Int) {
        self.init(names: Phase.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Phase name (e.g., "上旬", "中旬", "下旬")
    public convenience init(name: String) {
        self.init(names: Phase.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Phase from index
    /// - Parameter index: Phase index (0-2)
    /// - Returns: Phase instance
    public static func fromIndex(_ index: Int) -> Phase {
        return Phase(index: index)
    }

    /// Get Phase from name
    /// - Parameter name: Phase name (e.g., "上旬", "中旬", "下旬")
    /// - Returns: Phase instance
    public static func fromName(_ name: String) -> Phase {
        return Phase(name: name)
    }

    /// Get next phase
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Phase instance
    public override func next(_ n: Int) -> Phase {
        return Phase.fromIndex(nextIndex(n))
    }
}
