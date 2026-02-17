import Foundation

/// 年柱 (SixtyCycle Year)
/// Represents a year in the SixtyCycle system
public final class SixtyCycleYear: AbstractCulture {
    public let year: Int
    public let sixtyCycle: SixtyCycle

    /// Initialize with year
    /// - Parameter year: The year
    public init(year: Int) {
        self.year = year
        var index = (year - 4) % 60
        if index < 0 { index += 60 }
        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }
    public var zodiac: Zodiac { Zodiac.fromIndex(sixtyCycle.earthBranch.index) }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
    }

    /// Get next SixtyCycleYear
    /// - Parameter n: Number of years to advance
    /// - Returns: Next SixtyCycleYear
    public func next(_ n: Int) -> SixtyCycleYear {
        return SixtyCycleYear(year: year + n)
    }

    /// Create from year
    /// - Parameter year: The year
    /// - Returns: SixtyCycleYear instance
    public static func fromYear(_ year: Int) -> SixtyCycleYear {
        return SixtyCycleYear(year: year)
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "zodiac")
    public func getZodiac() -> Zodiac { zodiac }
}
