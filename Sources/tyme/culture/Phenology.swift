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
        "腐草为萤", "土润溽暑", "大雨时行",
        "凉风至", "白露降", "寒蝉鸣",
        "鹰乃祭鸟", "天地始肃", "禾乃登",
        "鸿雁来", "玄鸟归", "群鸟养羞",
        "雷始收声", "蛰虫坯户", "水始涸",
        "鸿雁来宾", "雀入大水为蛤", "菊有黄华",
        "豺乃祭兽", "草木黄落", "蛰虫咸俯",
        "水始冰", "地始冻", "雉入大水为蜃",
        "虹藏不见", "天气上升地气下降", "闭塞成冬",
        "鹖鴠不鸣", "虎始交", "荔挺出"
    ]

    /// Initialize with index
    /// - Parameter index: Phenology index (0-71)
    public convenience init(index: Int) {
        self.init(names: Phenology.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Phenology name
    public convenience init(name: String) {
        self.init(names: Phenology.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Phenology from index
    /// - Parameter index: Phenology index (0-71)
    /// - Returns: Phenology instance
    public static func fromIndex(_ index: Int) -> Phenology {
        return Phenology(index: index)
    }

    /// Get Phenology from name
    /// - Parameter name: Phenology name
    /// - Returns: Phenology instance
    public static func fromName(_ name: String) -> Phenology {
        return Phenology(name: name)
    }

    /// Get next phenology
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Phenology instance
    public override func next(_ n: Int) -> Phenology {
        return Phenology.fromIndex(nextIndex(n))
    }

    /// Get the three-phenology period (三候)
    /// - Returns: ThreePhenology instance (初候, 二候, 三候)
    public func getThreePhenology() -> ThreePhenology {
        return ThreePhenology.fromIndex(index % 3)
    }

    /// Get the solar term index this phenology belongs to
    /// - Returns: Solar term index (0-23)
    public func getSolarTermIndex() -> Int {
        return index / 3
    }
}
