import Foundation

public final class LunarDay: DayUnit, Tyme {
    public static let NAMES = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

    public static func validate(year: Int, month: Int, day: Int) {
        if day < 1 { fatalError("illegal lunar day \(day)") }
        let m = LunarMonth.fromYm(year, month)
        if day > m.getDayCount() { fatalError("illegal day \(day) in \(m)") }
    }

    public override init(year: Int, month: Int, day: Int) {
        LunarDay.validate(year: year, month: month, day: day)
        super.init(year: year, month: month, day: day)
    }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> LunarDay {
        LunarDay(year: year, month: month, day: day)
    }

    public func getLunarMonth() -> LunarMonth { LunarMonth.fromYm(getYear(), getMonth()) }

    public func getName() -> String { LunarDay.NAMES[getDay() - 1] }

    public func next(_ n: Int) -> LunarDay {
        getSolarDay().next(n).getLunarDay()
    }

    public func isBefore(_ target: LunarDay) -> Bool {
        if getYear() != target.getYear() { return getYear() < target.getYear() }
        if getMonth() != target.getMonth() { return abs(getMonth()) < abs(target.getMonth()) }
        return getDay() < target.getDay()
    }

    public func isAfter(_ target: LunarDay) -> Bool {
        if getYear() != target.getYear() { return getYear() > target.getYear() }
        if getMonth() != target.getMonth() { return abs(getMonth()) >= abs(target.getMonth()) }
        return getDay() > target.getDay()
    }

    public func getWeek() -> Week { getSolarDay().getWeek() }

    public func getSixtyCycle() -> SixtyCycle {
        let offset = Int(getLunarMonth().getFirstJulianDay().next(getDay() - 12).getDay())
        let stem = HeavenStem.fromIndex(offset).getName()
        let branch = EarthBranch.fromIndex(offset).getName()
        return SixtyCycle.fromName(stem + branch)
    }

    public func getSolarDay() -> SolarDay {
        getLunarMonth().getFirstJulianDay().next(getDay() - 1).getSolarDay()
    }
}
