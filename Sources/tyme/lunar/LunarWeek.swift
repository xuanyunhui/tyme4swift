import Foundation

public final class LunarWeek: WeekUnit, Tyme {
    public static let NAMES = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]

    public static func validate(year: Int, month: Int, index: Int, start: Int) throws {
        try WeekUnit.validate(index: index, start: start)
        let m = try LunarMonth.fromYm(year, month)
        if index >= m.getWeekCount(start) {
            throw TymeError.invalidIndex(index)
        }
    }

    public init(year: Int, month: Int, index: Int, start: Int) throws {
        try LunarWeek.validate(year: year, month: month, index: index, start: start)
        try super.init(year: year, month: month)
        self.index = index
        self.startIndex = start
    }

    public static func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> LunarWeek {
        try LunarWeek(year: year, month: month, index: index, start: start)
    }

    public var lunarMonth: LunarMonth {
        guard let m = try? LunarMonth.fromYm(year, month) else {
            preconditionFailure("LunarWeek: invalid month calculation")
        }
        return m
    }

    public func getName() -> String { LunarWeek.NAMES[index] }

    public func next(_ n: Int) -> LunarWeek {
        if n == 0 {
            guard let result = try? LunarWeek(year: year, month: month, index: index, start: startIndex) else {
                preconditionFailure("LunarWeek: invalid self recreation")
            }
            return result
        }
        var d = index + n
        var m = lunarMonth
        if n > 0 {
            var weekCount = m.getWeekCount(startIndex)
            while d >= weekCount {
                d -= weekCount
                m = m.next(1)
                if m.firstDay.week.index != startIndex { d += 1 }
                weekCount = m.getWeekCount(startIndex)
            }
        } else {
            while d < 0 {
                if m.firstDay.week.index != startIndex { d -= 1 }
                m = m.next(-1)
                d += m.getWeekCount(startIndex)
            }
        }
        guard let result = try? LunarWeek(year: m.year, month: m.monthWithLeap, index: d, start: startIndex) else {
            preconditionFailure("LunarWeek: invalid next calculation")
        }
        return result
    }

    public var firstDay: LunarDay {
        guard let fd = try? LunarDay.fromYmd(year, month, 1) else {
            preconditionFailure("LunarWeek: invalid first day calculation")
        }
        return fd.next(index * 7 - indexOf(fd.week.index - startIndex, 7))
    }

    public var days: [LunarDay] {
        let d = firstDay
        return (0..<7).map { d.next($0) }
    }

    @available(*, deprecated, renamed: "lunarMonth")
    public func getLunarMonth() -> LunarMonth { lunarMonth }

    @available(*, deprecated, renamed: "firstDay")
    public func getFirstDay() -> LunarDay { firstDay }

    @available(*, deprecated, renamed: "days")
    public func getDays() -> [LunarDay] { days }
}
