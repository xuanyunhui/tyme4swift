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
        String(format: "%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second)
    }

    public var julianDay: JulianDay {
        try! JulianDay.fromYmdHms(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public var solarDay: SolarDay { try! SolarDay(year: year, month: month, day: day) }

    public var lunarHour: LunarHour {
        let d = solarDay.lunarDay
        return try! LunarHour.fromYmdHms(d.year, d.monthWithLeap, d.day, hour, minute, second)
    }

    public var term: SolarTerm {
        var t = solarDay.term
        if isBefore(t.julianDay.solarTime) {
            t = t.next(-1)
        }
        return t
    }

    public func next(_ n: Int) -> SolarTime {
        let jd = julianDay
        let target = JulianDay(jd.value + Double(n) / 86400.0)
        let ymd = target.toYmdHms()
        return try! SolarTime(year: ymd.year, month: ymd.month, day: ymd.day, hour: ymd.hour, minute: ymd.minute, second: ymd.second)
    }

    public func subtract(_ target: SolarTime) -> Int {
        let days = solarDay.subtract(target.solarDay)
        let cs = hour * 3600 + minute * 60 + second
        let ts = target.hour * 3600 + target.minute * 60 + target.second
        var secs = cs - ts
        var d = days
        if secs < 0 {
            secs += 86400
            d -= 1
        }
        secs += d * 86400
        return secs
    }

    public func isAfter(_ target: SolarTime) -> Bool {
        let d = solarDay
        let td = target.solarDay
        if d.year != td.year || d.month != td.month || d.day != td.day {
            return d.isAfter(td)
        }
        if hour != target.hour { return hour > target.hour }
        return minute != target.minute ? minute > target.minute : second > target.second
    }

    public func isBefore(_ target: SolarTime) -> Bool {
        let d = solarDay
        let td = target.solarDay
        if d.year != td.year || d.month != td.month || d.day != td.day {
            return d.isBefore(td)
        }
        if hour != target.hour { return hour < target.hour }
        return minute != target.minute ? minute < target.minute : second < target.second
    }

    /// 干支时辰
    public var sixtyCycleHour: SixtyCycleHour {
        SixtyCycleHour.fromSolarTime(self)
    }

    /// 月相
    public var phase: Phase {
        let m = lunarHour.lunarDay.lunarMonth.next(1)
        var p = Phase.fromIndex(m.year, m.monthWithLeap, 0)
        var guardCount = 0
        while p.solarTime.isAfter(self) {
            guardCount += 1
            if guardCount > 50 { break } // Phase cycle < 30 days; 50 steps is impossible
            p = p.next(-1)
        }
        return p
    }

    @available(*, deprecated, renamed: "julianDay")
    public func getJulianDay() -> JulianDay { julianDay }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }

    @available(*, deprecated, renamed: "lunarHour")
    public func getLunarHour() -> LunarHour { lunarHour }

    @available(*, deprecated, renamed: "term")
    public func getTerm() -> SolarTerm { term }

    @available(*, deprecated, renamed: "sixtyCycleHour")
    public func getSixtyCycleHour() -> SixtyCycleHour { sixtyCycleHour }

    @available(*, deprecated, renamed: "phase")
    public func getPhase() -> Phase { phase }
}

extension SolarTime: Codable {
    private enum CodingKeys: String, CodingKey {
        case year, month, day, hour, minute, second
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            year: container.decode(Int.self, forKey: .year),
            month: container.decode(Int.self, forKey: .month),
            day: container.decode(Int.self, forKey: .day),
            hour: container.decode(Int.self, forKey: .hour),
            minute: container.decode(Int.self, forKey: .minute),
            second: container.decode(Int.self, forKey: .second)
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(year, forKey: .year)
        try container.encode(month, forKey: .month)
        try container.encode(day, forKey: .day)
        try container.encode(hour, forKey: .hour)
        try container.encode(minute, forKey: .minute)
        try container.encode(second, forKey: .second)
    }
}
