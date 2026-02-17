import Foundation

/// 地支彭祖百忌 (Pengzu Taboos for Earth Branches)
/// 彭祖百忌是中国传统的择日禁忌，根据天干地支来判断每日宜忌
/// Each of the 12 Earth Branches has specific taboo activities
public final class PengZuEarthBranch: LoopTyme {
    /// Names of the 12 Earth Branch taboos
    /// 子-亥 对应的彭祖百忌
    public static let NAMES = [
        "子不问卜自惹祸殃",  // 子日不宜占卜，否则会自招祸患
        "丑不冠带主不还乡",  // 丑日不宜戴冠（出行），否则主人难以还乡
        "寅不祭祀神鬼不尝",  // 寅日不宜祭祀，否则神鬼不会享用
        "卯不穿井水泉不香",  // 卯日不宜打井，否则水质不好
        "辰不哭泣必主重丧",  // 辰日不宜哭泣，否则会有重丧
        "巳不远行财物伏藏",  // 巳日不宜远行，否则财物会丢失
        "午不苫盖屋主更张",  // 午日不宜盖屋顶，否则屋主会有变故
        "未不服药毒气入肠",  // 未日不宜服药，否则药毒入肠
        "申不安床鬼祟入房",  // 申日不宜安床，否则鬼祟入房
        "酉不会客醉坐颠狂",  // 酉日不宜会客，否则会醉酒失态
        "戌不吃犬作怪上床",  // 戌日不宜吃狗肉，否则会作怪
        "亥不嫁娶不利新郎"   // 亥日不宜嫁娶，否则不利新郎
    ]

    /// Initialize with name
    /// - Parameter name: The taboo name
    public init(_ name: String) throws {
        guard let idx = PengZuEarthBranch.NAMES.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        super.init(names: PengZuEarthBranch.NAMES, index: idx)
    }

    /// Initialize with index
    /// - Parameter index: Index (0-11)
    public init(_ index: Int) {
        super.init(names: PengZuEarthBranch.NAMES, index: index)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Create from name
    /// - Parameter name: The taboo name
    /// - Returns: PengZuEarthBranch instance
    public static func fromName(_ name: String) throws -> PengZuEarthBranch {
        return try PengZuEarthBranch(name)
    }

    /// Create from index
    /// - Parameter index: Index (0-11)
    /// - Returns: PengZuEarthBranch instance
    public static func fromIndex(_ index: Int) -> PengZuEarthBranch {
        return PengZuEarthBranch(index)
    }

    /// Get next PengZuEarthBranch
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next PengZuEarthBranch instance
    public override func next(_ n: Int) -> PengZuEarthBranch {
        return try! PengZuEarthBranch(nextIndex(n))
    }
}
