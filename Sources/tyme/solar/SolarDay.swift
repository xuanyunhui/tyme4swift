import Foundation

/// A day in the Gregorian (solar) calendar.
///
/// `SolarDay` represents a specific date in the solar calendar system,
/// providing conversions to the lunar calendar, sexagenary cycle, and solar terms.
///
/// ## Usage
///
/// ```swift
/// let day = try SolarDay.fromYmd(2024, 1, 15)
/// let lunarDay = day.lunarDay        // Convert to lunar calendar
/// let cycle = day.sixtyCycleDay      // Get sexagenary cycle day
/// let term = day.term                // Get solar term
/// ```
///
/// ## Topics
///
/// ### Creating a Solar Day
/// - ``fromYmd(_:_:_:)``
/// - ``init(year:month:day:)``
///
/// ### Calendar Conversions
/// - ``lunarDay``
/// - ``julianDay``
/// - ``sixtyCycleDay``
///
/// ### Solar Terms
/// - ``term``
/// - ``termDay``
public final class SolarDay: DayUnit, Tyme {
    public override init(year: Int, month: Int, day: Int) throws {
        try SolarUtil.validateYear(year)
        try SolarUtil.validateYmd(year: year, month: month, day: day)
        try super.init(year: year, month: month, day: day)
    }

    /// Creates a solar day from year, month, and day components.
    /// - Throws: `TymeError` if the date is invalid.
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> SolarDay {
        try SolarDay(year: year, month: month, day: day)
    }

    public func getName() -> String { String(format: "%04d-%02d-%02d", year, month, day) }

    /// The Julian Day number for astronomical calculations.
    public var julianDay: JulianDay { try! JulianDay.fromYmdHms(year: year, month: month, day: day) }
    public var solarMonth: SolarMonth { try! SolarMonth(year: year, month: month) }
    public var solarYear: SolarYear { try! SolarYear(year: year) }
    public var week: Week { julianDay.week }
    /// The solar term day (节气日 Jiéqì Rì) for this date.
    public var termDay: SolarTermDay {
        var y = year
        var i = month * 2
        if i == 24 {
            y += 1
            i = 0
        }
        var term = SolarTerm.fromIndex(y, i + 1)
        var td = term.solarDay
        while isBefore(td) {
            term = term.next(-1)
            td = term.solarDay
        }
        return SolarTermDay(term, subtract(td))
    }
    /// The solar term (节气 Jiéqì) at this date.
    public var term: SolarTerm { termDay.solarTerm }
    /// The sexagenary cycle day (六十甲子日 Liùshí Jiǎzǐ Rì).
    public var sixtyCycleDay: SixtyCycleDay { SixtyCycleDay(solarDay: self) }
    /// The corresponding day in the Chinese lunar calendar (农历 Nónglì).
    public var lunarDay: LunarDay {
        var m = try! LunarMonth.fromYm(year, month)
        var days = subtract(m.firstJulianDay.solarDay)
        while days < 0 {
            m = m.next(-1)
            days += m.dayCount
        }
        while days >= m.dayCount {
            days -= m.dayCount
            m = m.next(1)
        }
        return try! LunarDay.fromYmd(m.year, m.monthWithLeap, days + 1)
    }

    /// Returns the solar day offset by the given number of days.
    /// - Parameter n: Positive to advance, negative to go back.
    public func next(_ n: Int) -> SolarDay {
        let jd = julianDay
        let target = JulianDay(jd.value + Double(n))
        let ymd = target.toYmdHms()
        return try! SolarDay(year: ymd.year, month: ymd.month, day: ymd.day)
    }

    public func isBefore(_ target: SolarDay) -> Bool {
        if year != target.year { return year < target.year }
        if month != target.month { return month < target.month }
        return day < target.day
    }

    public func isAfter(_ target: SolarDay) -> Bool {
        if year != target.year { return year > target.year }
        if month != target.month { return month > target.month }
        return day > target.day
    }

    public func subtract(_ target: SolarDay) -> Int {
        Int(julianDay.subtract(target.julianDay))
    }

    public func getSolarWeek(_ start: Int) -> SolarWeek {
        let firstWeek = try! SolarDay(year: year, month: month, day: 1).week.next(-start).index
        let i = Int(ceil(Double(day + firstWeek) / 7.0)) - 1
        return try! SolarWeek(year: year, month: month, index: i, start: start)
    }

    @available(*, deprecated, renamed: "julianDay")
    public func getJulianDay() -> JulianDay { julianDay }

    @available(*, deprecated, renamed: "solarMonth")
    public func getSolarMonth() -> SolarMonth { solarMonth }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear { solarYear }

    @available(*, deprecated, renamed: "week")
    public func getWeek() -> Week { week }

    @available(*, deprecated, renamed: "termDay")
    public func getTermDay() -> SolarTermDay { termDay }

    @available(*, deprecated, renamed: "term")
    public func getTerm() -> SolarTerm { term }

    @available(*, deprecated, renamed: "sixtyCycleDay")
    public func getSixtyCycleDay() -> SixtyCycleDay { sixtyCycleDay }

    @available(*, deprecated, renamed: "lunarDay")
    public func getLunarDay() -> LunarDay { lunarDay }
}

extension SolarDay: Codable {
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
        try container.encode(month, forKey: .month)
        try container.encode(day, forKey: .day)
    }
}
