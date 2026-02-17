import Foundation

public final class SolarTime: SecondUnit, Tyme {
    public override init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        try SolarUtil.validateYmd(year: year, month: month, day: day)
        try super.init(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> SolarTime {
        try SolarTime(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public func getName() -> String {
        String(format: "%04d-%02d-%02d %02d:%02d:%02d", try! getYear(), getMonth(), getDay(), getHour(), getMinute(), getSecond())
    }

    public func getJulianDay() -> JulianDay {
        try! JulianDay.fromYmdHms(year: getYear(), month: getMonth(), day: getDay(), hour: getHour(), minute: getMinute(), second: getSecond())
    }

    public func getSolarDay() -> SolarDay { try! SolarDay(year: getYear(), month: getMonth(), day: getDay()) }

    public func next(_ n: Int) -> SolarTime {
        let jd = getJulianDay()
        let target = JulianDay(jd.value + Double(n) / 86400.0)
        let ymd = target.toYmdHms()
        return try! SolarTime(year: ymd.year, month: ymd.month, day: ymd.day, hour: ymd.hour, minute: ymd.minute, second: ymd.second)
    }

    public func subtract(_ target: SolarTime) -> Int {
        let days = getSolarDay().subtract(target.getSolarDay())
        let cs = getHour() * 3600 + getMinute() * 60 + getSecond()
        let ts = target.getHour() * 3600 + target.getMinute() * 60 + target.getSecond()
        var seconds = cs - ts
        var d = days
        if seconds < 0 {
            seconds += 86400
            d -= 1
        }
        seconds += d * 86400
        return seconds
    }

    public func isAfter(_ target: SolarTime) -> Bool {
        let d = getSolarDay()
        let td = target.getSolarDay()
        if d.getYear() != td.getYear() || d.getMonth() != td.getMonth() || d.getDay() != td.getDay() {
            return d.isAfter(td)
        }
        if getHour() != target.getHour() { return getHour() > target.getHour() }
        return getMinute() != target.getMinute() ? getMinute() > target.getMinute() : getSecond() > target.getSecond()
    }

    public func isBefore(_ target: SolarTime) -> Bool {
        let d = getSolarDay()
        let td = target.getSolarDay()
        if d.getYear() != td.getYear() || d.getMonth() != td.getMonth() || d.getDay() != td.getDay() {
            return d.isBefore(td)
        }
        if getHour() != target.getHour() { return getHour() < target.getHour() }
        return getMinute() != target.getMinute() ? getMinute() < target.getMinute() : getSecond() < target.getSecond()
    }

    public func getLunarHour() -> LunarHour {
        let d = try! getSolarDay().getLunarDay()
        return try! LunarHour.fromYmdHms(d.getYear(), d.getMonth(), d.getDay(), getHour(), getMinute(), getSecond())
    }

    public func getTerm() -> SolarTerm {
        var term = try! getSolarDay().getTerm()
        if isBefore(term.getJulianDay().getSolarTime()) {
            term = term.next(-1)
        }
        return term
    }
}
