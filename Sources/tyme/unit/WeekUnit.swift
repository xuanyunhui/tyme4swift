import Foundation

open class WeekUnit: MonthUnit {
    internal var index: Int = 0
    internal var start: Int = 0

    public func getIndex() -> Int { index }

    public func getStart() -> Week { Week.fromIndex(start) }

    public static func validate(index: Int, start: Int) throws {
        if index < 0 || index > 5 { throw TymeError.invalidIndex(index) }
        if start < 0 || start > 6 { throw TymeError.invalidIndex(start) }
    }
}
