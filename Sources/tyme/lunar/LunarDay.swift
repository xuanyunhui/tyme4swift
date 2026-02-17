import Foundation

public final class LunarDay: DayUnit, Tyme {
    public static let NAMES = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

    private let leap: Bool

    public static func validate(year: Int, month: Int, day: Int) throws {
        if day < 1 { throw TymeError.invalidDay(day) }
        let m = try! LunarMonth.fromYm(year, month)
        if day > m.getDayCount() { throw TymeError.invalidDay(day) }
    }

    public override init(year: Int, month: Int, day: Int) throws {
        try LunarDay.validate(year: year, month: month, day: day)
        self.leap = month < 0
        try super.init(year: year, month: abs(month), day: day)
    }

    public override func getMonth() -> Int { leap ? -super.getMonth() : super.getMonth() }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> LunarDay {
        try LunarDay(year: year, month: month, day: day)
    }

    public func getLunarMonth() -> LunarMonth { try! LunarMonth.fromYm(getYear(), try! getMonth()) }

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

    public func getWeek() -> Week { try! getSolarDay().getWeek() }

    public func getSixtyCycle() -> SixtyCycle {
        let offset = Int(getLunarMonth().getFirstJulianDay().next(getDay() - 12).getDay())
        let stem = HeavenStem.fromIndex(offset).getName()
        let branch = EarthBranch.fromIndex(offset).getName()
        return try! SixtyCycle.fromName(stem + branch)
    }

    public func getSolarDay() -> SolarDay {
        try! getLunarMonth().getFirstJulianDay().next(getDay() - 1).getSolarDay()
    }

    public func getFetusDay() -> FetusDay {
        FetusDay.fromLunarDay(self)
    }
}
