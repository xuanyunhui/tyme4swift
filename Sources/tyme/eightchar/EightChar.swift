import Foundation

/// 八字 (EightChar) - Birth Destiny System
/// 由年月日时的天干地支组成的八个字符
public final class EightChar {
    public let yearStem: HeavenStem
    public let yearBranch: EarthBranch
    public let monthStem: HeavenStem
    public let monthBranch: EarthBranch
    public let dayStem: HeavenStem
    public let dayBranch: EarthBranch
    public let hourStem: HeavenStem
    public let hourBranch: EarthBranch
    
    public let solarYear: Int
    public let solarMonth: Int
    public let solarDay: Int
    public let solarHour: Int
    
    /// 初始化八字
    /// - Parameters:
    ///   - year: 公历年份
    ///   - month: 公历月份 (1-12)
    ///   - day: 公历日期 (1-31)
    ///   - hour: 小时 (0-23)
    public init(year: Int, month: Int, day: Int, hour: Int) {
        self.solarYear = year
        self.solarMonth = month
        self.solarDay = day
        self.solarHour = hour
        
        // Calculate lunar date from solar date
        let lunarYear = Self.getLunarYear(solarYear: year, solarMonth: month, solarDay: day)
        let lunarMonth = Self.getLunarMonth(solarYear: year, solarMonth: month, solarDay: day)
        
        // Year stem and branch (based on lunar year)
        self.yearStem = HeavenStem.fromIndex((lunarYear + 6) % 10)
        self.yearBranch = EarthBranch.fromIndex((lunarYear + 8) % 12)
        
        // Month stem and branch (based on solar month and lunar adjustment)
        let monthIndex = month - 1
        self.monthStem = HeavenStem.fromIndex((lunarYear * 12 + monthIndex + 6) % 10)
        self.monthBranch = EarthBranch.fromIndex((lunarMonth - 1 + 2) % 12)
        
        // Day stem and branch (based on day calculations)
        self.dayStem = HeavenStem.fromIndex((day + 4) % 10)
        self.dayBranch = EarthBranch.fromIndex((day + 4) % 12)
        
        // Hour stem and branch (based on day stem and hour)
        let hourIndex = (hour + 1) / 2
        self.hourStem = HeavenStem.fromIndex((yearStem.index * 2 + hourIndex) % 10)
        self.hourBranch = EarthBranch.fromIndex(hourIndex % 12)
    }
    
    // MARK: - Properties
    
    public var yearZodiac: String { yearBranch.zodiac }

    @available(*, deprecated, renamed: "yearZodiac")
    public func getYearZodiac() -> String { yearZodiac }

    @available(*, deprecated, renamed: "solarYear")
    public func getSolarYear() -> Int { solarYear }

    @available(*, deprecated, renamed: "solarMonth")
    public func getSolarMonth() -> Int { solarMonth }

    @available(*, deprecated, renamed: "solarDay")
    public func getSolarDay() -> Int { solarDay }

    @available(*, deprecated, renamed: "solarHour")
    public func getSolarHour() -> Int { solarHour }
    
    public func getYearStemName() -> String {
        yearStem.getName()
    }
    
    public func getYearBranchName() -> String {
        yearBranch.getName()
    }
    
    public func getMonthStemName() -> String {
        monthStem.getName()
    }
    
    public func getMonthBranchName() -> String {
        monthBranch.getName()
    }
    
    public func getDayStemName() -> String {
        dayStem.getName()
    }
    
    public func getDayBranchName() -> String {
        dayBranch.getName()
    }
    
    public func getHourStemName() -> String {
        hourStem.getName()
    }
    
    public func getHourBranchName() -> String {
        hourBranch.getName()
    }
    
    /// Get complete eight character string
    public func getEightCharString() -> String {
        return "\(getYearStemName())\(getYearBranchName())" +
               "\(getMonthStemName())\(getMonthBranchName())" +
               "\(getDayStemName())\(getDayBranchName())" +
               "\(getHourStemName())\(getHourBranchName())"
    }
    
    // MARK: - Helper Methods
    
    private static func getLunarYear(solarYear: Int, solarMonth: Int, solarDay: Int) -> Int {
        // Simplified: lunar year is same as solar year for most dates
        if solarMonth == 1 && solarDay < 21 {
            return solarYear - 1
        }
        return solarYear
    }
    
    private static func getLunarMonth(solarYear: Int, solarMonth: Int, solarDay: Int) -> Int {
        // Simplified: direct mapping for demonstration
        return solarMonth
    }
}
