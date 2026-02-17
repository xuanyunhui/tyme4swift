import Foundation

/// 身宫 (Body Palace)
/// The body palace in BaZi astrology
public final class BodyPalace: AbstractCulture {
    public let sixtyCycle: SixtyCycle

    /// Initialize with SixtyCycle
    /// - Parameter sixtyCycle: The SixtyCycle of the body palace
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

    /// Create from year and hour
    /// - Parameters:
    ///   - yearBranch: Year earth branch
    ///   - hourBranch: Hour earth branch
    /// - Returns: BodyPalace instance
    public static func fromYearHour(_ yearBranch: EarthBranch, _ hourBranch: EarthBranch) -> BodyPalace {
        // Body palace calculation: year branch + hour branch - 2
        var branchIndex = yearBranch.index + hourBranch.index - 2
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

        return BodyPalace(sixtyCycle: SixtyCycle.fromIndex(index))
    }
}
