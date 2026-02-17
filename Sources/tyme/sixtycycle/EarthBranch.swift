import Foundation

/// An Earthly Branch (地支 Dìzhī) in the Chinese sexagenary cycle.
///
/// The 12 Earthly Branches form the other component of the sexagenary cycle.
/// Each branch is associated with a Chinese zodiac animal (生肖 Shēngxiào),
/// a Yin-Yang polarity, and one of the Five Elements.
///
/// ## The 12 Branches (partial)
///
/// | Index | Name | Zodiac | Element |
/// |-------|------|--------|---------|
/// | 0 | 子 (Zǐ) | 鼠 Rat | 水 Water |
/// | 1 | 丑 (Chǒu) | 牛 Ox | 土 Earth |
/// | ... | ... | ... | ... |
///
/// ## Usage
///
/// ```swift
/// let branch = EarthBranch.fromIndex(0)  // 子
/// let zodiac = branch.zodiac             // 鼠 (Rat)
/// let stems = branch.hideHeavenStems     // Hidden stems (藏干 Cánggān)
/// ```
public final class EarthBranch: LoopTyme {
    public static let NAMES = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]

    // Zodiac mapping (生肖)
    private static let ZODIAC_NAMES = ["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"]

    // YinYang mapping for EarthBranch (阴阳)
    private static let YIN_YANG = ["阳","阴","阳","阴","阳","阴","阳","阴","阳","阴","阳","阴"]

    // WuXing (五行) mapping for EarthBranch
    private static let WU_XING = ["水","土","木","木","土","火","火","土","金","金","土","水"]

    // NaYin (纳音) - 60 sounds combined with stems
    private static let NA_YIN_BRANCH = [
        "海中金", "海中金", "炉中火", "炉中火", "大林木", "大林木",
        "路傍土", "路傍土", "剑锋金", "剑锋金", "山下火", "山下火",
        "城头土", "城头土", "白腊金", "白腊金", "杨柳木", "杨柳木",
        "泉中水", "泉中水", "屋上瓦", "屋上瓦", "霹雳火", "霹雳火",
        "松柏木", "松柏木", "长流水", "长流水", "沙中金", "沙中金",
        "山头火", "山头火", "平地木", "平地木", "壁上土", "壁上土",
        "金箔金", "金箔金", "桑柘木", "桑柘木", "大溪水", "大溪水",
        "大驿土", "大驿土", "钗钏金", "钗钏金", "沙中土", "沙中土",
        "天河水", "天河水", "大林木", "大林木", "覆灯火", "覆灯火",
        "天上水", "天上水", "石榴木", "石榴木"
    ]

    public convenience init(index: Int) {
        self.init(names: EarthBranch.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: EarthBranch.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> EarthBranch {
        EarthBranch(index: index)
    }

    public static func fromName(_ name: String) throws -> EarthBranch {
        try EarthBranch(name: name)
    }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = EarthBranch.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> EarthBranch {
        EarthBranch.fromIndex(nextIndex(n))
    }

    /// The Chinese zodiac animal (生肖 Shēngxiào) for this branch.
    public var zodiac: String { EarthBranch.ZODIAC_NAMES[index] }
    public var yinYang: String { EarthBranch.YIN_YANG[index] }
    public var wuXing: String { EarthBranch.WU_XING[index] }

    public func getNaYin(_ stemIndex: Int = 0) -> String {
        let naYinIndex = (stemIndex * 12 + index) % 60
        return EarthBranch.NA_YIN_BRANCH[naYinIndex]
    }

    public func getFlourish() -> String {
        let flourishStages = ["长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎", "养"]
        return flourishStages[index]
    }

    public func getDecline() -> String {
        let declineStages = ["养", "长生", "沐浴", "冠带", "临官", "帝旺", "衰", "病", "死", "墓", "绝", "胎"]
        return declineStages[index]
    }

    @available(*, deprecated, renamed: "zodiac")
    public func getZodiac() -> String { zodiac }

    @available(*, deprecated, renamed: "yinYang")
    public func getYinYang() -> String { yinYang }

    @available(*, deprecated, renamed: "wuXing")
    public func getWuXing() -> String { wuXing }
}

/// Extension to EarthBranch for hidden stems
extension EarthBranch {
    /// Hidden stems data for each earth branch
    /// Format: [main, middle, residual] - nil means no stem for that position
    private static let HIDE_STEMS: [[Int?]] = [
        [9, nil, nil],      // 子: 癸
        [5, 9, 7],          // 丑: 己癸辛
        [0, 2, 4],          // 寅: 甲丙戊
        [1, nil, nil],      // 卯: 乙
        [4, 1, 9],          // 辰: 戊乙癸
        [2, 4, 6],          // 巳: 丙戊庚
        [3, 5, nil],        // 午: 丁己
        [5, 3, 1],          // 未: 己丁乙
        [6, 4, 8],          // 申: 庚戊壬
        [7, nil, nil],      // 酉: 辛
        [4, 7, 3],          // 戌: 戊辛丁
        [8, 0, nil]         // 亥: 壬甲
    ]

    /// Get hidden heaven stems
    /// The hidden Heavenly Stems (藏干 Cánggān) within this branch.
    public var hideHeavenStems: [HideHeavenStem] {
        var result: [HideHeavenStem] = []
        let stems = EarthBranch.HIDE_STEMS[index]
        if let mainIndex = stems[0] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(mainIndex), type: .main))
        }
        if let middleIndex = stems[1] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(middleIndex), type: .middle))
        }
        if let residualIndex = stems[2] {
            result.append(HideHeavenStem(heavenStem: HeavenStem.fromIndex(residualIndex), type: .residual))
        }
        return result
    }

    /// The main hidden stem (本气 Běnqì) of this branch.
    public var mainHideHeavenStem: HeavenStem? {
        if let mainIndex = EarthBranch.HIDE_STEMS[index][0] {
            return HeavenStem.fromIndex(mainIndex)
        }
        return nil
    }

    @available(*, deprecated, renamed: "hideHeavenStems")
    public func getHideHeavenStems() -> [HideHeavenStem] { hideHeavenStems }

    @available(*, deprecated, renamed: "mainHideHeavenStem")
    public func getMainHideHeavenStem() -> HeavenStem? { mainHideHeavenStem }
}
