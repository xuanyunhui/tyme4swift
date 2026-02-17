import Foundation

/// 胎元 (Fetus Origin)
/// The conception month pillar in BaZi
public final class FetusOrigin: AbstractCulture {
    public let sixtyCycle: SixtyCycle

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

    public var heavenStem: HeavenStem { sixtyCycle.heavenStem }
    public var earthBranch: EarthBranch { sixtyCycle.earthBranch }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }

    /// Create from month pillar
    /// The fetus origin is calculated as month pillar + 1 stem + 3 branches
    /// - Parameter monthPillar: The month pillar SixtyCycle
    /// - Returns: FetusOrigin instance
    public static func fromMonthPillar(_ monthPillar: SixtyCycle) -> FetusOrigin {
        // Fetus origin = month stem + 1, month branch + 3
        let stemIndex = (monthPillar.heavenStem.index + 1) % 10
        let branchIndex = (monthPillar.earthBranch.index + 3) % 12

        // Calculate SixtyCycle index
        var index = stemIndex
        while index % 12 != branchIndex {
            index += 10
        }
        index = index % 60

        return FetusOrigin(sixtyCycle: SixtyCycle.fromIndex(index))
    }
}
