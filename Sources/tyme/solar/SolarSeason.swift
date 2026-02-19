import Foundation

public final class SolarSeason: YearUnit, Tyme {
    public static let NAMES = ["一季度", "二季度", "三季度", "四季度"]
    public let index: Int

    public static func validate(year: Int, index: Int) throws {
        if index < 0 || index > 3 { throw TymeError.invalidIndex(index) }
        try SolarUtil.validateYear(year)
    }

    public init(year: Int, index: Int) throws {
        try SolarSeason.validate(year: year, index: index)
        self.index = index
        try super.init(year: year)
    }

    public static func fromIndex(_ year: Int, _ index: Int) throws -> SolarSeason {
        try SolarSeason(year: year, index: index)
    }

    public var solarYear: SolarYear {
        guard let y = try? SolarYear(year: year) else {
            preconditionFailure("SolarSeason: invalid year")
        }
        return y
    }
    public var months: [SolarMonth] {
        (1...3).map { m in
            guard let month = try? SolarMonth(year: year, month: index * 3 + m) else {
                preconditionFailure("SolarSeason: invalid month")
            }
            return month
        }
    }

    public func getName() -> String { SolarSeason.NAMES[index] }

    public func next(_ n: Int) -> SolarSeason {
        let i = index + n
        guard let result = try? SolarSeason(year: (year * 4 + i) / 4, index: indexOf(i, 4)) else {
            preconditionFailure("SolarSeason: invalid next calculation")
        }
        return result
    }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> SolarYear { solarYear }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    @available(*, deprecated, renamed: "months")
    public func getMonths() -> [SolarMonth] { months }
}
