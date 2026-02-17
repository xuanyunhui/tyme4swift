import Foundation

public final class HeavenStem: LoopTyme {
    public static let NAMES = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]

    // YinYang mapping for HeavenStem (阴阳)
    private static let YIN_YANG = ["阳","阴","阳","阴","阳","阴","阳","阴","阳","阴"]

    // WuXing (五行) mapping for HeavenStem
    private static let WU_XING = ["木","木","火","火","土","土","金","金","水","水"]

    // NaYin (纳音) - 60 sounds mapping
    private static let NA_YIN = [
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
        self.init(names: HeavenStem.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: HeavenStem.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> HeavenStem {
        HeavenStem(index: index)
    }

    public static func fromName(_ name: String) throws -> HeavenStem {
        try HeavenStem(name: name)
    }

    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = HeavenStem.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    public override func next(_ n: Int) -> HeavenStem {
        HeavenStem.fromIndex(nextIndex(n))
    }

    public var yinYang: String { HeavenStem.YIN_YANG[index] }
    public var wuXing: String { HeavenStem.WU_XING[index] }

    public func getNaYin(_ branchIndex: Int = 0) -> String {
        let naYinIndex = (index + branchIndex) % 60
        return HeavenStem.NA_YIN[naYinIndex]
    }

    public func getFlourish() -> String {
        let flourishStages = ["生", "生", "生", "生", "生", "生", "生", "生", "生", "生"]
        return flourishStages[index]
    }

    public func getDecline() -> String {
        let declineStages = ["沐", "沐", "沐", "沐", "沐", "沐", "沐", "沐", "沐", "沐"]
        return declineStages[index]
    }

    @available(*, deprecated, renamed: "yinYang")
    public func getYinYang() -> String { yinYang }

    @available(*, deprecated, renamed: "wuXing")
    public func getWuXing() -> String { wuXing }
}
