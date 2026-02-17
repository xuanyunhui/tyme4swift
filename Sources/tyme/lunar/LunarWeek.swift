import Foundation

public final class LunarWeek: WeekUnit, Tyme {
    public static let NAMES = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]

    public static func validate(year: Int, month: Int, index: Int, start: Int) throws {
        try WeekUnit.validate(index: index, start: start)
        let m = try! LunarMonth.fromYm(year, month)
        if index >= m.getWeekCount(start) {
            throw TymeError.invalidIndex(index)
        }
    }

    public init(year: Int, month: Int, index: Int, start: Int) throws {
        try LunarWeek.validate(year: year, month: month, index: index, start: start)
        try super.init(year: year, month: month)
        self.index = index
        self.start = start
    }

    public static func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> LunarWeek {
        try LunarWeek(year: year, month: month, index: index, start: start)
    }

    public func getLunarMonth() -> LunarMonth { try! LunarMonth.fromYm(getYear(), try! getMonth()) }

    public func getName() -> String { LunarWeek.NAMES[getIndex()] }

    public func next(_ n: Int) -> LunarWeek {
        if n == 0 { return try! LunarWeek(year: getYear(), month: getMonth(), index: index, start: start) }
        var d = index + n
        var m = getLunarMonth()
        if n > 0 {
            var weekCount = m.getWeekCount(start)
            while d >= weekCount {
                d -= weekCount
                m = m.next(1)
                if m.getFirstDay().getWeek().getIndex() != start { d += 1 }
                weekCount = m.getWeekCount(start)
            }
        } else {
            while d < 0 {
                if m.getFirstDay().getWeek().getIndex() != start { d -= 1 }
                m = m.next(-1)
                d += m.getWeekCount(start)
            }
        }
        return try! LunarWeek(year: m.getYear(), month: m.getMonthWithLeap(), index: d, start: start)
    }

    public func getFirstDay() -> LunarDay {
        let firstDay = try! LunarDay.fromYmd(getYear(), try! getMonth(), 1)
        return firstDay.next(index * 7 - indexOf(firstDay.getWeek().getIndex() - start, 7))
    }

    public func getDays() -> [LunarDay] {
        let d = try! getFirstDay()
        return (0..<7).map { d.next($0) }
    }
}
