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

    public func getSolarMonth() -> SolarMonth { try! SolarMonth(year: year, month: month) }

    public func getIndexInYear() -> Int {
        var i = 0
        let firstDay = getFirstDay()
        var w = try! SolarWeek(year: year, month: 1, index: 0, start: startIndex)
        while w.getFirstDay().getName() != firstDay.getName() {
            w = w.next(1)
            i += 1
        }
        return i
    }

    public func getName() -> String { SolarWeek.NAMES[index] }

    public func next(_ n: Int) -> SolarWeek {
        var d = index
        var m = getSolarMonth()
        if n > 0 {
            d += n
            var weekCount = m.getWeekCount(startIndex)
            while d >= weekCount {
                d -= weekCount
                m = m.next(1)
                if m.getFirstDay().getWeek().index != startIndex { d += 1 }
                weekCount = m.getWeekCount(startIndex)
            }
        } else if n < 0 {
            d += n
            while d < 0 {
                if m.getFirstDay().getWeek().index != startIndex { d -= 1 }
                m = m.next(-1)
                d += m.getWeekCount(startIndex)
            }
        }
        return try! SolarWeek(year: m.year, month: m.month, index: d, start: startIndex)
    }

    public func getFirstDay() -> SolarDay {
        let firstDay = try! SolarDay(year: year, month: month, day: 1)
        return firstDay.next(index * 7 - indexOf(firstDay.getWeek().index - startIndex, 7))
    }

    public func getDays() -> [SolarDay] {
        let d = getFirstDay()
        return (0..<7).map { d.next($0) }
    }
}
