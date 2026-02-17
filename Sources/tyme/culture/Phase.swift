import Foundation

/// 月相（月日黄经差）
///
/// 新月0，蛾眉月0-90，上弦月90，盈凸月90-180，满月180，亏凸月180-270，下弦月270，残月270-360
public final class Phase: LoopTyme {
    public static let NAMES = ["新月", "蛾眉月", "上弦月", "盈凸月", "满月", "亏凸月", "下弦月", "残月"]

    /// 农历年
    public private(set) var lunarYear: Int

    /// 农历月
    public private(set) var lunarMonth: Int

    public required init(names: [String], index: Int) {
        self.lunarYear = 2000
        self.lunarMonth = 1
        super.init(names: names, index: index)
    }

    public init(lunarYear: Int, lunarMonth: Int, index: Int) {
        let size = Phase.NAMES.count
        let m = try! LunarMonth.fromYm(lunarYear, lunarMonth).next(index / size)
        self.lunarYear = m.year
        self.lunarMonth = m.monthWithLeap
        super.init(names: Phase.NAMES, index: index)
    }

    public init(lunarYear: Int, lunarMonth: Int, name: String) throws {
        guard let idx = Phase.NAMES.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        self.lunarYear = lunarYear
        self.lunarMonth = lunarMonth
        super.init(names: Phase.NAMES, index: idx)
    }

    public static func fromIndex(_ lunarYear: Int, _ lunarMonth: Int, _ index: Int) -> Phase {
        Phase(lunarYear: lunarYear, lunarMonth: lunarMonth, index: index)
    }

    public static func fromName(_ lunarYear: Int, _ lunarMonth: Int, _ name: String) throws -> Phase {
        try Phase(lunarYear: lunarYear, lunarMonth: lunarMonth, name: name)
    }

    public override func next(_ n: Int) -> Phase {
        let size = getSize()
        var i = index + n
        if i < 0 {
            i -= size
        }
        i /= size
        let m = try! LunarMonth.fromYm(lunarYear, lunarMonth)
        let nextM = i != 0 ? m.next(i) : m
        return Phase.fromIndex(nextM.year, nextM.monthWithLeap, nextIndex(n))
    }

    private func getSize() -> Int {
        Phase.NAMES.count
    }

    private func getStartSolarTime() -> SolarTime {
        let n = Int(floor(Double(lunarYear - 2000) * 365.2422 / 29.53058886))
        var i = 0
        let jd = JulianDay.J2000 + ShouXingUtil.ONE_THIRD
        let d = try! LunarDay.fromYmd(lunarYear, lunarMonth, 1).solarDay
        while true {
            let t = ShouXingUtil.msaLonT(Double(n + i) * ShouXingUtil.PI_2) * 36525
            if !JulianDay.fromJulianDay(jd + t - ShouXingUtil.dtT(t)).solarDay.isBefore(d) {
                break
            }
            i += 1
        }
        let r = [0, 90, 180, 270]
        let t = ShouXingUtil.msaLonT((Double(n + i) + Double(r[index / 2]) / 360.0) * ShouXingUtil.PI_2) * 36525
        return JulianDay.fromJulianDay(jd + t - ShouXingUtil.dtT(t)).solarTime
    }

    /// 公历时刻
    public var solarTime: SolarTime {
        let t = getStartSolarTime()
        return index % 2 == 1 ? t.next(1) : t
    }

    /// 公历日
    public var solarDay: SolarDay {
        let d = getStartSolarTime().solarDay
        return index % 2 == 1 ? d.next(1) : d
    }

    @available(*, deprecated, renamed: "solarTime")
    public func getSolarTime() -> SolarTime { solarTime }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }
}
