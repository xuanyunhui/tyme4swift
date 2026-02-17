import Foundation

/// 时柱 (SixtyCycle Hour)
/// Represents an hour in the SixtyCycle system
public final class SixtyCycleHour: AbstractCulture {
    public let solarTime: SolarTime
    public let sixtyCycle: SixtyCycle

    /// Initialize with SolarTime
    /// - Parameter solarTime: The solar time
    public init(solarTime: SolarTime) {
        self.solarTime = solarTime

        let hour = solarTime.hour
        let hourIndex = (hour + 1) / 2 % 12

        var daySixtyCycle = SixtyCycleDay(solarDay: solarTime.solarDay).sixtyCycle
        if hour >= 23 {
            daySixtyCycle = daySixtyCycle.next(1)
        }
        let dayStemIndex = daySixtyCycle.heavenStem.index
        let hourStemIndex = (dayStemIndex % 5) * 2 + hourIndex
        var index = (hourStemIndex % 10) * 12 + hourIndex
        index = index % 60

        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    /// Initialize with year, month, day, hour, minute, second
    public convenience init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) throws {
        self.init(solarTime: try SolarTime.fromYmdHms(year, month, day, hour, minute, second))
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }
    public var indexInDay: Int { (solarTime.hour + 1) / 2 % 12 }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
    }

    /// Get next SixtyCycleHour
    public func next(_ n: Int) -> SixtyCycleHour {
        var h = solarTime.hour + n * 2
        var d = solarTime.solarDay

        while h >= 24 {
            h -= 24
            d = d.next(1)
        }
        while h < 0 {
            h += 24
            d = d.next(-1)
        }

        return SixtyCycleHour(solarTime: try! SolarTime.fromYmdHms(d.year, d.month, d.day, h, solarTime.minute, solarTime.second))
    }

    /// Create from SolarTime
    public static func fromSolarTime(_ solarTime: SolarTime) -> SixtyCycleHour {
        return SixtyCycleHour(solarTime: solarTime)
    }

    /// Create from year, month, day, hour, minute, second
    public static func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> SixtyCycleHour {
        return try SixtyCycleHour(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

    @available(*, deprecated, renamed: "solarTime")
    public func getSolarTime() -> SolarTime { solarTime }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "indexInDay")
    public func getIndexInDay() -> Int { indexInDay }
}
