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

    private let year: Int
    private let month: Int
    private let day: Int
    private let isLeapMonth: Bool

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

    /// Get year
    /// - Returns: Year value
    public func getYear() -> Int {
        return year
    }

    /// Get month
    /// - Returns: Month value (1-12)
    public func getMonth() -> Int {
        return month
    }

    /// Get day
    /// - Returns: Day value (1-30)
    public func getDay() -> Int {
        return day
    }

    /// Check if in leap month
    /// - Returns: true if in leap month
    public func isInLeapMonth() -> Bool {
        return isLeapMonth
    }

    /// Get month with leap indicator
    /// - Returns: Month value (negative for leap)
    public func getMonthWithLeap() -> Int {
        return isLeapMonth ? -month : month
    }

    /// Get name
    /// - Returns: Day name
    public override func getName() -> String {
        return TibetanDay.NAMES[day - 1]
    }

    /// Get Tibetan month
    /// - Returns: TibetanMonth instance
    public func getTibetanMonth() -> TibetanMonth {
        return try! TibetanMonth.fromYm(year, getMonthWithLeap())
    }

    /// Get Tibetan year
    /// - Returns: TibetanYear instance
    public func getTibetanYear() -> TibetanYear {
        return TibetanYear.fromYear(year)
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
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12, negative for leap)
    ///   - day: The day (1-30)
    /// - Returns: TibetanDay instance
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> TibetanDay {
        return TibetanDay(year: year, month: month, day: day)
    }
}
