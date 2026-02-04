import Foundation

/// 身宫 (Body Palace)
/// The body palace in BaZi astrology
public final class BodyPalace: AbstractCulture {
    private let sixtyCycle: SixtyCycle

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

    /// Get SixtyCycle
    /// - Returns: SixtyCycle instance
    public func getSixtyCycle() -> SixtyCycle {
        return sixtyCycle
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

    /// Create from year and hour
    /// - Parameters:
    ///   - yearBranch: Year earth branch
    ///   - hourBranch: Hour earth branch
    /// - Returns: BodyPalace instance
    public static func fromYearHour(_ yearBranch: EarthBranch, _ hourBranch: EarthBranch) -> BodyPalace {
        // Body palace calculation: year branch + hour branch - 2
        var branchIndex = yearBranch.getIndex() + hourBranch.getIndex() - 2
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
