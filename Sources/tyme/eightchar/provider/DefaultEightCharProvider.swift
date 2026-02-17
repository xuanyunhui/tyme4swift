import Foundation

/// 默认八字计算提供者 (Default EightChar Provider)
/// Standard calculation method for EightChar
public final class DefaultEightCharProvider: EightCharProvider {
    public init() {}

    /// Get year pillar SixtyCycle
    /// Year pillar changes at Lichun (立春)
    public func getYearSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle {
        // Year pillar is based on the lunar year
        // Year 4 is 甲子 (index 0)
        var y = year
        // Before Lichun, use previous year
        let lichun = SolarTerm.fromIndex(y, 3) // 立春
        let lichunDay = lichun.getSolarDay()
        if month < lichunDay.getMonth() || (month == lichunDay.getMonth() && day < lichunDay.getDay()) {
            y -= 1
        }
        var index = (y - 4) % 60
        if index < 0 { index += 60 }
        return SixtyCycle.fromIndex(index)
    }

    /// Get month pillar SixtyCycle
    /// Month pillar changes at Jie (节)
    public func getMonthSixtyCycle(year: Int, month: Int, day: Int) -> SixtyCycle {
        // Get the year stem to calculate month stem
        let yearSixtyCycle = getYearSixtyCycle(year: year, month: month, day: day)
        let yearStemIndex = yearSixtyCycle.getHeavenStem().getIndex()

        // Determine which solar term month we're in
        var termMonth = month
        // Check if we're before the Jie of this month
        let jieIndex = (month - 1) * 2 + 3 // 立春=3, 惊蛰=5, etc.
        if jieIndex < 24 {
            let jie = SolarTerm.fromIndex(year, jieIndex)
            let jieDay = jie.getSolarDay()
            if day < jieDay.getDay() {
                termMonth = month - 1
                if termMonth < 1 { termMonth = 12 }
            }
        }

        // Month branch: 寅月(1月)=2, 卯月(2月)=3, etc.
        let monthBranchIndex = (termMonth + 1) % 12

        // Month stem = (year stem % 5) * 2 + month branch - 2
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
        let solarDay = try! SolarDay.fromYmd(year, month, day)
        let jd = solarDay.getJulianDay()
        let offset = Int(jd.getDay() + 0.5) + 49
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
        let dayStemIndex = daySixtyCycle.getHeavenStem().getIndex()

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
