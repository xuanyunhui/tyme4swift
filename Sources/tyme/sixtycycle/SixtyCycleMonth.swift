import Foundation

/// 月柱 (SixtyCycle Month)
/// Represents a month in the SixtyCycle system
public final class SixtyCycleMonth: AbstractCulture {
    private let year: Int
    private let month: Int
    private let sixtyCycle: SixtyCycle

    /// Initialize with year and month
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12)
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month

        // Calculate SixtyCycle for month
        // Based on year stem and month
        let yearStemIndex = SixtyCycleYear(year: year).getHeavenStem().getIndex()
        // Month stem = (year stem % 5) * 2 + month index
        let monthStemIndex = (yearStemIndex % 5) * 2 + (month - 1) + 2
        // Month branch starts from 寅 (index 2) for first month
        let monthBranchIndex = (month - 1 + 2) % 12

        let stemIndex = monthStemIndex % 10
        self.sixtyCycle = SixtyCycle.fromIndex(stemIndex * 12 + monthBranchIndex - (stemIndex * 12 + monthBranchIndex) / 60 * 60)
        super.init()
    }

    /// Get year
    /// - Returns: Year value
    public func getYear() -> Int {
        return year
    }

    /// Get month
    /// - Returns: Month value (1-12)
    public func getMonth() -> Int {
        return month
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

    /// Get next SixtyCycleMonth
    /// - Parameter n: Number of months to advance
    /// - Returns: Next SixtyCycleMonth
    public func next(_ n: Int) -> SixtyCycleMonth {
        var m = month + n
        var y = year
        while m > 12 {
            m -= 12
            y += 1
        }
        while m < 1 {
            m += 12
            y -= 1
        }
        return SixtyCycleMonth(year: y, month: m)
    }

    /// Create from year and month
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12)
    /// - Returns: SixtyCycleMonth instance
    public static func fromYm(_ year: Int, _ month: Int) -> SixtyCycleMonth {
        return SixtyCycleMonth(year: year, month: month)
    }
}
