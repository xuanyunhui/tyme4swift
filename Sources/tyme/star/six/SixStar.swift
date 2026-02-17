import Foundation

/// 六曜 (Six Stars / Kongming Six Stars)
/// 孔明六曜星 - Used in Japanese and Chinese fortune telling
/// Determines auspicious/inauspicious times of day
public final class SixStar: LoopTyme {
    /// Star names (六曜名称)
    public static let NAMES = ["先胜", "友引", "先负", "佛灭", "大安", "赤口"]

    /// Initialize with index
    /// - Parameter index: Star index (0-5)
    public convenience init(index: Int) {
        self.init(names: SixStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "先胜", "友引", etc.)
    public convenience init(name: String) throws {
        try self.init(names: SixStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get SixStar from index
    /// - Parameter index: Star index (0-5)
    /// - Returns: SixStar instance
    public static func fromIndex(_ index: Int) -> SixStar {
        return SixStar(index: index)
    }

    /// Get SixStar from name
    /// - Parameter name: Star name (e.g., "先胜", "友引", etc.)
    /// - Returns: SixStar instance
    public static func fromName(_ name: String) throws -> SixStar {
        return try SixStar(name: name)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next SixStar instance
    public override func next(_ n: Int) -> SixStar {
        return SixStar.fromIndex(nextIndex(n))
    }
}
