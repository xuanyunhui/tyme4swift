import Foundation

public final class SolarDay: DayUnit, Tyme {
    public override init(year: Int, month: Int, day: Int) throws {
        try SolarUtil.validateYear(year)
        try SolarUtil.validateYmd(year: year, month: month, day: day)
        try super.init(year: year, month: month, day: day)
    }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> SolarDay {
        try SolarDay(year: year, month: month, day: day)
    }

    public func getName() -> String { String(format: "%04d-%02d-%02d", year, month, day) }

    public var julianDay: JulianDay { try! JulianDay.fromYmdHms(year: year, month: month, day: day) }
    public var solarMonth: SolarMonth { try! SolarMonth(year: year, month: month) }
    public var solarYear: SolarYear { try! SolarYear(year: year) }
    public var week: Week { julianDay.week }
    public var termDay: SolarTermDay {
        var y = year
        var i = month * 2
        if i == 24 {
            y += 1
            i = 0
        }
        var term = SolarTerm.fromIndex(y, i + 1)
        var td = term.solarDay
        while isBefore(td) {
            term = term.next(-1)
            td = term.solarDay
        }
        return SolarTermDay(term, subtract(td))
    }
    public var term: SolarTerm { termDay.solarTerm }
    public var sixtyCycleDay: SixtyCycleDay { SixtyCycleDay(solarDay: self) }
    public var lunarDay: LunarDay {
        var m = try! LunarMonth.fromYm(year, month)
        var days = subtract(m.firstJulianDay.solarDay)
        while days < 0 {
            m = m.next(-1)
            days += m.dayCount
        }
        while days >= m.dayCount {
            days -= m.dayCount
            m = m.next(1)
        }
        return try! LunarDay.fromYmd(m.year, m.monthWithLeap, days + 1)
    }

    public func next(_ n: Int) -> SolarDay {
        let jd = julianDay
        let target = JulianDay(jd.value + Double(n))
        let ymd = target.toYmdHms()
        return try! SolarDay(year: ymd.year, month: ymd.month, day: ymd.day)
    }

    public func isBefore(_ target: SolarDay) -> Bool {
        if year != target.year { return year < target.year }
        if month != target.month { return month < target.month }
        return day < target.day
    }

    public func isAfter(_ target: SolarDay) -> Bool {
        if year != target.year { return year > target.year }
        if month != target.month { return month > target.month }
        return day > target.day
    }

    public func subtract(_ target: SolarDay) -> Int {
        Int(julianDay.subtract(target.julianDay))
    }

    public func getSolarWeek(_ start: Int) -> SolarWeek {
        let firstWeek = try! SolarDay(year: year, month: month, day: 1).week.next(-start).index
        let i = Int(ceil(Double(day + firstWeek) / 7.0)) - 1
        return try! SolarWeek(year: year, month: month, index: i, start: start)
    }

    @available(*, deprecated, renamed: "julianDay")
    public func getJulianDay() -> JulianDay { julianDay }

    @available(*, deprecated, renamed: "solarMonth")
    public func getSolarMonth() -> SolarMonth { solarMonth }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear { solarYear }

    @available(*, deprecated, renamed: "week")
    public func getWeek() -> Week { week }

    @available(*, deprecated, renamed: "termDay")
    public func getTermDay() -> SolarTermDay { termDay }

    @available(*, deprecated, renamed: "term")
    public func getTerm() -> SolarTerm { term }

    @available(*, deprecated, renamed: "sixtyCycleDay")
    public func getSixtyCycleDay() -> SixtyCycleDay { sixtyCycleDay }

    @available(*, deprecated, renamed: "lunarDay")
    public func getLunarDay() -> LunarDay { lunarDay }
}
