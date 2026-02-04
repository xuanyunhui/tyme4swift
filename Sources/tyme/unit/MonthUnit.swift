import Foundation

open class MonthUnit: YearUnit {
    private let month: Int

    public init(year: Int, month: Int) {
        if month < 1 || month > 12 {
            fatalError("Invalid month: \(month)")
        }
        self.month = month
        super.init(year: year)
    }

    public func getMonth() -> Int { month }
}
