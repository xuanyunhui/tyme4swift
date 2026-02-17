import Foundation

public final class SolarMonth: MonthUnit, Tyme {
    public override init(year: Int, month: Int) throws {
        try SolarUtil.validateYear(year)
        try super.init(year: year, month: month)
    }

    public static func fromYm(_ year: Int, _ month: Int) throws -> SolarMonth {
        try SolarMonth(year: year, month: month)
    }

    public func getName() -> String { String(format: "%04d-%02d", year, month) }

    public var dayCount: Int { try! SolarUtil.daysInMonth(year: year, month: month) }
    public var indexInYear: Int { month - 1 }
    public var season: SolarSeason { try! SolarSeason(year: year, index: indexInYear / 3) }
    public var solarYear: SolarYear { try! SolarYear(year: year) }
    public var days: [SolarDay] { (1...dayCount).map { try! SolarDay(year: year, month: month, day: $0) } }
    public var firstDay: SolarDay { try! SolarDay(year: year, month: month, day: 1) }

    public func getWeekCount(_ start: Int) -> Int {
        let firstWeekIndex = indexOf(firstDay.week.index - start, 7)
        return Int(ceil((Double(firstWeekIndex + dayCount)) / 7.0))
    }

    public func getSolarDay(_ day: Int) -> SolarDay { try! SolarDay(year: year, month: month, day: day) }

    public func next(_ n: Int) -> SolarMonth {
        let total = year * 12 + (month - 1) + n
        let y = total / 12
        let m = indexOf(total, 12) + 1
        return try! SolarMonth(year: y, month: m)
    }

    public func getWeeks(_ start: Int) -> [SolarWeek] {
        let size = getWeekCount(start)
        return (0..<size).map { try! SolarWeek(year: year, month: month, index: $0, start: start) }
    }

    @available(*, deprecated, renamed: "dayCount")
    public func getDayCount() -> Int { dayCount }

    @available(*, deprecated, renamed: "indexInYear")
    public func getIndexInYear() -> Int { indexInYear }

    @available(*, deprecated, renamed: "season")
    public func getSeason() -> SolarSeason { season }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear { solarYear }

    @available(*, deprecated, renamed: "days")
    public func getDays() -> [SolarDay] { days }

    @available(*, deprecated, renamed: "firstDay")
    public func getFirstDay() -> SolarDay { firstDay }
}
