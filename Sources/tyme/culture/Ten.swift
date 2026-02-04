import Foundation

/// 十 (Ten)
/// 十日 - The ten days of a traditional Chinese week (旬)
public final class Ten: LoopTyme {
    /// Ten names (十日名称)
    public static let NAMES = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]

    /// Initialize with index
    /// - Parameter index: Ten index (0-9)
    public convenience init(index: Int) {
        self.init(names: Ten.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Ten name (e.g., "一", "二", etc.)
    public convenience init(name: String) {
        self.init(names: Ten.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Ten from index
    /// - Parameter index: Ten index (0-9)
    /// - Returns: Ten instance
    public static func fromIndex(_ index: Int) -> Ten {
        return Ten(index: index)
    }

    /// Get Ten from name
    /// - Parameter name: Ten name (e.g., "一", "二", etc.)
    /// - Returns: Ten instance
    public static func fromName(_ name: String) -> Ten {
        return Ten(name: name)
    }

    /// Get next ten
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Ten instance
    public override func next(_ n: Int) -> Ten {
        return Ten.fromIndex(nextIndex(n))
    }

    /// Get day number (1-10)
    /// - Returns: Day number
    public func getDayNumber() -> Int {
        return index + 1
    }
}
