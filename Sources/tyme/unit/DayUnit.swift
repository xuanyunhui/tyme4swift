import Foundation

open class DayUnit: MonthUnit {
    internal let day: Int

    public init(year: Int, month: Int, day: Int) throws {
        if day < 1 || day > 31 {
            throw TymeError.invalidDay(day)
        }
        self.day = day
        try super.init(year: year, month: month)
    }

    public func getDay() -> Int { day }
}
