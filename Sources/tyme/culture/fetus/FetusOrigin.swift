import Foundation

/// 胎元 (Fetus Origin)
/// The conception month pillar in BaZi
public final class FetusOrigin: AbstractCulture {
    private let sixtyCycle: SixtyCycle

    /// Initialize with SixtyCycle
    /// - Parameter sixtyCycle: The SixtyCycle of the fetus origin
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

    /// Create from month pillar
    /// The fetus origin is calculated as month pillar + 1 stem + 3 branches
    /// - Parameter monthPillar: The month pillar SixtyCycle
    /// - Returns: FetusOrigin instance
    public static func fromMonthPillar(_ monthPillar: SixtyCycle) -> FetusOrigin {
        // Fetus origin = month stem + 1, month branch + 3
        let stemIndex = (monthPillar.getHeavenStem().getIndex() + 1) % 10
        let branchIndex = (monthPillar.getEarthBranch().getIndex() + 3) % 12

        // Calculate SixtyCycle index
        var index = stemIndex
        while index % 12 != branchIndex {
            index += 10
        }
        index = index % 60

        return FetusOrigin(sixtyCycle: SixtyCycle.fromIndex(index))
    }
}
