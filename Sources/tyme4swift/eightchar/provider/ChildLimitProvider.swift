import Foundation

/// 童限计算提供者协议 (ChildLimit Provider Protocol)
/// Protocol for different ChildLimit calculation methods
public protocol ChildLimitProvider {
    /// Calculate child limit info
    /// - Parameters:
    ///   - gender: Gender (male/female)
    ///   - year: Birth year
    ///   - month: Birth month
    ///   - day: Birth day
    ///   - hour: Birth hour
    /// - Returns: ChildLimitInfo with years, months, days
    func getChildLimit(gender: Gender, year: Int, month: Int, day: Int, hour: Int) -> ChildLimitInfo
}

/// 童限信息 (ChildLimit Info)
/// Contains the calculated child limit period
public struct ChildLimitInfo {
    public let years: Int
    public let months: Int
    public let days: Int
    public let startYear: Int
    public let startMonth: Int
    public let startDay: Int

    public init(years: Int, months: Int, days: Int, startYear: Int, startMonth: Int, startDay: Int) {
        self.years = years
        self.months = months
        self.days = days
        self.startYear = startYear
        self.startMonth = startMonth
        self.startDay = startDay
    }

    /// Get total days
    public func getTotalDays() -> Int {
        return years * 365 + months * 30 + days
    }
}
