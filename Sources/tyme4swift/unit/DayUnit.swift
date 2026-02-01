import Foundation

open class DayUnit: MonthUnit {
    private let day: Int

    public init(year: Int, month: Int, day: Int) {
        if day < 1 || day > 31 {
            fatalError("Invalid day: \(day)")
        }
        self.day = day
        super.init(year: year, month: month)
    }

    public func getDay() -> Int { day }
}
