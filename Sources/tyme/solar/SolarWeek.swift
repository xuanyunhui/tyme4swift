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
        self.start = start
    }

    public static func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> SolarWeek {
        try SolarWeek(year: year, month: month, index: index, start: start)
    }

    public func getSolarMonth() -> SolarMonth { try! SolarMonth(year: getYear(), month: getMonth()) }

    public func getIndexInYear() -> Int {
        var i = 0
        let firstDay = try! getFirstDay()
        var w = try! SolarWeek(year: getYear(), month: 1, index: 0, start: start)
        while w.getFirstDay().getName() != firstDay.getName() {
            w = w.next(1)
            i += 1
        }
        return i
    }

    public func getName() -> String { SolarWeek.NAMES[getIndex()] }

    public func next(_ n: Int) -> SolarWeek {
        var d = index
        var m = getSolarMonth()
        if n > 0 {
            d += n
            var weekCount = m.getWeekCount(start)
            while d >= weekCount {
                d -= weekCount
                m = m.next(1)
                if m.getFirstDay().getWeek().getIndex() != start { d += 1 }
                weekCount = m.getWeekCount(start)
            }
        } else if n < 0 {
            d += n
            while d < 0 {
                if m.getFirstDay().getWeek().getIndex() != start { d -= 1 }
                m = m.next(-1)
                d += m.getWeekCount(start)
            }
        }
        return try! SolarWeek(year: m.getYear(), month: m.getMonth(), index: d, start: start)
    }

    public func getFirstDay() -> SolarDay {
        let firstDay = try! SolarDay(year: getYear(), month: getMonth(), day: 1)
        return firstDay.next(index * 7 - indexOf(firstDay.getWeek().getIndex() - start, 7))
    }

    public func getDays() -> [SolarDay] {
        let d = try! getFirstDay()
        return (0..<7).map { d.next($0) }
    }
}
