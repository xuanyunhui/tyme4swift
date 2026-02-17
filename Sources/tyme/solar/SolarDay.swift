import Foundation

public final class SolarDay: DayUnit, Tyme {
    public override init(year: Int, month: Int, day: Int) throws {
        try SolarUtil.validateYear(year)
        try SolarUtil.validateYmd(year: year, month: month, day: day)
        try super.init(year: year, month: month, day: day)
    }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int)  throws -> SolarDay {
        try SolarDay(year: year, month: month, day: day)
    }

    public func getName() -> String {
        String(format: "%04d-%02d-%02d", try! getYear(), getMonth(), getDay())
    }

    public func getJulianDay() -> JulianDay {
        try! JulianDay.fromYmdHms(year: try! getYear(), month: getMonth(), day: getDay())
    }

    public func getSolarMonth() -> SolarMonth { try! SolarMonth(year: getYear(), month: getMonth()) }
    public func getSolarYear() -> SolarYear { try! SolarYear(year: getYear()) }

    public func getWeek() -> Week { try! getJulianDay().getWeek() }

    public func next(_ n: Int) -> SolarDay {
        let jd = getJulianDay()
        let target = JulianDay(jd.value + Double(n))
        let ymd = target.toYmdHms()
        return try! SolarDay(year: ymd.year, month: ymd.month, day: ymd.day)
    }

    public func isBefore(_ target: SolarDay) -> Bool {
        if getYear() != target.getYear() { return getYear() < target.getYear() }
        if getMonth() != target.getMonth() { return getMonth() < target.getMonth() }
        return getDay() < target.getDay()
    }

    public func isAfter(_ target: SolarDay) -> Bool {
        if getYear() != target.getYear() { return getYear() > target.getYear() }
        if getMonth() != target.getMonth() { return getMonth() > target.getMonth() }
        return getDay() > target.getDay()
    }

    public func subtract(_ target: SolarDay) -> Int {
        Int(getJulianDay().subtract(target.getJulianDay()))
    }

    public func getSolarWeek(_ start: Int) -> SolarWeek {
        let firstWeek = try! SolarDay(year: getYear(), month: getMonth(), day: 1).getWeek().next(-start).getIndex()
        let index = Int(ceil(Double(getDay() + firstWeek) / 7.0)) - 1
        return try! SolarWeek(year: getYear(), month: getMonth(), index: index, start: start)
    }

    public func getTermDay() -> SolarTermDay {
        var y = try! getYear()
        var i = getMonth() * 2
        if i == 24 {
            y += 1
            i = 0
        }
        var term = SolarTerm.fromIndex(y, i + 1)
        var termDay = term.getSolarDay()
        while isBefore(termDay) {
            term = term.next(-1)
            termDay = term.getSolarDay()
        }
        return SolarTermDay(term, subtract(termDay))
    }

    public func getTerm() -> SolarTerm {
        try! getTermDay().getSolarTerm()
    }

    public func getSixtyCycleDay() -> SixtyCycleDay {
        try! SixtyCycleDay(solarDay: self)
    }

    public func getLunarDay() -> LunarDay {
        var m = try! LunarMonth.fromYm(getYear(), try! getMonth())
        var days = subtract(m.getFirstJulianDay().getSolarDay())
        while days < 0 {
            m = m.next(-1)
            days += m.getDayCount()
        }
        while days >= m.getDayCount() {
            days -= m.getDayCount()
            m = m.next(1)
        }
        return try! LunarDay.fromYmd(m.getYear(), m.getMonthWithLeap(), days + 1)
    }
}
