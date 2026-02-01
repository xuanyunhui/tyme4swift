import Foundation

public final class SolarYear: YearUnit, Tyme {
    public override init(year: Int) {
        SolarUtil.validateYear(year)
        super.init(year: year)
    }

    public static func fromYear(_ year: Int) -> SolarYear {
        SolarYear(year: year)
    }

    public func getName() -> String { String(format: "%04d", getYear()) }

    public func getMonthCount() -> Int { 12 }

    public func getDayCount() -> Int {
        if getYear() == 1582 { return 355 }
        return SolarUtil.isLeapYear(getYear()) ? 366 : 365
    }

    public func getSolarMonth(_ month: Int) -> SolarMonth { SolarMonth(year: getYear(), month: month) }

    public func next(_ n: Int) -> SolarYear { SolarYear(year: getYear() + n) }

    public func getMonths() -> [SolarMonth] {
        (1...12).map { SolarMonth(year: getYear(), month: $0) }
    }

    public func getSeasons() -> [SolarSeason] {
        (0..<4).map { SolarSeason(year: getYear(), index: $0) }
    }

    public func getHalfYears() -> [SolarHalfYear] {
        (0..<2).map { SolarHalfYear(year: getYear(), index: $0) }
    }
}
