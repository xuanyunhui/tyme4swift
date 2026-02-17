import Foundation

/// 九宫日 (Nine Palace Day)
/// 九宫日是根据九宫飞星理论计算的日期系统
/// 用于风水、择日等传统应用
public final class NineDay: LoopTyme {
    /// Nine palace names (九宫名称)
    public static let NAMES = ["坎", "坤", "震", "巽", "中", "乾", "兑", "艮", "离"]

    /// Nine palace numbers (九宫数字)
    public static let NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    /// Direction mapping (方位)
    private static let DIRECTIONS = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]

    /// WuXing (五行) mapping
    private static let WU_XING = ["水", "土", "木", "木", "土", "金", "金", "土", "火"]

    /// Initialize with index
    /// - Parameter index: Palace index (0-8)
    public convenience init(index: Int) {
        self.init(names: NineDay.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Palace name (e.g., "坎", "坤", etc.)
    public convenience init(name: String) throws {
        try self.init(names: NineDay.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get NineDay from index
    /// - Parameter index: Palace index (0-8)
    /// - Returns: NineDay instance
    public static func fromIndex(_ index: Int) -> NineDay {
        return NineDay(index: index)
    }

    /// Get NineDay from name
    /// - Parameter name: Palace name (e.g., "坎", "坤", etc.)
    /// - Returns: NineDay instance
    public static func fromName(_ name: String) throws -> NineDay {
        return try NineDay(name: name)
    }

    /// Get NineDay from number
    /// - Parameter number: Palace number (1-9)
    /// - Returns: NineDay instance
    public static func fromNumber(_ number: Int) -> NineDay {
        return NineDay(index: number - 1)
    }

    /// Get next palace
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next NineDay instance
    public override func next(_ n: Int) -> NineDay {
        return NineDay.fromIndex(nextIndex(n))
    }

    /// Get steps to target index
    /// - Parameter targetIndex: Target index
    /// - Returns: Number of steps
    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = NineDay.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    // MARK: - Properties

    public var number: Int { NineDay.NUMBERS[index] }
    public var direction: String { NineDay.DIRECTIONS[index] }
    public var wuXing: String { NineDay.WU_XING[index] }
    public var nineStar: NineStar { NineStar.fromIndex(index) }

    @available(*, deprecated, renamed: "number")
    public func getNumber() -> Int { number }

    @available(*, deprecated, renamed: "direction")
    public func getDirection() -> String { direction }

    @available(*, deprecated, renamed: "wuXing")
    public func getWuXing() -> String { wuXing }

    @available(*, deprecated, renamed: "nineStar")
    public func getNineStar() -> NineStar { nineStar }
}
