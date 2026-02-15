import Foundation

/// 逐月胎神（正十二月在床房，二三九十门户中，四六十一灶勿犯，五甲七子八厕凶。）
public final class FetusMonth: LoopTyme {
    public static let NAMES = ["占房床", "占户窗", "占门堂", "占厨灶", "占房床", "占床仓", "占碓磨", "占厕户", "占门房", "占房床", "占灶炉", "占房床"]

    public convenience init(index: Int) {
        self.init(names: FetusMonth.NAMES, index: index)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromLunarMonth(_ lunarMonth: LunarMonth) -> FetusMonth? {
        if lunarMonth.isLeap() {
            return nil
        }
        return FetusMonth(index: lunarMonth.getMonth() - 1)
    }

    public override func next(_ n: Int) -> FetusMonth {
        FetusMonth(index: nextIndex(n))
    }
}
