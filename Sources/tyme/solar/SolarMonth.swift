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

    public var dayCount: Int {
        guard let count = try? SolarUtil.daysInMonth(year: year, month: month) else {
            preconditionFailure("SolarMonth: invalid day count calculation")
        }
        return count
    }
    public var indexInYear: Int { month - 1 }
    public var season: SolarSeason {
        guard let s = try? SolarSeason(year: year, index: indexInYear / 3) else {
            preconditionFailure("SolarMonth: invalid season calculation")
        }
        return s
    }
    public var solarYear: SolarYear {
        guard let y = try? SolarYear(year: year) else {
            preconditionFailure("SolarMonth: invalid year calculation")
        }
        return y
    }
    public var days: [SolarDay] {
        (1...dayCount).map { d in
            guard let day = try? SolarDay(year: year, month: month, day: d) else {
                preconditionFailure("SolarMonth: invalid day \(d)")
            }
            return day
        }
    }
    public var firstDay: SolarDay {
        guard let day = try? SolarDay(year: year, month: month, day: 1) else {
            preconditionFailure("SolarMonth: invalid first day")
        }
        return day
    }

    public func getWeekCount(_ start: Int) -> Int {
        let firstWeekIndex = indexOf(firstDay.week.index - start, 7)
        return Int(ceil((Double(firstWeekIndex + dayCount)) / 7.0))
    }

    public func getSolarDay(_ day: Int) -> SolarDay {
        guard let d = try? SolarDay(year: year, month: month, day: day) else {
            preconditionFailure("SolarMonth: invalid day \(day)")
        }
        return d
    }

    public func next(_ n: Int) -> SolarMonth {
        let total = year * 12 + (month - 1) + n
        let y = total / 12
        let m = indexOf(total, 12) + 1
        guard let result = try? SolarMonth(year: y, month: m) else {
            preconditionFailure("SolarMonth: invalid next calculation")
        }
        return result
    }

    public func getWeeks(_ start: Int) -> [SolarWeek] {
        let size = getWeekCount(start)
        return (0..<size).map { i in
            guard let w = try? SolarWeek(year: year, month: month, index: i, start: start) else {
                preconditionFailure("SolarMonth: invalid week \(i)")
            }
            return w
        }
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
