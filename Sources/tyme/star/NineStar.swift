import Foundation

/// 九星 (Nine Stars)
/// 九星是中国古代天文学中的九颗星，用于风水、命理等
/// Stars: 一白贪狼, 二黑巨门, 三碧禄存, 四绿文曲, 五黄廉贞, 六白武曲, 七赤破军, 八白左辅, 九紫右弼
public final class NineStar: LoopTyme {
    /// Star names (九星名称)
    public static let NAMES = ["一白", "二黑", "三碧", "四绿", "五黄", "六白", "七赤", "八白", "九紫"]

    /// Full star names with celestial names (九星全名)
    public static let FULL_NAMES = ["一白贪狼", "二黑巨门", "三碧禄存", "四绿文曲", "五黄廉贞", "六白武曲", "七赤破军", "八白左辅", "九紫右弼"]

    /// Celestial names (星宿名)
    public static let CELESTIAL_NAMES = ["贪狼", "巨门", "禄存", "文曲", "廉贞", "武曲", "破军", "左辅", "右弼"]

    /// YinYang mapping (阴阳)
    /// 一白、三碧、五黄、七赤、九紫为阳; 二黑、四绿、六白、八白为阴
    private static let YIN_YANG = ["阳", "阴", "阳", "阴", "阳", "阴", "阳", "阴", "阳"]

    /// WuXing (五行) mapping
    /// 一白水, 二黑土, 三碧木, 四绿木, 五黄土, 六白金, 七赤金, 八白土, 九紫火
    private static let WU_XING = ["水", "土", "木", "木", "土", "金", "金", "土", "火"]

    /// Direction mapping (方位)
    /// 一白坎北, 二黑坤西南, 三碧震东, 四绿巽东南, 五黄中央, 六白乾西北, 七赤兑西, 八白艮东北, 九紫离南
    private static let DIRECTIONS = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]

    /// Bagua (八卦) mapping
    private static let BAGUA = ["坎", "坤", "震", "巽", "中", "乾", "兑", "艮", "离"]

    /// Color names (颜色)
    private static let COLORS = ["白", "黑", "碧", "绿", "黄", "白", "赤", "白", "紫"]

    /// Luck mapping (吉凶)
    /// 一白、六白、八白为吉星; 二黑、五黄、七赤为凶星; 三碧、四绿、九紫为中性
    private static let LUCK = ["吉", "凶", "中", "中", "凶", "吉", "凶", "吉", "中"]

    /// Initialize with index
    /// - Parameter index: Star index (0-8)
    public convenience init(index: Int) {
        self.init(names: NineStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "一白", "二黑", etc.)
    public convenience init(name: String) throws {
        try self.init(names: NineStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get NineStar from index
    /// - Parameter index: Star index (0-8)
    /// - Returns: NineStar instance
    public static func fromIndex(_ index: Int) -> NineStar {
        return NineStar(index: index)
    }

    /// Get NineStar from name
    /// - Parameter name: Star name (e.g., "一白", "二黑", etc.)
    /// - Returns: NineStar instance
    public static func fromName(_ name: String) throws -> NineStar {
        return try NineStar(name: name)
    }

    /// Get NineStar from celestial name
    /// - Parameter celestialName: Celestial name (e.g., "贪狼", "巨门", etc.)
    /// - Returns: NineStar instance
    public static func fromCelestialName(_ celestialName: String) throws -> NineStar {
        guard let idx = NineStar.CELESTIAL_NAMES.firstIndex(of: celestialName) else {
            throw TymeError.invalidName(celestialName)
        }
        return NineStar(index: idx)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next NineStar instance
    public override func next(_ n: Int) -> NineStar {
        return NineStar.fromIndex(nextIndex(n))
    }

    // MARK: - Properties

    public var fullName: String { NineStar.FULL_NAMES[index] }
    public var celestialName: String { NineStar.CELESTIAL_NAMES[index] }
    public var yinYang: String { NineStar.YIN_YANG[index] }
    public var wuXing: String { NineStar.WU_XING[index] }
    public var element: Element {
        guard let e = try? Element.fromName(NineStar.WU_XING[index]) else {
            preconditionFailure("NineStar: invalid element lookup")
        }
        return e
    }
    public var direction: String { NineStar.DIRECTIONS[index] }
    public var directionInstance: Direction? {
        let dir = NineStar.DIRECTIONS[index]
        if dir == "中" { return nil }
        guard let d = try? Direction.fromName(dir) else {
            preconditionFailure("NineStar: invalid direction lookup")
        }
        return d
    }
    public var bagua: String { NineStar.BAGUA[index] }
    public var color: String { NineStar.COLORS[index] }
    public var luck: String { NineStar.LUCK[index] }
    public var number: Int { index + 1 }

    public var auspicious: Bool { NineStar.LUCK[index] == "吉" }
    public var inauspicious: Bool { NineStar.LUCK[index] == "凶" }

    @available(*, deprecated, renamed: "auspicious")
    public func isAuspicious() -> Bool { auspicious }
    @available(*, deprecated, renamed: "inauspicious")
    public func isInauspicious() -> Bool { inauspicious }

    public override var description: String {
        name + element.name
    }

    @available(*, deprecated, renamed: "fullName")
    public func getFullName() -> String { fullName }

    @available(*, deprecated, renamed: "celestialName")
    public func getCelestialName() -> String { celestialName }

    @available(*, deprecated, renamed: "yinYang")
    public func getYinYang() -> String { yinYang }

    @available(*, deprecated, renamed: "wuXing")
    public func getWuXing() -> String { wuXing }

    @available(*, deprecated, renamed: "element")
    public func getElement() -> Element { element }

    @available(*, deprecated, renamed: "direction")
    public func getDirection() -> String { direction }

    @available(*, deprecated, renamed: "directionInstance")
    public func getDirectionInstance() -> Direction? { directionInstance }

    @available(*, deprecated, renamed: "bagua")
    public func getBagua() -> String { bagua }

    @available(*, deprecated, renamed: "color")
    public func getColor() -> String { color }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> String { luck }

    @available(*, deprecated, renamed: "number")
    public func getNumber() -> Int { number }
}
