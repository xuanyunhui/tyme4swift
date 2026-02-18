import Foundation

/// Lunar流派1童限计算（按天数和时辰数计算，3天1年，1天4个月，1时辰10天）
public final class LunarSect1ChildLimitProvider: ChildLimitProvider {
    public init() {}

    public func getInfo(birthTime: SolarTime, term: SolarTerm) -> ChildLimitInfo {
        let termTime = term.julianDay.solarTime
        var end = termTime
        var start = birthTime
        if birthTime.isAfter(termTime) {
            end = birthTime
            start = termTime
        }
        let endTimeZhiIndex = end.hour == 23 ? 11 : (end.hour + 1) / 2
        let startTimeZhiIndex = start.hour == 23 ? 11 : (start.hour + 1) / 2
        // 时辰差
        var hourDiff = endTimeZhiIndex - startTimeZhiIndex
        // 天数差
        var dayDiff = end.solarDay.subtract(start.solarDay)
        if hourDiff < 0 {
            hourDiff += 12
            dayDiff -= 1
        }
        let monthDiff = hourDiff * 10 / 30
        var month = dayDiff * 4 + monthDiff
        let day = hourDiff * 10 - monthDiff * 30
        let year = month / 12
        month -= year * 12

        return next(birthTime, year, month, day, 0, 0, 0)
    }
}
