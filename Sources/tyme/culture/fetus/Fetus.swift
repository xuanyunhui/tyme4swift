import Foundation

/// 胎神 (Fetus God)
/// The deity that protects the fetus in Chinese tradition
/// Position changes daily based on the SixtyCycle
public final class Fetus: AbstractCulture {
    /// Fetus god positions for each SixtyCycle day
    public static let POSITIONS = [
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床",
        "门", "碓磨", "厨灶", "仓库", "房床"
    ]

    /// Fetus god directions for each SixtyCycle day
    public static let DIRECTIONS = [
        "外正东", "外正东", "外正南", "外正南", "外正南",
        "外正南", "外正西", "外正西", "外正西", "外正西",
        "外正北", "外正北", "外正北", "外正北", "外正东",
        "外正东", "外正东", "外正东", "外正南", "外正南",
        "外正南", "外正南", "外正西", "外正西", "外正西",
        "外正西", "外正北", "外正北", "外正北", "外正北",
        "房内东", "房内东", "房内南", "房内南", "房内南",
        "房内南", "房内西", "房内西", "房内西", "房内西",
        "房内北", "房内北", "房内北", "房内北", "房内东",
        "房内东", "房内东", "房内东", "房内南", "房内南",
        "房内南", "房内南", "房内西", "房内西", "房内西",
        "房内西", "房内北", "房内北", "房内北", "房内北"
    ]

    private let sixtyCycleIndex: Int

    /// Initialize with SixtyCycle index
    /// - Parameter sixtyCycleIndex: SixtyCycle index (0-59)
    public init(sixtyCycleIndex: Int) {
        var index = sixtyCycleIndex % 60
        if index < 0 { index += 60 }
        self.sixtyCycleIndex = index
        super.init()
    }

    /// Get name (position + direction)
    /// - Returns: Fetus god name
    public override func getName() -> String {
        return "\(getPosition())\(getDirection())"
    }

    /// Get position
    /// - Returns: Position name
    public func getPosition() -> String {
        return Fetus.POSITIONS[sixtyCycleIndex]
    }

    /// Get direction
    /// - Returns: Direction name
    public func getDirection() -> String {
        return Fetus.DIRECTIONS[sixtyCycleIndex]
    }

    /// Get SixtyCycle index
    /// - Returns: SixtyCycle index
    public func getSixtyCycleIndex() -> Int {
        return sixtyCycleIndex
    }

    /// Create from SixtyCycle
    /// - Parameter sixtyCycle: SixtyCycle instance
    /// - Returns: Fetus instance
    public static func fromSixtyCycle(_ sixtyCycle: SixtyCycle) -> Fetus {
        return Fetus(sixtyCycleIndex: sixtyCycle.getIndex())
    }

    /// Create from SixtyCycle index
    /// - Parameter index: SixtyCycle index
    /// - Returns: Fetus instance
    public static func fromIndex(_ index: Int) -> Fetus {
        return Fetus(sixtyCycleIndex: index)
    }
}
