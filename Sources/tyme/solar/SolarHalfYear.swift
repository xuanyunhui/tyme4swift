import Foundation

public final class SolarHalfYear: YearUnit, Tyme {
    public static let NAMES = ["上半年", "下半年"]
    public let index: Int

    public static func validate(year: Int, index: Int) throws {
        if index < 0 || index > 1 { throw TymeError.invalidIndex(index) }
        try SolarUtil.validateYear(year)
    }

    public init(year: Int, index: Int) throws {
        try SolarHalfYear.validate(year: year, index: index)
        self.index = index
        try super.init(year: year)
    }

    public static func fromIndex(_ year: Int, _ index: Int) throws -> SolarHalfYear {
        try SolarHalfYear(year: year, index: index)
    }

    public var solarYear: SolarYear { try! SolarYear(year: year) }
    public var months: [SolarMonth] { (1...6).map { try! SolarMonth(year: year, month: index * 6 + $0) } }
    public var seasons: [SolarSeason] { (0..<2).map { try! SolarSeason(year: year, index: index * 2 + $0) } }

    public func getName() -> String { SolarHalfYear.NAMES[index] }

    public func next(_ n: Int) -> SolarHalfYear {
        let i = index + n
        return try! SolarHalfYear(year: (year * 2 + i) / 2, index: indexOf(i, 2))
    }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear { solarYear }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    @available(*, deprecated, renamed: "months")
    public func getMonths() -> [SolarMonth] { months }

    @available(*, deprecated, renamed: "seasons")
    public func getSeasons() -> [SolarSeason] { seasons }
}
