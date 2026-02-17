import Foundation

/// A solar term (节气 Jiéqì) in the Chinese calendar.
///
/// The 24 solar terms divide the tropical year into 24 segments based on
/// the Sun's ecliptic longitude. They alternate between minor terms (节 Jié)
/// and major terms (中气 Zhōngqì).
///
/// ## The 24 Solar Terms (partial)
///
/// | Index | Name | Pinyin |
/// |-------|------|--------|
/// | 0 | 冬至 | Dōngzhì (Winter Solstice) |
/// | 1 | 小寒 | Xiǎohán (Minor Cold) |
/// | 2 | 大寒 | Dàhán (Major Cold) |
/// | ... | ... | ... |
///
/// ## Usage
///
/// ```swift
/// let term = try SolarTerm(year: 2024, name: "春分")
/// let day = term.solarDay  // The day this term begins
/// ```
public final class SolarTerm: LoopTyme {
    public static let NAMES = ["冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪"]

    public private(set) var year: Int
    public private(set) var cursoryJulianDay: Double

    public required init(names: [String], index: Int) {
        self.year = 2000
        self.cursoryJulianDay = 0
        super.init(names: names, index: index)
    }

    public init(year: Int, index: Int) throws {
        let size = SolarTerm.NAMES.count
        let normalizedYear = (year * size + index) / size
        let normalizedIndex = ((index % size) + size) % size
        self.year = normalizedYear
        self.cursoryJulianDay = 0
        super.init(names: SolarTerm.NAMES, index: normalizedIndex)
        initByYear(normalizedYear, normalizedIndex)
    }

    public convenience init(year: Int, name: String) throws {
        guard let idx = SolarTerm.NAMES.firstIndex(of: name) else {
            throw TymeError.invalidName(name)
        }
        try! self.init(year: year, index: idx)
    }

    private func initByYear(_ year: Int, _ offset: Int) {
        let jd = floor(Double(year - 2000) * 365.2422 + 180.0)
        var w = floor((jd - 355.0 + 183.0) / 365.2422) * 365.2422 + 355.0
        if ShouXingUtil.calcQi(w) > jd { w -= 365.2422 }
        self.year = year
        self.cursoryJulianDay = ShouXingUtil.calcQi(w + 15.2184 * Double(offset))
    }

    public static func fromIndex(_ year: Int, _ index: Int) -> SolarTerm {
        try! SolarTerm(year: year, index: index)
    }

    public static func fromName(_ year: Int, _ name: String) throws -> SolarTerm {
        try! SolarTerm(year: year, name: name)
    }

    public override func next(_ n: Int) -> SolarTerm {
        let size = SolarTerm.NAMES.count
        let i = index + n
        return try! SolarTerm(year: (year * size + i) / size, index: ((i % size) + size) % size)
    }

    /// Returns `true` if this is a minor term (节 Jié, odd-indexed).
    public func isJie() -> Bool { index % 2 == 1 }
    /// Returns `true` if this is a major term (中气 Zhōngqì, even-indexed).
    public func isQi() -> Bool { index % 2 == 0 }

    /// The precise Julian Day when this solar term occurs.
    public var julianDay: JulianDay {
        JulianDay.fromJulianDay(ShouXingUtil.qiAccurate2(cursoryJulianDay) + JulianDay.J2000)
    }

    /// The Gregorian calendar date of this solar term.
    public var solarDay: SolarDay {
        JulianDay.fromJulianDay(cursoryJulianDay + JulianDay.J2000).solarDay
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "cursoryJulianDay")
    public func getCursoryJulianDay() -> Double { cursoryJulianDay }

    @available(*, deprecated, renamed: "julianDay")
    public func getJulianDay() -> JulianDay { julianDay }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> SolarDay { solarDay }
}
