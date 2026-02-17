import Foundation

open class WeekUnit: MonthUnit {
    public var index: Int = 0
    public var startIndex: Int = 0

    public var start: Week { Week.fromIndex(startIndex) }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    @available(*, deprecated, renamed: "start")
    public func getStart() -> Week { start }

    public static func validate(index: Int, start: Int) throws {
        if index < 0 || index > 5 { throw TymeError.invalidIndex(index) }
        if start < 0 || start > 6 { throw TymeError.invalidIndex(start) }
    }
}
