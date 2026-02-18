import Foundation

/// 物候 (Phenology - Seasonal Phenomena)
/// 72 phenological periods in the Chinese calendar
/// Each solar term has 3 phenological periods (候)
public final class Phenology: LoopTyme {
    /// Phenology names (七十二候名称)
    public static let NAMES = [
        "蚯蚓结", "麋角解", "水泉动",
        "雁北乡", "鹊始巢", "雉始雊",
        "鸡始乳", "征鸟厉疾", "水泽腹坚",
        "东风解冻", "蛰虫始振", "鱼陟负冰",
        "獭祭鱼", "候雁北", "草木萌动",
        "桃始华", "仓庚鸣", "鹰化为鸠",
        "玄鸟至", "雷乃发声", "始电",
        "桐始华", "田鼠化为鴽", "虹始见",
        "萍始生", "鸣鸠拂其羽", "戴胜降于桑",
        "蝼蝈鸣", "蚯蚓出", "王瓜生",
        "苦菜秀", "靡草死", "麦秋至",
        "螳螂生", "鵙始鸣", "反舌无声",
        "鹿角解", "蜩始鸣", "半夏生",
        "温风至", "蟋蟀居壁", "鹰始挚",
        "腐草为萤", "土润溽暑", "大雨行时",
        "凉风至", "白露降", "寒蝉鸣",
        "鹰乃祭鸟", "天地始肃", "禾乃登",
        "鸿雁来", "玄鸟归", "群鸟养羞",
        "雷始收声", "蛰虫坯户", "水始涸",
        "鸿雁来宾", "雀入大水为蛤", "菊有黄花",
        "豺乃祭兽", "草木黄落", "蛰虫咸俯",
        "水始冰", "地始冻", "雉入大水为蜃",
        "虹藏不见", "天气上升地气下降", "闭塞而成冬",
        "鹖鴠不鸣", "虎始交", "荔挺出"
    ]

    /// 年
    public private(set) var year: Int

    /// Initialize with year and index (aligned with tyme4j)
    public init(year: Int, index: Int) {
        let size = Phenology.NAMES.count
        self.year = (year * size + index) / size
        super.init(names: Phenology.NAMES, index: index)
    }

    /// Required initializer from LoopTyme (no year context, year = 0)
    public required init(names: [String], index: Int) {
        self.year = 0
        super.init(names: names, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Phenology name
    public convenience init(name: String) throws {
        try self.init(names: Phenology.NAMES, name: name)
    }

    /// 儒略日
    public var julianDay: JulianDay {
        let t = ShouXingUtil.saLonT((Double(year) - 2000.0 + (Double(index) - 18.0) * 5.0 / 360.0 + 1.0) * 2.0 * .pi)
        return JulianDay.fromJulianDay(t * 36525.0 + JulianDay.J2000 + 8.0 / 24.0 - ShouXingUtil.dtT(t * 36525.0))
    }

    /// Get Phenology from year and index
    public static func fromIndex(_ year: Int, _ index: Int) -> Phenology {
        return Phenology(year: year, index: index)
    }

    /// Get Phenology from index (no year context)
    public static func fromIndex(_ index: Int) -> Phenology {
        return Phenology(names: Phenology.NAMES, index: index)
    }

    /// Get Phenology from name
    /// - Parameter name: Phenology name
    /// - Returns: Phenology instance
    public static func fromName(_ name: String) throws -> Phenology {
        return try Phenology(name: name)
    }

    /// Get next phenology (carries year context)
    public override func next(_ n: Int) -> Phenology {
        let size = Phenology.NAMES.count
        let i = index + n
        return Phenology.fromIndex((year * size + i) / size, indexOf(i, size))
    }

    public var threePhenology: ThreePhenology { ThreePhenology.fromIndex(index % 3) }
    public var solarTermIndex: Int { index / 3 }

    @available(*, deprecated, renamed: "threePhenology")
    public func getThreePhenology() -> ThreePhenology { threePhenology }

    @available(*, deprecated, renamed: "solarTermIndex")
    public func getSolarTermIndex() -> Int { solarTermIndex }

    @available(*, deprecated, renamed: "julianDay")
    public func getJulianDay() -> JulianDay { julianDay }
}
