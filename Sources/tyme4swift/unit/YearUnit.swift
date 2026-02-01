import Foundation

open class YearUnit {
    private let year: Int

    public init(year: Int) {
        self.year = year
    }

    public func getYear() -> Int { year }
}
