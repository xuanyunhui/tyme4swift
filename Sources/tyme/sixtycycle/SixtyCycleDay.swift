import Foundation

/// 日柱 (SixtyCycle Day)
/// Represents a day in the SixtyCycle system
public final class SixtyCycleDay: AbstractCulture {
    private let solarDay: SolarDay
    private let sixtyCycle: SixtyCycle

    /// Initialize with SolarDay
    /// - Parameter solarDay: The solar day
    public init(solarDay: SolarDay) {
        self.solarDay = solarDay
        // Calculate SixtyCycle for day based on Julian Day
        let jd = solarDay.getJulianDay()
        let offset = Int(jd.getDay() + 0.5) + 49
        var index = offset % 60
        if index < 0 { index += 60 }
        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    /// Initialize with year, month, day
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month
    ///   - day: The day
    public convenience init(year: Int, month: Int, day: Int) {
        self.init(solarDay: SolarDay(year: year, month: month, day: day))
    }

    /// Get SolarDay
    /// - Returns: SolarDay instance
    public func getSolarDay() -> SolarDay {
        return solarDay
    }

    /// Get SixtyCycle
    /// - Returns: SixtyCycle instance
    public func getSixtyCycle() -> SixtyCycle {
        return sixtyCycle
    }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
    }

    /// Get HeavenStem
    /// - Returns: HeavenStem instance
    public func getHeavenStem() -> HeavenStem {
        return sixtyCycle.getHeavenStem()
    }

    /// Get EarthBranch
    /// - Returns: EarthBranch instance
    public func getEarthBranch() -> EarthBranch {
        return sixtyCycle.getEarthBranch()
    }

    /// Get NaYin
    /// - Returns: NaYin instance
    public func getNaYin() -> NaYin {
        return NaYin.fromSixtyCycle(sixtyCycle.getIndex())
    }

    /// Get Duty (建除十二值)
    /// - Returns: Duty instance
    public func getDuty() -> Duty {
        // Duty is based on the relationship between month branch and day branch
        // Month branch index: 寅月(1月) = 2, 卯月(2月) = 3, etc.
        let month = solarDay.getMonth()
        let monthBranchIndex = (month + 1) % 12
        let dayBranchIndex = sixtyCycle.getEarthBranch().getIndex()
        var dutyIndex = (dayBranchIndex - monthBranchIndex) % 12
        if dutyIndex < 0 { dutyIndex += 12 }
        return Duty.fromIndex(dutyIndex)
    }

    /// Get TwentyEightStar (二十八宿)
    /// - Returns: TwentyEightStar instance
    public func getTwentyEightStar() -> TwentyEightStar {
        let jd = solarDay.getJulianDay()
        let offset = Int(jd.getDay() + 0.5) + 11
        var index = offset % 28
        if index < 0 { index += 28 }
        return TwentyEightStar.fromIndex(index)
    }

    /// Get next SixtyCycleDay
    /// - Parameter n: Number of days to advance
    /// - Returns: Next SixtyCycleDay
    public func next(_ n: Int) -> SixtyCycleDay {
        return SixtyCycleDay(solarDay: solarDay.next(n))
    }

    /// Create from SolarDay
    /// - Parameter solarDay: The solar day
    /// - Returns: SixtyCycleDay instance
    public static func fromSolarDay(_ solarDay: SolarDay) -> SixtyCycleDay {
        return SixtyCycleDay(solarDay: solarDay)
    }

    /// Create from year, month, day
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month
    ///   - day: The day
    /// - Returns: SixtyCycleDay instance
    public static func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> SixtyCycleDay {
        return SixtyCycleDay(year: year, month: month, day: day)
    }
}
