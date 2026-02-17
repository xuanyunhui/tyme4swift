import Foundation

open class YearUnit {
    internal let year: Int

    public init(year: Int) throws {
        try SolarUtil.validateYear(year)
        self.year = year
    }

    public func getYear() -> Int { year }

    internal func indexOf(_ index: Int, _ size: Int) -> Int {
        var i = index % size
        if i < 0 { i += size }
        return i
    }
}
