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
    public convenience init(name: String) {
        self.init(names: NineStar.NAMES, name: name)
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
    public static func fromName(_ name: String) -> NineStar {
        return NineStar(name: name)
    }

    /// Get NineStar from celestial name
    /// - Parameter celestialName: Celestial name (e.g., "贪狼", "巨门", etc.)
    /// - Returns: NineStar instance
    public static func fromCelestialName(_ celestialName: String) -> NineStar {
        guard let idx = NineStar.CELESTIAL_NAMES.firstIndex(of: celestialName) else {
            fatalError("Invalid celestial name: \(celestialName)")
        }
        return NineStar(index: idx)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next NineStar instance
    public override func next(_ n: Int) -> NineStar {
        return NineStar.fromIndex(nextIndex(n))
    }

    /// Get steps to target index
    /// - Parameter targetIndex: Target index
    /// - Returns: Number of steps
    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = NineStar.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    // MARK: - Properties

    /// Get full name with celestial name
    /// - Returns: Full star name (e.g., "一白贪狼")
    public func getFullName() -> String {
        return NineStar.FULL_NAMES[index]
    }

    /// Get celestial name
    /// - Returns: Celestial name (e.g., "贪狼")
    public func getCelestialName() -> String {
        return NineStar.CELESTIAL_NAMES[index]
    }

    /// Get YinYang
    /// - Returns: YinYang (阳 or 阴)
    public func getYinYang() -> String {
        return NineStar.YIN_YANG[index]
    }

    /// Get WuXing (五行)
    /// - Returns: Element (金, 木, 水, 火, 土)
    public func getWuXing() -> String {
        return NineStar.WU_XING[index]
    }

    /// Get Element instance
    /// - Returns: Element instance
    public func getElement() -> Element {
        return Element.fromName(NineStar.WU_XING[index])
    }

    /// Get direction
    /// - Returns: Direction name
    public func getDirection() -> String {
        return NineStar.DIRECTIONS[index]
    }

    /// Get Direction instance
    /// - Returns: Direction instance (nil for center)
    public func getDirectionInstance() -> Direction? {
        let dir = NineStar.DIRECTIONS[index]
        if dir == "中" {
            return nil
        }
        return Direction.fromName(dir)
    }

    /// Get Bagua (八卦)
    /// - Returns: Bagua name
    public func getBagua() -> String {
        return NineStar.BAGUA[index]
    }

    /// Get color
    /// - Returns: Color name
    public func getColor() -> String {
        return NineStar.COLORS[index]
    }

    /// Get luck (吉凶)
    /// - Returns: Luck (吉, 凶, or 中)
    public func getLuck() -> String {
        return NineStar.LUCK[index]
    }

    /// Check if this is an auspicious star
    /// - Returns: true if auspicious
    public func isAuspicious() -> Bool {
        return NineStar.LUCK[index] == "吉"
    }

    /// Check if this is an inauspicious star
    /// - Returns: true if inauspicious
    public func isInauspicious() -> Bool {
        return NineStar.LUCK[index] == "凶"
    }

    /// Get number (数字)
    /// - Returns: Star number (1-9)
    public func getNumber() -> Int {
        return index + 1
    }
}
