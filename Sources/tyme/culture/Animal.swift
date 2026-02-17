import Foundation

/// 动物 (Animal - 28 Animals for TwentyEightStar)
/// Each of the 28 lunar mansions is associated with an animal
public final class Animal: LoopTyme {
    /// Animal names (动物名称)
    public static let NAMES = ["蛟", "龙", "貉", "兔", "狐", "虎", "豹", "獬", "牛", "蝠", "鼠", "燕", "猪", "獝", "狼", "狗", "彘", "鸡", "乌", "猴", "猿", "犴", "羊", "獐", "马", "鹿", "蛇", "蚓"]

    /// Initialize with index
    /// - Parameter index: Animal index (0-27)
    public convenience init(index: Int) {
        self.init(names: Animal.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Animal name (e.g., "蛟", "龙", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Animal.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Animal from index
    /// - Parameter index: Animal index (0-27)
    /// - Returns: Animal instance
    public static func fromIndex(_ index: Int) -> Animal {
        return Animal(index: index)
    }

    /// Get Animal from name
    /// - Parameter name: Animal name (e.g., "蛟", "龙", etc.)
    /// - Returns: Animal instance
    public static func fromName(_ name: String) throws -> Animal {
        return try Animal(name: name)
    }

    /// Get next animal
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Animal instance
    public override func next(_ n: Int) -> Animal {
        return Animal.fromIndex(nextIndex(n))
    }

    /// Get corresponding TwentyEightStar (二十八宿)
    /// - Returns: TwentyEightStar instance
    public func getTwentyEightStar() -> TwentyEightStar {
        return TwentyEightStar.fromIndex(index)
    }
}
