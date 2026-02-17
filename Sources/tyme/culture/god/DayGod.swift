import Foundation

/// 日神 (Day God)
/// Deities associated with the day
public final class DayGod: AbstractCulture {
    /// Auspicious day god names (吉神)
    public static let AUSPICIOUS_NAMES = [
        "天德", "月德", "天德合", "月德合", "天赦",
        "天愿", "月恩", "四相", "时德", "民日",
        "三合", "天喜", "天医", "普护", "福生",
        "圣心", "益后", "续世", "明堂", "青龙",
        "天贵", "金匮", "玉堂", "司命", "凤凰日",
        "天仓", "母仓", "月财", "六合", "五合",
        "五富", "要安", "玉宇", "金堂", "敬安",
        "阴德", "福德", "驿马", "天后", "天巫",
        "除神", "解神", "鸣吠", "鸣吠对"
    ]

    /// Inauspicious day god names (凶神)
    public static let INAUSPICIOUS_NAMES = [
        "月破", "大耗", "灾煞", "天火", "四废",
        "四忌", "四穷", "五墓", "复日", "重日",
        "朱雀", "白虎", "天刑", "天牢", "玄武",
        "勾陈", "元武", "阴错", "阳错", "四击",
        "大煞", "大会", "岁薄", "逐阵", "阴阳交破",
        "阴阳俱错", "阴道冲阳", "三丧", "五离",
        "八专", "往亡", "归忌", "血忌", "血支",
        "月厌", "厌对", "招摇", "九空", "九坎",
        "九焦", "大时", "大败", "咸池", "小耗",
        "五虚", "八风", "九良", "土府", "土符",
        "地囊", "荒芜", "月煞", "月虚", "月害",
        "天吏", "死神", "死气", "游祸", "五鬼",
        "天狗", "天贼", "天瘟", "土瘟", "飞廉",
        "蚩尤", "刀砧", "披麻", "孤辰", "寡宿"
    ]

    private let dayGodName: String
    private let isAuspicious: Bool

    /// Initialize with name and luck
    /// - Parameters:
    ///   - name: Day god name
    ///   - isAuspicious: Whether auspicious
    public init(name: String, isAuspicious: Bool) {
        self.dayGodName = name
        self.isAuspicious = isAuspicious
        super.init()
    }

    /// Get name
    /// - Returns: Day god name
    public override func getName() -> String {
        return dayGodName
    }

    public var auspicious: Bool { isAuspicious }
    public var inauspicious: Bool { !isAuspicious }
    public var luck: Luck { Luck.fromIndex(isAuspicious ? 0 : 1) }

    @available(*, deprecated, renamed: "auspicious")
    public func getIsAuspicious() -> Bool { auspicious }

    @available(*, deprecated, renamed: "inauspicious")
    public func getIsInauspicious() -> Bool { inauspicious }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> Luck { luck }

    /// Create auspicious day god
    /// - Parameter name: Day god name
    /// - Returns: DayGod instance
    public static func auspicious(_ name: String) -> DayGod {
        return DayGod(name: name, isAuspicious: true)
    }

    /// Create inauspicious day god
    /// - Parameter name: Day god name
    /// - Returns: DayGod instance
    public static func inauspicious(_ name: String) -> DayGod {
        return DayGod(name: name, isAuspicious: false)
    }
}
