import Foundation

public final class SolarSeason: YearUnit, Tyme {
    public static let NAMES = ["一季度", "二季度", "三季度", "四季度"]
    private let index: Int

    public static func validate(year: Int, index: Int) {
        if index < 0 || index > 3 { fatalError("illegal solar season index: \(index)") }
        SolarUtil.validateYear(year)
    }

    public init(year: Int, index: Int) {
        SolarSeason.validate(year: year, index: index)
        self.index = index
        super.init(year: year)
    }

    public static func fromIndex(_ year: Int, _ index: Int) -> SolarSeason {
        SolarSeason(year: year, index: index)
    }

    public func getSolarYear() -> SolarYear { SolarYear(year: getYear()) }

    public func getIndex() -> Int { index }

    public func getName() -> String { SolarSeason.NAMES[index] }

    public func next(_ n: Int) -> SolarSeason {
        let i = index + n
        return SolarSeason(year: (getYear() * 4 + i) / 4, index: indexOf(i, 4))
    }

    public func getMonths() -> [SolarMonth] {
        (1...3).map { SolarMonth(year: getYear(), month: index * 3 + $0) }
    }
}
