import Foundation

public final class SolarWeek: WeekUnit, Tyme {
    public static let NAMES = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]

    public static func validate(year: Int, month: Int, index: Int, start: Int) throws {
        try WeekUnit.validate(index: index, start: start)
        let m = try SolarMonth(year: year, month: month)
        if index >= m.getWeekCount(start) {
            throw TymeError.invalidIndex(index)
        }
    }

    public init(year: Int, month: Int, index: Int, start: Int) throws {
        try SolarWeek.validate(year: year, month: month, index: index, start: start)
        try super.init(year: year, month: month)
        self.index = index
        self.startIndex = start
    }

    public static func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> SolarWeek {
        try SolarWeek(year: year, month: month, index: index, start: start)
    }

    public var solarMonth: SolarMonth {
        guard let m = try? SolarMonth(year: year, month: month) else {
            preconditionFailure("SolarWeek: invalid month calculation")
        }
        return m
    }

    public var indexInYear: Int {
        var i = 0
        let firstDay = self.firstDay
        guard var w = try? SolarWeek(year: year, month: 1, index: 0, start: startIndex) else {
            preconditionFailure("SolarWeek: invalid week calculation")
        }
        while w.firstDay.getName() != firstDay.getName() {
            w = w.next(1)
            i += 1
        }
        return i
    }

    public func getName() -> String { SolarWeek.NAMES[index] }

    public func next(_ n: Int) -> SolarWeek {
        var d = index
        var m = solarMonth
        if n > 0 {
            d += n
            var weekCount = m.getWeekCount(startIndex)
            while d >= weekCount {
                d -= weekCount
                m = m.next(1)
                if m.firstDay.week.index != startIndex { d += 1 }
                weekCount = m.getWeekCount(startIndex)
            }
        } else if n < 0 {
            d += n
            while d < 0 {
                if m.firstDay.week.index != startIndex { d -= 1 }
                m = m.next(-1)
                d += m.getWeekCount(startIndex)
            }
        }
        guard let result = try? SolarWeek(year: m.year, month: m.month, index: d, start: startIndex) else {
            preconditionFailure("SolarWeek: invalid next calculation")
        }
        return result
    }

    public var firstDay: SolarDay {
        guard let first = try? SolarDay(year: year, month: month, day: 1) else {
            preconditionFailure("SolarWeek: invalid first day calculation")
        }
        return first.next(index * 7 - indexOf(first.week.index - startIndex, 7))
    }

    public var days: [SolarDay] {
        let d = firstDay
        return (0..<7).map { d.next($0) }
    }

    @available(*, deprecated, renamed: "solarMonth")
    public func getSolarMonth() -> SolarMonth { solarMonth }

    @available(*, deprecated, renamed: "indexInYear")
    public func getIndexInYear() -> Int { indexInYear }

    @available(*, deprecated, renamed: "firstDay")
    public func getFirstDay() -> SolarDay { firstDay }

    @available(*, deprecated, renamed: "days")
    public func getDays() -> [SolarDay] { days }
}
