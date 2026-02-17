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

    public func getLunarDay() -> LunarDay { try! LunarDay.fromYmd(getYear(), try! getMonth(), getDay()) }

    public func getName() -> String { EarthBranch.fromIndex(getIndexInDay()).getName() + "时" }

    public func getIndexInDay() -> Int { (getHour() + 1) / 2 }

    public func next(_ n: Int) -> LunarHour {
        if n == 0 { return try! LunarHour.fromYmdHms(getYear(), getMonth(), getDay(), getHour(), getMinute(), getSecond()) }
        var h = getHour() + n * 2
        let diff = h < 0 ? -1 : 1
        var hour = abs(h)
        var days = hour / 24 * diff
        hour = (hour % 24) * diff
        if hour < 0 {
            hour += 24
            days -= 1
        }
        let d = getLunarDay().next(days)
        return try! LunarHour.fromYmdHms(d.getYear(), d.getMonth(), d.getDay(), hour, getMinute(), getSecond())
    }

    public func isBefore(_ target: LunarHour) -> Bool {
        let d = getLunarDay()
        let td = target.getLunarDay()
        if d.getYear() != td.getYear() || d.getMonth() != td.getMonth() || d.getDay() != td.getDay() {
            return d.isBefore(td)
        }
        if getHour() != target.getHour() { return getHour() < target.getHour() }
        if getMinute() != target.getMinute() { return getMinute() < target.getMinute() }
        return getSecond() < target.getSecond()
    }

    public func isAfter(_ target: LunarHour) -> Bool {
        let d = getLunarDay()
        let td = target.getLunarDay()
        if d.getYear() != td.getYear() || d.getMonth() != td.getMonth() || d.getDay() != td.getDay() {
            return d.isAfter(td)
        }
        if getHour() != target.getHour() { return getHour() > target.getHour() }
        if getMinute() != target.getMinute() { return getMinute() > target.getMinute() }
        return getSecond() > target.getSecond()
    }

    public func getSixtyCycle() -> SixtyCycle {
        let earthBranchIndex = try! getIndexInDay() % 12
        var d = getLunarDay().getSixtyCycle()
        if getHour() >= 23 { d = d.next(1) }
        let stemIndex = d.getHeavenStem().getIndex() % 5 * 2 + earthBranchIndex
        let stem = HeavenStem.fromIndex(stemIndex).getName()
        let branch = EarthBranch.fromIndex(earthBranchIndex).getName()
        return try! SixtyCycle.fromName(stem + branch)
    }

    public func getSolarTime() -> SolarTime {
        let d = try! getLunarDay().getSolarDay()
        return try! SolarTime.fromYmdHms(d.getYear(), d.getMonth(), d.getDay(), getHour(), getMinute(), getSecond())
    }
}
