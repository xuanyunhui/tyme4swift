import Foundation

public final class LunarHour: SecondUnit, Tyme {
    public static func validate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        try SecondUnit.validate(hour: hour, minute: minute, second: second)
        try LunarDay.validate(year: year, month: month, day: day)
    }

    public override init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        try! LunarHour.validate(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        try super.init(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> LunarHour {
        try LunarHour(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    public var lunarDay: LunarDay { try! LunarDay.fromYmd(year, month, day) }
    public var indexInDay: Int { (hour + 1) / 2 }

    public func getName() -> String { EarthBranch.fromIndex(indexInDay).getName() + "时" }

    public var sixtyCycle: SixtyCycle {
        let earthBranchIndex = indexInDay % 12
        var d = lunarDay.sixtyCycle
        if hour >= 23 { d = d.next(1) }
        let stemIndex = d.getHeavenStem().index % 5 * 2 + earthBranchIndex
        let stem = HeavenStem.fromIndex(stemIndex).getName()
        let branch = EarthBranch.fromIndex(earthBranchIndex).getName()
        return try! SixtyCycle.fromName(stem + branch)
    }

    public var solarTime: SolarTime {
        let d = lunarDay.solarDay
        return try! SolarTime.fromYmdHms(d.year, d.month, d.day, hour, minute, second)
    }

    /// 八字
    public var eightChar: EightChar {
        let st = solarTime
        let provider = DefaultEightCharProvider()
        return EightChar(
            year: provider.getYearSixtyCycle(year: st.year, month: st.month, day: st.day),
            month: provider.getMonthSixtyCycle(year: st.year, month: st.month, day: st.day),
            day: provider.getDaySixtyCycle(year: st.year, month: st.month, day: st.day),
            hour: provider.getHourSixtyCycle(year: st.year, month: st.month, day: st.day, hour: st.hour)
        )
    }

    public func next(_ n: Int) -> LunarHour {
        if n == 0 { return try! LunarHour.fromYmdHms(year, month, day, hour, minute, second) }
        let h = hour + n * 2
        let diff = h < 0 ? -1 : 1
        var newHour = abs(h)
        var days = newHour / 24 * diff
        newHour = (newHour % 24) * diff
        if newHour < 0 {
            newHour += 24
            days -= 1
        }
        let d = lunarDay.next(days)
        return try! LunarHour.fromYmdHms(d.year, d.monthWithLeap, d.day, newHour, minute, second)
    }

    public func isBefore(_ target: LunarHour) -> Bool {
        let d = lunarDay
        let td = target.lunarDay
        if d.year != td.year || d.monthWithLeap != td.monthWithLeap || d.day != td.day {
            return d.isBefore(td)
        }
        if hour != target.hour { return hour < target.hour }
        if minute != target.minute { return minute < target.minute }
        return second < target.second
    }

    public func isAfter(_ target: LunarHour) -> Bool {
        let d = lunarDay
        let td = target.lunarDay
        if d.year != td.year || d.monthWithLeap != td.monthWithLeap || d.day != td.day {
            return d.isAfter(td)
        }
        if hour != target.hour { return hour > target.hour }
        if minute != target.minute { return minute > target.minute }
        return second > target.second
    }

    @available(*, deprecated, renamed: "lunarDay")
    public func getLunarDay() -> LunarDay { lunarDay }

    @available(*, deprecated, renamed: "indexInDay")
    public func getIndexInDay() -> Int { indexInDay }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "solarTime")
    public func getSolarTime() -> SolarTime { solarTime }
}
