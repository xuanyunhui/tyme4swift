import Foundation

/// 时柱 (SixtyCycle Hour)
/// Represents an hour in the SixtyCycle system
public final class SixtyCycleHour: AbstractCulture {
    private let solarTime: SolarTime
    private let sixtyCycle: SixtyCycle

    /// Initialize with SolarTime
    /// - Parameter solarTime: The solar time
    public init(solarTime: SolarTime) {
        self.solarTime = solarTime

        // Calculate hour index (0-11, where 0 is 子时 23:00-01:00)
        let hour = solarTime.getHour()
        let hourIndex = (hour + 1) / 2 % 12

        // Get day stem to calculate hour stem
        var daySixtyCycle = SixtyCycleDay(solarDay: solarTime.getSolarDay()).getSixtyCycle()
        // If hour >= 23, use next day's stem
        if hour >= 23 {
            daySixtyCycle = daySixtyCycle.next(1)
        }
        let dayStemIndex = daySixtyCycle.getHeavenStem().getIndex()

        // Hour stem = (day stem % 5) * 2 + hour index
        let hourStemIndex = (dayStemIndex % 5) * 2 + hourIndex

        // Calculate SixtyCycle index
        var index = (hourStemIndex % 10) * 12 + hourIndex
        index = index % 60

        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    /// Initialize with year, month, day, hour, minute, second
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month
    ///   - day: The day
    ///   - hour: The hour
    ///   - minute: The minute
    ///   - second: The second
    public convenience init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        self.init(solarTime: try SolarTime.fromYmdHms(year, month, day, hour, minute, second))
    }

    /// Get SolarTime
    /// - Returns: SolarTime instance
    public func getSolarTime() -> SolarTime {
        return solarTime
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

    /// Get hour index in day (0-11)
    /// - Returns: Hour index
    public func getIndexInDay() -> Int {
        return (solarTime.getHour() + 1) / 2 % 12
    }

    /// Get next SixtyCycleHour
    /// - Parameter n: Number of hours (2-hour periods) to advance
    /// - Returns: Next SixtyCycleHour
    public func next(_ n: Int) -> SixtyCycleHour {
        var h = solarTime.getHour() + n * 2
        var d = solarTime.getSolarDay()

        while h >= 24 {
            h -= 24
            d = d.next(1)
        }
        while h < 0 {
            h += 24
            d = d.next(-1)
        }

        return SixtyCycleHour(solarTime: try! SolarTime.fromYmdHms(d.getYear(), d.getMonth(), d.getDay(), h, solarTime.getMinute(), solarTime.getSecond()))
    }

    /// Create from SolarTime
    /// - Parameter solarTime: The solar time
    /// - Returns: SixtyCycleHour instance
    public static func fromSolarTime(_ solarTime: SolarTime) -> SixtyCycleHour {
        return SixtyCycleHour(solarTime: solarTime)
    }

    /// Create from year, month, day, hour, minute, second
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month
    ///   - day: The day
    ///   - hour: The hour
    ///   - minute: The minute
    ///   - second: The second
    /// - Returns: SixtyCycleHour instance
    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> SixtyCycleHour {
        return try SixtyCycleHour(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
}
