import Foundation

/// 藏历日 (Tibetan Day)
/// Represents a day in the Tibetan calendar
public final class TibetanDay: AbstractCulture {
    /// Day names (藏历日名称)
    public static let NAMES = [
        "初一", "初二", "初三", "初四", "初五",
        "初六", "初七", "初八", "初九", "初十",
        "十一", "十二", "十三", "十四", "十五",
        "十六", "十七", "十八", "十九", "二十",
        "廿一", "廿二", "廿三", "廿四", "廿五",
        "廿六", "廿七", "廿八", "廿九", "三十"
    ]

    public let year: Int
    public let month: Int
    public let day: Int
    public let isLeapMonth: Bool

    /// Initialize with year, month, and day
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12, negative for leap month)
    ///   - day: The day (1-30)
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.isLeapMonth = month < 0
        self.month = abs(month)
        self.day = day
        super.init()
    }

    public var monthWithLeap: Int { isLeapMonth ? -month : month }

    /// 藏历月（仅支持1950-2050年范围，超出范围返回 nil）
    public var rabByungMonth: RabByungMonth? { try? RabByungMonth.fromYm(year, monthWithLeap) }

    public var tibetanYear: TibetanYear? { try? TibetanYear.fromYear(year) }

    /// Get name
    /// - Returns: Day name
    public override func getName() -> String {
        return TibetanDay.NAMES[day - 1]
    }

    /// Get next Tibetan day
    /// - Parameter n: Number of days to advance
    /// - Returns: Next TibetanDay instance
    public func next(_ n: Int) -> TibetanDay {
        var d = day + n
        var m = month
        var y = year
        let leap = isLeapMonth

        while d > 30 {
            d -= 30
            m += 1
            if m > 12 {
                m = 1
                y += 1
            }
        }
        while d < 1 {
            d += 30
            m -= 1
            if m < 1 {
                m = 12
                y -= 1
            }
        }

        return TibetanDay(year: y, month: leap ? -m : m, day: d)
    }

    /// Create from year, month, and day
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> TibetanDay {
        return TibetanDay(year: year, month: month, day: day)
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }

    @available(*, deprecated, renamed: "day")
    public func getDay() -> Int { day }

    @available(*, deprecated, renamed: "isLeapMonth")
    public func isInLeapMonth() -> Bool { isLeapMonth }

    @available(*, deprecated, renamed: "monthWithLeap")
    public func getMonthWithLeap() -> Int { monthWithLeap }

    @available(*, deprecated, renamed: "rabByungMonth")
    public func getTibetanMonth() -> RabByungMonth? { rabByungMonth }

    @available(*, deprecated, renamed: "tibetanYear")
    public func getTibetanYear() -> TibetanYear? { tibetanYear }
}
