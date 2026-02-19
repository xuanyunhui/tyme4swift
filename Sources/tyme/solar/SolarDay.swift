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

    /// 对应的藏历日（仅支持1951年1月8日至2051年2月11日范围，超出返回nil）
    public var rabByungDay: RabByungDay? { try? RabByungDay.fromSolarDay(self) }

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

    /// 星座
    public var constellation: Constellation {
        let y = month * 100 + day
        return Constellation.fromIndex(y > 1221 || y < 120 ? 9 : y < 219 ? 10 : y < 321 ? 11 : y < 420 ? 0 : y < 521 ? 1 : y < 622 ? 2 : y < 723 ? 3 : y < 823 ? 4 : y < 923 ? 5 : y < 1024 ? 6 : y < 1123 ? 7 : 8)
    }

    /// 三伏天，如果当天不是三伏天，返回nil
    public var dogDay: DogDay? {
        let xiaZhi = SolarTerm.fromIndex(year, 12)
        var start = xiaZhi.solarDay
        // Safe: lunarDay is valid for any validated SolarDay; stepsTo always returns valid offset
        start = start.next(start.lunarDay.sixtyCycle.heavenStem.stepsTo(6) + 20)
        var days = subtract(start)
        if days < 0 { return nil }
        if days < 10 { return DogDay(dog: Dog.fromIndex(0), dayIndex: days) }
        start = start.next(10)
        days = subtract(start)
        if days < 10 { return DogDay(dog: Dog.fromIndex(1), dayIndex: days) }
        start = start.next(10)
        days = subtract(start)
        if xiaZhi.next(3).solarDay.isAfter(start) {
            if days < 10 { return DogDay(dog: Dog.fromIndex(1), dayIndex: days + 10) }
            start = start.next(10)
            days = subtract(start)
        }
        return days >= 10 ? nil : DogDay(dog: Dog.fromIndex(2), dayIndex: days)
    }

    /// 数九天，如果当天不在数九期间，返回nil
    public var nineColdDay: NineColdDay? {
        var start = SolarTerm.fromIndex(year + 1, 0).solarDay
        if isBefore(start) {
            start = SolarTerm.fromIndex(year, 0).solarDay
        }
        let end = start.next(81)
        if isBefore(start) || !isBefore(end) { return nil }
        let days = subtract(start)
        return NineColdDay(nine: Nine.fromIndex(days / 9), dayIndex: days % 9)
    }

    /// 梅雨天，如果当天不在梅雨期间，返回nil
    public var plumRainDay: PlumRainDay? {
        let grainInEar = SolarTerm.fromIndex(year, 11)
        var start = grainInEar.solarDay
        // Safe: lunarDay/sixtyCycle computed from validated SolarDay
        start = start.next(start.lunarDay.sixtyCycle.heavenStem.stepsTo(2))
        var end = grainInEar.next(2).solarDay
        end = end.next(end.lunarDay.sixtyCycle.earthBranch.stepsTo(7))
        if isBefore(start) || isAfter(end) { return nil }
        let isEnd = year == end.year && month == end.month && day == end.day
        return isEnd ? PlumRainDay(plumRain: PlumRain.fromIndex(1), dayIndex: 0) : PlumRainDay(plumRain: PlumRain.fromIndex(0), dayIndex: subtract(start))
    }

    /// 藏干日
    public var hideHeavenStemDay: HideHeavenStemDay {
        let dayCounts = [3, 5, 7, 9, 10, 30]
        var t = term
        if t.isQi() { t = t.next(-1) }
        let dayIdx = subtract(t.solarDay)
        let startIndex = (t.index - 1) * 3
        let data = "93705542220504xx1513904541632524533533105544806564xx7573304542018584xx95"
        let startPos = data.index(data.startIndex, offsetBy: startIndex)
        let endPos = data.index(startPos, offsetBy: 6)
        let segment = String(data[startPos..<endPos])
        var days = 0
        var heavenStemIndex = 0
        var typeIndex = 0
        var remaining = dayIdx
        while typeIndex < 3 {
            let i = typeIndex * 2
            let dChar = String(segment[segment.index(segment.startIndex, offsetBy: i)..<segment.index(segment.startIndex, offsetBy: i + 1)])
            var count = 0
            if dChar != "x" {
                heavenStemIndex = Int(dChar)!
                count = dayCounts[Int(String(segment[segment.index(segment.startIndex, offsetBy: i + 1)..<segment.index(segment.startIndex, offsetBy: i + 2)]))!]
                days += count
            }
            if dayIdx <= days {
                remaining = dayIdx - (days - count)
                break
            }
            typeIndex += 1
        }
        return HideHeavenStemDay(
            hideHeavenStem: HideHeavenStem(heavenStem: HeavenStem.fromIndex(heavenStemIndex), type: HideHeavenStemType.fromIndex(typeIndex)),
            dayIndex: remaining
        )
    }

    /// 在当年中的索引（0-based）
    public var indexInYear: Int {
        // Safe: year is already validated; Jan 1 is always valid
        subtract(try! SolarDay.fromYmd(year, 1, 1))
    }

    /// 物候日
    public var phenologyDay: PhenologyDay {
        let d = termDay
        let dayIdx = d.dayIndex
        var idx = dayIdx / 5
        if idx > 2 { idx = 2 }
        let t = d.solarTerm
        return PhenologyDay(phenology: Phenology.fromIndex(t.year, t.index * 3 + idx), dayIndex: dayIdx - idx * 5)
    }

    /// 物候
    public var phenology: Phenology { phenologyDay.phenology }

    /// 月相日
    public var phaseDay: PhaseDay {
        let m = lunarDay.lunarMonth.next(1)
        var p = Phase.fromIndex(m.year, m.monthWithLeap, 0)
        var d = p.solarDay
        var guardCount = 0
        while d.isAfter(self) {
            guardCount += 1
            if guardCount > 50 { break } // Phase cycle < 30 days; 50 steps is impossible
            p = p.next(-1)
            d = p.solarDay
        }
        return PhaseDay(phase: p, dayIndex: subtract(d))
    }

    /// 月相
    public var phase: Phase { phaseDay.phase }

    /// 法定假日，如果当天不是法定假日，返回nil
    public var legalHoliday: LegalHoliday? {
        LegalHoliday.fromYmd(year, month, day)
    }

    /// 公历现代节日，如果当天不是公历节日，返回nil
    public var festival: SolarFestival? {
        SolarFestival.fromYmd(year, month, day)
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

    @available(*, deprecated, renamed: "constellation")
    public func getConstellation() -> Constellation { constellation }

    @available(*, deprecated, renamed: "dogDay")
    public func getDogDay() -> DogDay? { dogDay }

    @available(*, deprecated, renamed: "nineColdDay")
    public func getNineColdDay() -> NineColdDay? { nineColdDay }

    @available(*, deprecated, renamed: "plumRainDay")
    public func getPlumRainDay() -> PlumRainDay? { plumRainDay }

    @available(*, deprecated, renamed: "hideHeavenStemDay")
    public func getHideHeavenStemDay() -> HideHeavenStemDay { hideHeavenStemDay }

    @available(*, deprecated, renamed: "indexInYear")
    public func getIndexInYear() -> Int { indexInYear }

    @available(*, deprecated, renamed: "phenologyDay")
    public func getPhenologyDay() -> PhenologyDay { phenologyDay }

    @available(*, deprecated, renamed: "phenology")
    public func getPhenology() -> Phenology { phenology }

    @available(*, deprecated, renamed: "phaseDay")
    public func getPhaseDay() -> PhaseDay { phaseDay }

    @available(*, deprecated, renamed: "phase")
    public func getPhase() -> Phase { phase }

    @available(*, deprecated, renamed: "legalHoliday")
    public func getLegalHoliday() -> LegalHoliday? { legalHoliday }

    @available(*, deprecated, renamed: "festival")
    public func getFestival() -> SolarFestival? { festival }
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
