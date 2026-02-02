import Foundation

/// 默认童限计算提供者 (Default ChildLimit Provider)
/// Standard calculation method for ChildLimit
public final class DefaultChildLimitProvider: ChildLimitProvider {
    public init() {}

    /// Calculate child limit info
    /// Based on the distance to the nearest solar term
    public func getChildLimit(gender: Gender, year: Int, month: Int, day: Int, hour: Int) -> ChildLimitInfo {
        // Get the year pillar to determine direction
        let provider = DefaultEightCharProvider()
        let yearSixtyCycle = provider.getYearSixtyCycle(year: year, month: month, day: day)
        let yearStemIndex = yearSixtyCycle.getHeavenStem().getIndex()

        // Determine direction: Yang year + Male or Yin year + Female = forward
        let isYangYear = yearStemIndex % 2 == 0
        let isMale = gender.isMale
        let isForward = (isYangYear && isMale) || (!isYangYear && !isMale)

        // Find the nearest solar term
        let solarDay = SolarDay.fromYmd(year, month, day)
        _ = solarDay.getJulianDay()

        // Get current solar term index
        var termIndex = (month - 1) * 2
        if isForward {
            // Find next Jie (节)
            termIndex = termIndex + 3 // Next Jie
            if termIndex >= 24 { termIndex -= 24 }
        } else {
            // Find previous Jie (节)
            termIndex = termIndex + 1 // Previous Jie
            if termIndex < 0 { termIndex += 24 }
        }

        // Get the target solar term
        let targetYear = isForward ? year : (termIndex > (month - 1) * 2 ? year - 1 : year)
        let targetTerm = SolarTerm.fromIndex(targetYear, termIndex)
        let targetDay = targetTerm.getSolarDay()

        // Calculate days difference
        var daysDiff = abs(solarDay.subtract(targetDay))

        // Convert to years, months, days (3 days = 1 year)
        let years = daysDiff / 3
        daysDiff = daysDiff % 3
        let months = daysDiff * 4  // Each day = 4 months
        let days = 0

        // Calculate start date
        let startYear = year + years
        var startMonth = month + months
        let startDay = day
        while startMonth > 12 {
            startMonth -= 12
        }

        return ChildLimitInfo(
            years: years,
            months: months,
            days: days,
            startYear: startYear,
            startMonth: startMonth,
            startDay: startDay
        )
    }
}
