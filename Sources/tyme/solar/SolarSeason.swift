import Foundation

public final class SolarSeason: YearUnit, Tyme {
    public static let NAMES = ["一季度", "二季度", "三季度", "四季度"]
    private let index: Int

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

    public func getSolarYear() -> SolarYear { try! SolarYear(year: getYear()) }

    public func getIndex() -> Int { index }

    public func getName() -> String { SolarSeason.NAMES[index] }

    public func next(_ n: Int) -> SolarSeason {
        let i = index + n
        return try! SolarSeason(year: (getYear() * 4 + i) / 4, index: indexOf(i, 4))
    }

    public func getMonths() -> [SolarMonth] {
        (1...3).map { try! SolarMonth(year: getYear(), month: index * 3 + $0) }
    }
}
