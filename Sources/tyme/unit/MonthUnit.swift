import Foundation

open class MonthUnit: YearUnit {
    public let month: Int

    public init(year: Int, month: Int) throws {
        if month < 1 || month > 12 {
            throw TymeError.invalidMonth(month)
        }
        self.month = month
        try super.init(year: year)
    }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }
}
