import Foundation

public final class LunarMonth: MonthUnit, Tyme {
    public static let NAMES = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]

    public let leap: Bool

    public static func validate(year: Int, month: Int) throws {
        if month == 0 || month > 12 || month < -12 {
            throw TymeError.invalidMonth(month)
        }
        if month < 0, -month != (try LunarYear.fromYear(year)).leapMonth {
            throw TymeError.invalidMonth(month)
        }
    }

    public override init(year: Int, month: Int) throws {
        try LunarMonth.validate(year: year, month: month)
        self.leap = month < 0
        try super.init(year: year, month: abs(month))
    }

    public static func fromYm(_ year: Int, _ month: Int) throws -> LunarMonth {
        try LunarMonth(year: year, month: month)
    }

    public var lunarYear: LunarYear {
        guard let y = try? LunarYear.fromYear(year) else {
            preconditionFailure("LunarMonth: invalid year")
        }
        return y
    }
    public var monthWithLeap: Int { leap ? -month : month }
    public var indexInYear: Int {
        var index = month - 1
        if leap {
            index += 1
        } else {
            let lm = lunarYear.leapMonth
            if lm > 0 && month > lm { index += 1 }
        }
        return index
    }
    public var season: LunarSeason { LunarSeason.fromIndex(month - 1) }
    public var sixtyCycle: SixtyCycle {
        guard let sc = try? SixtyCycle.fromName(
            HeavenStem.fromIndex(lunarYear.sixtyCycle.heavenStem.index * 2 + month + 1).getName()
            + EarthBranch.fromIndex(month + 1).getName()
        ) else {
            preconditionFailure("LunarMonth: invalid sixty cycle calculation")
        }
        return sc
    }
    public var firstJulianDay: JulianDay {
        JulianDay.fromJulianDay(JulianDay.J2000 + ShouXingUtil.calcShuo(newMoon))
    }
    public var dayCount: Int {
        let w = newMoon
        return Int(ShouXingUtil.calcShuo(w + 29.5306) - ShouXingUtil.calcShuo(w))
    }
    public var days: [LunarDay] {
        let size = dayCount
        let m = monthWithLeap
        return (1...size).map { d in
            guard let day = try? LunarDay.fromYmd(year, m, d) else {
                preconditionFailure("LunarMonth: invalid day \(d)")
            }
            return day
        }
    }
    public var firstDay: LunarDay {
        guard let d = try? LunarDay.fromYmd(year, monthWithLeap, 1) else {
            preconditionFailure("LunarMonth: invalid first day")
        }
        return d
    }
    public var fetus: FetusMonth? { FetusMonth.fromLunarMonth(self) }

    /// 九星
    public var nineStar: NineStar {
        var index = sixtyCycle.earthBranch.index
        if index < 2 {
            index += 3
        }
        return NineStar.fromIndex(27 - lunarYear.sixtyCycle.earthBranch.index % 3 * 3 - index)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let sc = sixtyCycle
        let n = [7, -1, 1, 3][sc.earthBranch.next(-2).index % 4]
        return n != -1 ? Direction.fromIndex(n) : sc.heavenStem.direction
    }

    /// 小六壬
    public var minorRen: MinorRen {
        MinorRen.fromIndex((month - 1) % 6)
    }

    private var newMoon: Double {
        let dongZhiJd = SolarTerm.fromIndex(year, 0).cursoryJulianDay
        var w = ShouXingUtil.calcShuo(dongZhiJd)
        if w > dongZhiJd { w -= 29.53 }

        var offset = 2
        if year > 8 && year < 24 {
            offset = 1
        } else if year > -1, let prevYear = try? LunarYear.fromYear(year - 1), prevYear.leapMonth > 10 && year != 239 && year != 240 {
            offset = 3
        }
        return w + 29.5306 * Double(offset + indexInYear)
    }

    public func getWeekCount(_ start: Int) -> Int {
        let firstWeekIndex = indexOf(firstJulianDay.week.index - start, 7)
        return Int(ceil((Double(firstWeekIndex + dayCount)) / 7.0))
    }

    public func getName() -> String { (leap ? "闰" : "") + LunarMonth.NAMES[month - 1] }

    public func next(_ n: Int) -> LunarMonth {
        if n == 0 {
            guard let result = try? LunarMonth(year: year, month: monthWithLeap) else {
                preconditionFailure("LunarMonth: invalid self recreation")
            }
            return result
        }
        var m = indexInYear + 1 + n
        var y = lunarYear
        if n > 0 {
            var mc = y.monthCount
            while m > mc {
                m -= mc
                y = y.next(1)
                mc = y.monthCount
            }
        } else {
            while m <= 0 {
                y = y.next(-1)
                m += y.monthCount
            }
        }
        var isLeap = false
        let lm = y.leapMonth
        if lm > 0 {
            if m == lm + 1 { isLeap = true }
            if m > lm { m -= 1 }
        }
        guard let result = try? LunarMonth(year: y.year, month: isLeap ? -m : m) else {
            preconditionFailure("LunarMonth: invalid next calculation")
        }
        return result
    }

    public func getWeeks(_ start: Int) -> [LunarWeek] {
        let size = getWeekCount(start)
        let m = monthWithLeap
        return (0..<size).map { i in
            guard let w = try? LunarWeek.fromYm(year, m, i, start) else {
                preconditionFailure("LunarMonth: invalid week \(i)")
            }
            return w
        }
    }

    @available(*, deprecated, renamed: "lunarYear")
    public func getLunarYear() -> LunarYear { lunarYear }

    @available(*, deprecated, renamed: "monthWithLeap")
    public func getMonthWithLeap() -> Int { monthWithLeap }

    @available(*, deprecated, renamed: "indexInYear")
    public func getIndexInYear() -> Int { indexInYear }

    @available(*, deprecated, renamed: "season")
    public func getSeason() -> LunarSeason { season }

    @available(*, deprecated, renamed: "firstJulianDay")
    public func getFirstJulianDay() -> JulianDay { firstJulianDay }

    @available(*, deprecated, renamed: "dayCount")
    public func getDayCount() -> Int { dayCount }

    @available(*, deprecated, renamed: "days")
    public func getDays() -> [LunarDay] { days }

    @available(*, deprecated, renamed: "firstDay")
    public func getFirstDay() -> LunarDay { firstDay }

    @available(*, deprecated, renamed: "fetus")
    public func getFetus() -> FetusMonth? { fetus }

    @available(*, deprecated, renamed: "leap")
    public func isLeap() -> Bool { leap }
}
