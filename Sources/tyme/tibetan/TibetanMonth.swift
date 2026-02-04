import Foundation

/// 藏历月 (Tibetan Month)
/// Represents a month in the Tibetan calendar
public final class TibetanMonth: AbstractCulture {
    /// Month names (藏历月名称)
    public static let NAMES = [
        "神变月", "苦行月", "具香月", "萨嘎月", "作净月", "明净月",
        "具醉月", "具贤月", "天降月", "持众月", "庄严月", "满意月"
    ]

    private let year: Int
    private let month: Int
    private let isLeap: Bool

    /// Initialize with year and month
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12, negative for leap month)
    public init(year: Int, month: Int) {
        self.year = year
        self.isLeap = month < 0
        self.month = abs(month)
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

    /// Check if leap month
    /// - Returns: true if leap month
    public func isLeapMonth() -> Bool {
        return isLeap
    }

    /// Get month with leap indicator
    /// - Returns: Month value (negative for leap)
    public func getMonthWithLeap() -> Int {
        return isLeap ? -month : month
    }

    /// Get name
    /// - Returns: Month name
    public override func getName() -> String {
        let prefix = isLeap ? "闰" : ""
        return prefix + TibetanMonth.NAMES[month - 1]
    }

    /// Get Tibetan year
    /// - Returns: TibetanYear instance
    public func getTibetanYear() -> TibetanYear {
        return TibetanYear.fromYear(year)
    }

    /// Get next Tibetan month
    /// - Parameter n: Number of months to advance
    /// - Returns: Next TibetanMonth instance
    public func next(_ n: Int) -> TibetanMonth {
        var m = month + n
        var y = year
        while m > 12 {
            m -= 12
            y += 1
        }
        while m < 1 {
            m += 12
            y -= 1
        }
        return TibetanMonth(year: y, month: m)
    }

    /// Create from year and month
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12, negative for leap)
    /// - Returns: TibetanMonth instance
    public static func fromYm(_ year: Int, _ month: Int) -> TibetanMonth {
        return TibetanMonth(year: year, month: month)
    }
}
