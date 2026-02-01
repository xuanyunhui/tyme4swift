import Foundation

public final class SolarHalfYear: YearUnit, Tyme {
    public static let NAMES = ["上半年", "下半年"]
    private let index: Int

    public static func validate(year: Int, index: Int) {
        if index < 0 || index > 1 { fatalError("illegal solar half year index: \(index)") }
        SolarUtil.validateYear(year)
    }

    public init(year: Int, index: Int) {
        SolarHalfYear.validate(year: year, index: index)
        self.index = index
        super.init(year: year)
    }

    public static func fromIndex(_ year: Int, _ index: Int) -> SolarHalfYear {
        SolarHalfYear(year: year, index: index)
    }

    public func getSolarYear() -> SolarYear { SolarYear(year: getYear()) }

    public func getIndex() -> Int { index }

    public func getName() -> String { SolarHalfYear.NAMES[index] }

    public func next(_ n: Int) -> SolarHalfYear {
        let i = index + n
        return SolarHalfYear(year: (getYear() * 2 + i) / 2, index: indexOf(i, 2))
    }

    public func getMonths() -> [SolarMonth] {
        (1...6).map { SolarMonth(year: getYear(), month: index * 6 + $0) }
    }

    public func getSeasons() -> [SolarSeason] {
        (0..<2).map { SolarSeason(year: getYear(), index: index * 2 + $0) }
    }
}
