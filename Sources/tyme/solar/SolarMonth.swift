import Foundation

public final class SolarMonth: MonthUnit, Tyme {
    public override init(year: Int, month: Int) throws {
        try SolarUtil.validateYear(year)
        try super.init(year: year, month: month)
    }

    public static func fromYm(_ year: Int, _ month: Int)  throws -> SolarMonth {
        try SolarMonth(year: year, month: month)
    }

    public func getName() -> String {
        String(format: "%04d-%02d", try! getYear(), getMonth())
    }

    public func getDayCount() -> Int {
        try! SolarUtil.daysInMonth(year: try! getYear(), month: getMonth())
    }

    public func getIndexInYear() -> Int { try! getMonth() - 1 }

    public func getSeason() -> SolarSeason {
        try! SolarSeason(year: getYear(), index: getIndexInYear() / 3)
    }

    public func getWeekCount(_ start: Int) -> Int {
        let firstWeekIndex = indexOf(getSolarDay(1).getWeek().getIndex() - start, 7)
        return Int(ceil((Double(firstWeekIndex + getDayCount())) / 7.0))
    }

    public func getSolarDay(_ day: Int) -> SolarDay {
        try! try SolarDay(year: getYear(), month: getMonth(), day: day)
    }

    public func getSolarYear() -> SolarYear { try! SolarYear(year: getYear()) }

    public func next(_ n: Int) -> SolarMonth {
        let total = getYear() * 12 + (getMonth() - 1) + n
        let y = total / 12
        let m = indexOf(total, 12) + 1
        return try! SolarMonth(year: y, month: m)
    }

    public func getWeeks(_ start: Int) -> [SolarWeek] {
        let size = getWeekCount(start)
        return (0..<size).map { try! SolarWeek(year: getYear(), month: getMonth(), index: $0, start: start) }
    }

    public func getDays() -> [SolarDay] {
        (1...getDayCount()).map { try! try SolarDay(year: getYear(), month: getMonth(), day: $0) }
    }

    public func getFirstDay() -> SolarDay { try! try SolarDay(year: getYear(), month: getMonth(), day: 1) }
}
