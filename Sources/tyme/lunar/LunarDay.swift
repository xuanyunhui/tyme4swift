import Foundation

public final class LunarDay: DayUnit, Tyme {
    public static let NAMES = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

    public let leap: Bool

    public static func validate(year: Int, month: Int, day: Int) throws {
        if day < 1 { throw TymeError.invalidDay(day) }
        let m = try! LunarMonth.fromYm(year, month)
        if day > m.dayCount { throw TymeError.invalidDay(day) }
    }

    public override init(year: Int, month: Int, day: Int) throws {
        try LunarDay.validate(year: year, month: month, day: day)
        self.leap = month < 0
        try super.init(year: year, month: abs(month), day: day)
    }

    /// Returns signed month (negative if leap month)
    public var monthWithLeap: Int { leap ? -month : month }

    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> LunarDay {
        try LunarDay(year: year, month: month, day: day)
    }

    public var lunarMonth: LunarMonth { try! LunarMonth.fromYm(year, monthWithLeap) }

    public func getName() -> String { LunarDay.NAMES[day - 1] }

    public func next(_ n: Int) -> LunarDay { solarDay.next(n).lunarDay }

    public func isBefore(_ target: LunarDay) -> Bool {
        if year != target.year { return year < target.year }
        if monthWithLeap != target.monthWithLeap { return abs(monthWithLeap) < abs(target.monthWithLeap) }
        return day < target.day
    }

    public func isAfter(_ target: LunarDay) -> Bool {
        if year != target.year { return year > target.year }
        if monthWithLeap != target.monthWithLeap { return abs(monthWithLeap) >= abs(target.monthWithLeap) }
        return day > target.day
    }

    public var week: Week { solarDay.week }
    public var sixtyCycle: SixtyCycle {
        let offset = Int(lunarMonth.firstJulianDay.next(day - 12).value)
        let stem = HeavenStem.fromIndex(offset).getName()
        let branch = EarthBranch.fromIndex(offset).getName()
        return try! SixtyCycle.fromName(stem + branch)
    }
    public var solarDay: SolarDay {
        lunarMonth.firstJulianDay.next(day - 1).solarDay
    }
    public var fetusDay: FetusDay { FetusDay.fromLunarDay(self) }

    /// Deprecated override — use `monthWithLeap` instead
    @available(*, deprecated, renamed: "monthWithLeap")
    public override func getMonth() -> Int { monthWithLeap }

    @available(*, deprecated, renamed: "lunarMonth")
    public func getLunarMonth() -> LunarMonth { lunarMonth }

    @available(*, deprecated, renamed: "week")
    public func getWeek() -> Week { week }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }

    @available(*, deprecated, renamed: "fetusDay")
    public func getFetusDay() -> FetusDay { fetusDay }
}

extension LunarDay: Codable {
    private enum CodingKeys: String, CodingKey {
        case year, month, day
    }

    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let year = try container.decode(Int.self, forKey: .year)
        let month = try container.decode(Int.self, forKey: .month)
        let day = try container.decode(Int.self, forKey: .day)
        try self.init(year: year, month: month, day: day)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(year, forKey: .year)
        try container.encode(monthWithLeap, forKey: .month)
        try container.encode(day, forKey: .day)
    }
}
