import Foundation

/// 藏历月 (Tibetan Month)
/// Represents a month in the Tibetan calendar
public final class TibetanMonth: AbstractCulture {
    /// Month names (藏历月名称)
    public static let NAMES = [
        "神变月", "苦行月", "具香月", "萨嘎月", "作净月", "明净月",
        "具醉月", "具贤月", "天降月", "持众月", "庄严月", "满意月"
    ]

    public let year: Int
    public let month: Int
    public let isLeap: Bool

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

    public var monthWithLeap: Int { isLeap ? -month : month }

    public var tibetanYear: TibetanYear { try! TibetanYear.fromYear(year) }

    /// Get name
    /// - Returns: Month name
    public override func getName() -> String {
        let prefix = isLeap ? "闰" : ""
        return prefix + TibetanMonth.NAMES[month - 1]
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

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }

    @available(*, deprecated, renamed: "isLeap")
    public func isLeapMonth() -> Bool { isLeap }

    @available(*, deprecated, renamed: "monthWithLeap")
    public func getMonthWithLeap() -> Int { monthWithLeap }

    @available(*, deprecated, renamed: "tibetanYear")
    public func getTibetanYear() -> TibetanYear { tibetanYear }
}
