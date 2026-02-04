import Foundation

public final class SolarDay: DayUnit, Tyme {
    public override init(year: Int, month: Int, day: Int) {
        SolarUtil.validateYear(year)
        SolarUtil.validateYmd(year: year, month: month, day: day)
        super.init(year: year, month: month, day: day)
    }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> SolarDay {
        SolarDay(year: year, month: month, day: day)
    }

    public func getName() -> String {
        String(format: "%04d-%02d-%02d", getYear(), getMonth(), getDay())
    }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromYmdHms(year: getYear(), month: getMonth(), day: getDay())
    }

    public func getSolarMonth() -> SolarMonth { SolarMonth(year: getYear(), month: getMonth()) }
    public func getSolarYear() -> SolarYear { SolarYear(year: getYear()) }

    public func getWeek() -> Week { getJulianDay().getWeek() }

    public func next(_ n: Int) -> SolarDay {
        let jd = getJulianDay()
        let target = JulianDay(jd.value + Double(n))
        let ymd = target.toYmdHms()
        return SolarDay(year: ymd.year, month: ymd.month, day: ymd.day)
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
        let firstWeek = SolarDay(year: getYear(), month: getMonth(), day: 1).getWeek().next(-start).getIndex()
        let index = Int(ceil(Double(getDay() + firstWeek) / 7.0)) - 1
        return SolarWeek(year: getYear(), month: getMonth(), index: index, start: start)
    }

    public func getLunarDay() -> LunarDay {
        var m = LunarMonth.fromYm(getYear(), getMonth())
        var days = subtract(m.getFirstJulianDay().getSolarDay())
        while days < 0 {
            m = m.next(-1)
            days += m.getDayCount()
        }
        return LunarDay.fromYmd(m.getYear(), m.getMonthWithLeap(), days + 1)
    }
}
