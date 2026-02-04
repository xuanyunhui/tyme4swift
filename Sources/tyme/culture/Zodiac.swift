import Foundation

/// 生肖 (Chinese Zodiac)
/// 十二生肖对应十二地支，循环系统
public final class Zodiac: LoopTyme {
    public static let NAMES = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]

    /// Initialize with index
    /// - Parameter index: Zodiac index (0-11)
    public init(_ index: Int) {
        super.init(names: Zodiac.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Zodiac name (e.g., "鼠", "牛", etc.)
    public init(_ name: String) {
        guard let idx = Zodiac.NAMES.firstIndex(of: name) else {
            fatalError("Invalid zodiac name: \(name)")
        }
        super.init(names: Zodiac.NAMES, index: idx)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get zodiac from index
    /// - Parameter index: Zodiac index (0-11)
    /// - Returns: Zodiac instance
    public static func fromIndex(_ index: Int) -> Zodiac {
        return Zodiac(index)
    }

    /// Get zodiac from name
    /// - Parameter name: Zodiac name (e.g., "鼠", "牛", etc.)
    /// - Returns: Zodiac instance
    public static func fromName(_ name: String) -> Zodiac {
        return Zodiac(name)
    }

    /// Get next zodiac
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next zodiac instance
    public override func next(_ n: Int) -> Zodiac {
        return Zodiac.fromIndex(nextIndex(n))
    }

    /// Get corresponding earth branch
    /// - Returns: EarthBranch corresponding to this zodiac
    public func getEarthBranch() -> EarthBranch {
        return EarthBranch.fromIndex(index)
    }
}
