import Foundation

public final class SolarYear: YearUnit, Tyme {
    public override init(year: Int) {
        super.init(year: year)
    }

    public static func fromYear(_ year: Int) -> SolarYear {
        SolarYear(year: year)
    }

    public func getName() -> String { String(format: "%04d", getYear()) }

    public func getMonthCount() -> Int { 12 }

    public func getDayCount() -> Int { SolarUtil.isLeapYear(getYear()) ? 366 : 365 }

    public func getSolarMonth(_ month: Int) -> SolarMonth { SolarMonth(year: getYear(), month: month) }

    public func next(_ n: Int) -> SolarYear { SolarYear(year: getYear() + n) }
}
