import Foundation

/// A day in the Chinese lunar calendar (农历 Nónglì).
///
/// `LunarDay` represents a specific date in the traditional Chinese lunisolar calendar.
/// Lunar months can be regular or leap (闰月 Rùnyuè), indicated by a negative month value.
///
/// ## Usage
///
/// ```swift
/// let day = try LunarDay(year: 2024, month: 1, day: 15)   // Regular month
/// let leap = try LunarDay(year: 2023, month: -2, day: 15)  // Leap month 2
/// let solarDay = day.solarDay                               // Convert to solar
/// ```
public final class LunarDay: DayUnit, Tyme {
    public static let NAMES = [
        "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
        "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
        "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"
    ]

    /// Whether this day falls in a leap month (闰月 Rùnyuè).
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

    /// The month number, negative if leap month. E.g., -4 means leap month 4.
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
    /// The sexagenary cycle for this lunar day (日干支 Rì Gānzhī).
    public var sixtyCycle: SixtyCycle {
        let offset = Int(lunarMonth.firstJulianDay.next(day - 12).value)
        let stem = HeavenStem.fromIndex(offset).getName()
        let branch = EarthBranch.fromIndex(offset).getName()
        return try! SixtyCycle.fromName(stem + branch)
    }
    /// The corresponding Gregorian calendar date.
    public var solarDay: SolarDay {
        lunarMonth.firstJulianDay.next(day - 1).solarDay
    }
    public var fetusDay: FetusDay { FetusDay.fromLunarDay(self) }

    /// 干支日
    public var sixtyCycleDay: SixtyCycleDay { solarDay.sixtyCycleDay }

    /// 九星
    public var nineStar: NineStar { sixtyCycleDay.nineStar }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let idx = sixtyCycle.index
        return idx % 12 < 6 ? Element.fromIndex(idx / 12).direction : (try! LunarYear.fromYear(year)).jupiterDirection
    }

    /// 月相第几天
    public var phaseDay: PhaseDay {
        let today = solarDay
        let m = lunarMonth.next(1)
        var p = Phase.fromIndex(m.year, m.monthWithLeap, 0)
        var d = p.solarDay
        while d.isAfter(today) {
            p = p.next(-1)
            d = p.solarDay
        }
        return PhaseDay(phase: p, dayIndex: today.subtract(d))
    }

    /// 月相
    public var phase: Phase { phaseDay.phase }

    /// 六曜
    public var sixStar: SixStar {
        SixStar.fromIndex((abs(monthWithLeap) + day - 2) % 6)
    }

    /// 建除十二值神
    public var duty: Duty { sixtyCycleDay.duty }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar { sixtyCycleDay.twelveStar }

    /// 二十八宿
    public var twentyEightStar: TwentyEightStar {
        TwentyEightStar.fromIndex([10, 18, 26, 6, 14, 22, 2][solarDay.week.index]).next(-7 * sixtyCycle.earthBranch.index)
    }

    /// 农历传统节日，如果当天不是农历传统节日，返回nil
    public var festival: LunarFestival? {
        LunarFestival.fromYmd(year, monthWithLeap, day)
    }

    /// 当天的农历时辰列表
    public var hours: [LunarHour] {
        let m = monthWithLeap
        var l: [LunarHour] = []
        l.append(try! LunarHour.fromYmdHms(year, m, day, 0, 0, 0))
        for i in stride(from: 0, to: 24, by: 2) {
            l.append(try! LunarHour.fromYmdHms(year, m, day, i + 1, 0, 0))
        }
        return l
    }

    /// 神煞列表
    public var gods: [God] { sixtyCycleDay.gods }

    /// 宜
    public var recommends: [Taboo] { sixtyCycleDay.recommends }

    /// 忌
    public var avoids: [Taboo] { sixtyCycleDay.avoids }

    /// 小六壬
    public var minorRen: MinorRen { lunarMonth.minorRen.next(day - 1) }

    /// 三柱
    public var threePillars: ThreePillars { sixtyCycleDay.threePillars }

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
