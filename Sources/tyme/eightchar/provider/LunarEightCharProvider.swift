import Foundation

/// 农历八字计算提供者 (Lunar EightChar Provider)
/// Calculation method based on lunar calendar
public final class LunarEightCharProvider: EightCharProvider {
    public init() {}

    /// Get year pillar SixtyCycle based on lunar year
    public func getYearSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle {
        // Get lunar day from solar day
        guard let solarDay = try? SolarDay.fromYmd(year, month, day) else {
            preconditionFailure("LunarEightCharProvider: invalid solar day")
        }
        let lunarDay = solarDay.lunarDay
        let lunarYear = lunarDay.lunarMonth.lunarYear.year

        // Year 4 is 甲子 (index 0)
        var index = (lunarYear - 4) % 60
        if index < 0 { index += 60 }
        return SixtyCycle.fromIndex(index)
    }

    /// Get month pillar SixtyCycle based on lunar month
    public func getMonthSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle {
        // Get lunar day from solar day
        guard let solarDay = try? SolarDay.fromYmd(year, month, day) else {
            preconditionFailure("LunarEightCharProvider: invalid solar day")
        }
        let lunarDay = solarDay.lunarDay
        let lunarMonth = lunarDay.lunarMonth

        // Get year stem
        let yearSixtyCycle = getYearSixtyCycle(year: year, month: month, day: day)
        let yearStemIndex = yearSixtyCycle.heavenStem.index

        // Month branch: 寅月(1月)=2, 卯月(2月)=3, etc.
        let monthBranchIndex = (lunarMonth.month + 1) % 12

        // Month stem = (year stem % 5) * 2 + month branch
        let monthStemIndex = ((yearStemIndex % 5) * 2 + monthBranchIndex) % 10

        // Calculate SixtyCycle index
        var index = monthStemIndex
        while index % 12 != monthBranchIndex {
            index += 10
        }
        index = index % 60

        return SixtyCycle.fromIndex(index)
    }

    /// Get day pillar SixtyCycle
    public func getDaySixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle {
        guard let solarDay = try? SolarDay.fromYmd(year, month, day) else {
            preconditionFailure("LunarEightCharProvider: invalid solar day")
        }
        let jd = solarDay.julianDay
        let offset = Int(jd.value + 0.5) + 49
        var index = offset % 60
        if index < 0 { index += 60 }
        return SixtyCycle.fromIndex(index)
    }

    /// Get hour pillar SixtyCycle
    public func getHourSixtyCycle(year: Int, month: Int, day: Int, hour: Int) -> SixtyCycle {
        // Hour index (0-11, where 0 is 子时 23:00-01:00)
        let hourIndex = (hour + 1) / 2 % 12

        // Get day stem
        var daySixtyCycle = getDaySixtyCycle(year: year, month: month, day: day)
        // If hour >= 23, use next day's stem
        if hour >= 23 {
            daySixtyCycle = daySixtyCycle.next(1)
        }
        let dayStemIndex = daySixtyCycle.heavenStem.index

        // Hour stem = (day stem % 5) * 2 + hour index
        let hourStemIndex = ((dayStemIndex % 5) * 2 + hourIndex) % 10

        // Calculate SixtyCycle index
        var index = hourStemIndex
        while index % 12 != hourIndex {
            index += 10
        }
        index = index % 60

        return SixtyCycle.fromIndex(index)
    }
}
