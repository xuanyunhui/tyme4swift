import Foundation

public final class LunarMonth: MonthUnit, Tyme {
    public static let NAMES = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]

    private let leap: Bool

    public static func validate(year: Int, month: Int) {
        if month == 0 || month > 12 || month < -12 {
            fatalError("illegal lunar month: \(month)")
        }
        if month < 0 && -month != LunarYear.fromYear(year).getLeapMonth() {
            fatalError("illegal leap month \( -month ) in lunar year \(year)")
        }
    }

    public override init(year: Int, month: Int) {
        LunarMonth.validate(year: year, month: month)
        self.leap = month < 0
        super.init(year: year, month: abs(month))
    }

    public static func fromYm(_ year: Int, _ month: Int) -> LunarMonth {
        LunarMonth(year: year, month: month)
    }

    public func getLunarYear() -> LunarYear { LunarYear.fromYear(getYear()) }

    public func getMonthWithLeap() -> Int { leap ? -getMonth() : getMonth() }

    private func getNewMoon() -> Double {
        let dongZhiJd = SolarTerm.fromIndex(getYear(), 0).getCursoryJulianDay()
        var w = ShouXingUtil.calcShuo(dongZhiJd)
        if w > dongZhiJd { w -= 29.53 }

        var offset = 2
        if getYear() > 8 && getYear() < 24 {
            offset = 1
        } else if LunarYear.fromYear(getYear() - 1).getLeapMonth() > 10 && getYear() != 239 && getYear() != 240 {
            offset = 3
        }
        return w + 29.5306 * Double(offset + getIndexInYear())
    }

    public func getDayCount() -> Int {
        let w = getNewMoon()
        return Int(ShouXingUtil.calcShuo(w + 29.5306) - ShouXingUtil.calcShuo(w))
    }

    public func getIndexInYear() -> Int {
        var index = getMonth() - 1
        if leap {
            index += 1
        } else {
            let leapMonth = LunarYear.fromYear(getYear()).getLeapMonth()
            if leapMonth > 0 && getMonth() > leapMonth { index += 1 }
        }
        return index
    }

    public func getSeason() -> LunarSeason {
        LunarSeason.fromIndex(getMonth() - 1)
    }

    public func getFirstJulianDay() -> JulianDay {
        JulianDay.fromJulianDay(JulianDay.J2000 + ShouXingUtil.calcShuo(getNewMoon()))
    }

    public func isLeap() -> Bool { leap }

    public func getWeekCount(_ start: Int) -> Int {
        let firstWeekIndex = indexOf(getFirstJulianDay().getWeek().getIndex() - start, 7)
        return Int(ceil((Double(firstWeekIndex + getDayCount())) / 7.0))
    }

    public func getName() -> String {
        (leap ? "闰" : "") + LunarMonth.NAMES[getMonth() - 1]
    }

    public func next(_ n: Int) -> LunarMonth {
        if n == 0 { return LunarMonth(year: getYear(), month: getMonthWithLeap()) }
        var m = getIndexInYear() + 1 + n
        var y = getLunarYear()
        if n > 0 {
            var monthCount = y.getMonthCount()
            while m > monthCount {
                m -= monthCount
                y = y.next(1)
                monthCount = y.getMonthCount()
            }
        } else {
            while m <= 0 {
                y = y.next(-1)
                m += y.getMonthCount()
            }
        }
        var isLeap = false
        let leapMonth = y.getLeapMonth()
        if leapMonth > 0 {
            if m == leapMonth + 1 { isLeap = true }
            if m > leapMonth { m -= 1 }
        }
        return LunarMonth(year: y.getYear(), month: isLeap ? -m : m)
    }

    public func getDays() -> [LunarDay] {
        let size = getDayCount()
        let m = getMonthWithLeap()
        return (1...size).map { LunarDay.fromYmd(getYear(), m, $0) }
    }

    public func getFirstDay() -> LunarDay {
        LunarDay.fromYmd(getYear(), getMonthWithLeap(), 1)
    }

    public func getWeeks(_ start: Int) -> [LunarWeek] {
        let size = getWeekCount(start)
        let m = getMonthWithLeap()
        return (0..<size).map { LunarWeek.fromYm(getYear(), m, $0, start) }
    }

    public func getFetus() -> FetusMonth? {
        FetusMonth.fromLunarMonth(self)
    }
}
