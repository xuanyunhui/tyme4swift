import Foundation

/// 年柱 (SixtyCycle Year)
/// Represents a year in the SixtyCycle system
public final class SixtyCycleYear: AbstractCulture {
    private let year: Int
    private let sixtyCycle: SixtyCycle

    /// Initialize with year
    /// - Parameter year: The year
    public init(year: Int) {
        self.year = year
        // Calculate SixtyCycle index for the year
        // Year 4 is 甲子 (index 0)
        var index = (year - 4) % 60
        if index < 0 { index += 60 }
        self.sixtyCycle = SixtyCycle.fromIndex(index)
        super.init()
    }

    /// Get year
    /// - Returns: Year value
    public func getYear() -> Int {
        return year
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

    /// Get Zodiac
    /// - Returns: Zodiac instance
    public func getZodiac() -> Zodiac {
        return Zodiac.fromIndex(sixtyCycle.getEarthBranch().getIndex())
    }

    /// Get next SixtyCycleYear
    /// - Parameter n: Number of years to advance
    /// - Returns: Next SixtyCycleYear
    public func next(_ n: Int) -> SixtyCycleYear {
        return try! SixtyCycleYear(year: year + n)
    }

    /// Create from year
    /// - Parameter year: The year
    /// - Returns: SixtyCycleYear instance
    public static func fromYear(_ year: Int) -> SixtyCycleYear {
        return SixtyCycleYear(year: year)
    }
}
