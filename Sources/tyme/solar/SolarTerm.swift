import Foundation

public final class SolarTerm: LoopTyme {
    public static let NAMES = ["冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪"]

    private var year: Int
    private var cursoryJulianDay: Double

    public required init(names: [String], index: Int) {
        self.year = 2000
        self.cursoryJulianDay = 0
        super.init(names: names, index: index)
    }

    public init(year: Int, index: Int) {
        let size = SolarTerm.NAMES.count
        let normalizedYear = (year * size + index) / size
        let normalizedIndex = ((index % size) + size) % size
        self.year = normalizedYear
        self.cursoryJulianDay = 0
        super.init(names: SolarTerm.NAMES, index: normalizedIndex)
        initByYear(normalizedYear, normalizedIndex)
    }

    public convenience init(year: Int, name: String) {
        guard let idx = SolarTerm.NAMES.firstIndex(of: name) else {
            fatalError("Invalid solar term name: \(name)")
        }
        self.init(year: year, index: idx)
    }

    private func initByYear(_ year: Int, _ offset: Int) {
        let jd = floor(Double(year - 2000) * 365.2422 + 180.0)
        var w = floor((jd - 355.0 + 183.0) / 365.2422) * 365.2422 + 355.0
        if ShouXingUtil.calcQi(w) > jd { w -= 365.2422 }
        self.year = year
        self.cursoryJulianDay = ShouXingUtil.calcQi(w + 15.2184 * Double(offset))
    }

    public static func fromIndex(_ year: Int, _ index: Int) -> SolarTerm {
        SolarTerm(year: year, index: index)
    }

    public static func fromName(_ year: Int, _ name: String) -> SolarTerm {
        SolarTerm(year: year, name: name)
    }

    public override func next(_ n: Int) -> SolarTerm {
        let size = SolarTerm.NAMES.count
        let i = index + n
        return SolarTerm(year: (year * size + i) / size, index: ((i % size) + size) % size)
    }

    public func isJie() -> Bool { index % 2 == 1 }
    public func isQi() -> Bool { index % 2 == 0 }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromJulianDay(ShouXingUtil.qiAccurate2(cursoryJulianDay) + JulianDay.J2000)
    }

    public func getSolarDay() -> SolarDay {
        JulianDay.fromJulianDay(cursoryJulianDay + JulianDay.J2000).getSolarDay()
    }

    public func getYear() -> Int { year }
    public func getCursoryJulianDay() -> Double { cursoryJulianDay }
}
