import Foundation

public final class SolarYear: YearUnit, Tyme {
    public override init(year: Int) throws {
        try SolarUtil.validateYear(year)
        try super.init(year: year)
    }

    public static func fromYear(_ year: Int) throws -> SolarYear {
        try SolarYear(year: year)
    }

    public func getName() -> String { "\(year)年" }

    public var monthCount: Int { 12 }
    public var dayCount: Int { year == 1582 ? 355 : SolarUtil.isLeapYear(year) ? 366 : 365 }
    public var months: [SolarMonth] { (1...12).map { try! SolarMonth(year: year, month: $0) } }
    public var seasons: [SolarSeason] { (0..<4).map { try! SolarSeason(year: year, index: $0) } }
    public var halfYears: [SolarHalfYear] { (0..<2).map { try! SolarHalfYear(year: year, index: $0) } }

    /// 是否闰年
    public var isLeap: Bool { SolarUtil.isLeapYear(year) }

    /// 饶迥年（藏历年）；公历年超出饶迥支持范围时返回 nil
    public var rabByungYear: RabByungYear? { try? RabByungYear.fromYear(year) }

    /// 藏历年（已废弃，请使用 rabByungYear）
    @available(*, deprecated, renamed: "rabByungYear")
    public var tibetanYear: RabByungYear? { rabByungYear }

    public func getSolarMonth(_ month: Int) -> SolarMonth { try! SolarMonth(year: year, month: month) }

    public func next(_ n: Int) -> SolarYear { try! SolarYear(year: year + n) }

    @available(*, deprecated, renamed: "monthCount")
    public func getMonthCount() -> Int { monthCount }

    @available(*, deprecated, renamed: "dayCount")
    public func getDayCount() -> Int { dayCount }

    @available(*, deprecated, renamed: "months")
    public func getMonths() -> [SolarMonth] { months }

    @available(*, deprecated, renamed: "seasons")
    public func getSeasons() -> [SolarSeason] { seasons }

    @available(*, deprecated, renamed: "halfYears")
    public func getHalfYears() -> [SolarHalfYear] { halfYears }

    @available(*, deprecated, renamed: "isLeap")
    public func getIsLeap() -> Bool { isLeap }

    @available(*, deprecated, renamed: "tibetanYear")
    public func getTibetanYear() -> TibetanYear? { tibetanYear }
}
