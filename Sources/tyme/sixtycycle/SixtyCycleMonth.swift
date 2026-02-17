import Foundation

/// 月柱 (SixtyCycle Month)
/// Represents a month in the SixtyCycle system
public final class SixtyCycleMonth: AbstractCulture {
    public let year: Int
    public let month: Int
    public let sixtyCycle: SixtyCycle

    /// Initialize with year and month
    /// - Parameters:
    ///   - year: The year
    ///   - month: The month (1-12)
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month

        let yearStemIndex = SixtyCycleYear(year: year).heavenStem.index
        let monthStemIndex = (yearStemIndex % 5) * 2 + (month - 1) + 2
        let monthBranchIndex = (month - 1 + 2) % 12
        let stemIndex = monthStemIndex % 10
        self.sixtyCycle = SixtyCycle.fromIndex(stemIndex * 12 + monthBranchIndex - (stemIndex * 12 + monthBranchIndex) / 60 * 60)
        super.init()
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }
    public var naYin: NaYin { NaYin.fromSixtyCycle(sixtyCycle.index) }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
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
    public static func fromYm(_ year: Int, _ month: Int) -> SixtyCycleMonth {
        return SixtyCycleMonth(year: year, month: month)
    }

    @available(*, deprecated, renamed: "year")
    public func getYear() -> Int { year }

    @available(*, deprecated, renamed: "month")
    public func getMonth() -> Int { month }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }
}
