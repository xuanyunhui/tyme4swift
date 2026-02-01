import Foundation

public final class SolarDay: DayUnit, Tyme {
    public override init(year: Int, month: Int, day: Int) {
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

    public func next(_ n: Int) -> SolarDay {
        let jd = getJulianDay()
        let target = JulianDay(jd.value + Double(n))
        let ymd = target.toYmdHms()
        return SolarDay(year: ymd.year, month: ymd.month, day: ymd.day)
    }
}
