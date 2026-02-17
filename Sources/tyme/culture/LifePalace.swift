import Foundation

/// 命宫 (Life Palace)
/// The life palace in BaZi astrology
public final class LifePalace: AbstractCulture {
    public let sixtyCycle: SixtyCycle

    /// Initialize with SixtyCycle
    /// - Parameter sixtyCycle: The SixtyCycle of the life palace
    public init(sixtyCycle: SixtyCycle) {
        self.sixtyCycle = sixtyCycle
        super.init()
    }

    /// Get name
    /// - Returns: SixtyCycle name
    public override func getName() -> String {
        return sixtyCycle.getName()
    }

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    /// Create from year and month
    /// - Parameters:
    ///   - yearBranch: Year earth branch
    ///   - monthBranch: Month earth branch
    /// - Returns: LifePalace instance
    public static func fromYearMonth(_ yearBranch: EarthBranch, _ monthBranch: EarthBranch) -> LifePalace {
        // Life palace calculation: 14 - year branch - month branch
        var branchIndex = 14 - yearBranch.index - monthBranch.index
        while branchIndex < 0 { branchIndex += 12 }
        branchIndex = branchIndex % 12

        // Calculate stem based on year stem
        let stemIndex = branchIndex % 10

        // Calculate SixtyCycle index
        var index = stemIndex
        while index % 12 != branchIndex {
            index += 10
        }
        index = index % 60

        return LifePalace(sixtyCycle: SixtyCycle.fromIndex(index))
    }
}
