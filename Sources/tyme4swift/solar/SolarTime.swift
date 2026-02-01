import Foundation

public final class SolarTime: SecondUnit, Tyme {
    public override init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        SolarUtil.validateYmd(year: year, month: month, day: day)
        super.init(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) -> SolarTime {
        SolarTime(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public func getName() -> String {
        String(format: "%04d-%02d-%02d %02d:%02d:%02d", getYear(), getMonth(), getDay(), getHour(), getMinute(), getSecond())
    }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromYmdHms(year: getYear(), month: getMonth(), day: getDay(), hour: getHour(), minute: getMinute(), second: getSecond())
    }

    public func getSolarDay() -> SolarDay { SolarDay(year: getYear(), month: getMonth(), day: getDay()) }

    public func next(_ n: Int) -> SolarTime {
        let jd = getJulianDay()
        let target = JulianDay(jd.value + Double(n) / 86400.0)
        let ymd = target.toYmdHms()
        return SolarTime(year: ymd.year, month: ymd.month, day: ymd.day, hour: ymd.hour, minute: ymd.minute, second: ymd.second)
    }
}
