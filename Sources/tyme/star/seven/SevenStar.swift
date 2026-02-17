import Foundation

/// 七曜 (Seven Stars / Seven Luminaries)
/// 七政、七纬、七耀 - Sun, Moon, and five planets
/// Used in traditional Chinese astronomy and calendar
public final class SevenStar: LoopTyme {
    /// Star names (七曜名称)
    /// 日(Sun), 月(Moon), 火(Mars), 水(Mercury), 木(Jupiter), 金(Venus), 土(Saturn)
    public static let NAMES = ["日", "月", "火", "水", "木", "金", "土"]

    /// Initialize with index
    /// - Parameter index: Star index (0-6)
    public convenience init(index: Int) {
        self.init(names: SevenStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "日", "月", etc.)
    public convenience init(name: String) throws {
        try self.init(names: SevenStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get SevenStar from index
    /// - Parameter index: Star index (0-6)
    /// - Returns: SevenStar instance
    public static func fromIndex(_ index: Int) -> SevenStar {
        return SevenStar(index: index)
    }

    /// Get SevenStar from name
    /// - Parameter name: Star name (e.g., "日", "月", etc.)
    /// - Returns: SevenStar instance
    public static func fromName(_ name: String) throws -> SevenStar {
        return try SevenStar(name: name)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next SevenStar instance
    public override func next(_ n: Int) -> SevenStar {
        return SevenStar.fromIndex(nextIndex(n))
    }

    public var week: Week { Week.fromIndex(index) }

    @available(*, deprecated, renamed: "week")
    public func getWeek() -> Week { week }
}
