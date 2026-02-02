import Foundation

/// 阳贵神方位 (Yang Noble God Direction)
/// The direction of the Yang Noble God based on the day stem
public final class YangNobleGod: AbstractCulture {
    /// Yang noble god directions for each heaven stem
    private static let DIRECTIONS = ["西南", "东北", "正西", "西北", "东北", "正北", "西南", "正东", "正南", "东南"]

    private let heavenStemIndex: Int

    /// Initialize with heaven stem index
    /// - Parameter heavenStemIndex: Heaven stem index (0-9)
    public init(heavenStemIndex: Int) {
        var i = heavenStemIndex % 10
        if i < 0 { i += 10 }
        self.heavenStemIndex = i
        super.init()
    }

    /// Get name (direction)
    /// - Returns: Direction name
    public override func getName() -> String {
        return YangNobleGod.DIRECTIONS[heavenStemIndex]
    }

    /// Get direction
    /// - Returns: Direction instance
    public func getDirection() -> Direction {
        return Direction.fromName(getName())
    }

    /// Create from heaven stem
    /// - Parameter heavenStem: Heaven stem
    /// - Returns: YangNobleGod instance
    public static func fromHeavenStem(_ heavenStem: HeavenStem) -> YangNobleGod {
        return YangNobleGod(heavenStemIndex: heavenStem.getIndex())
    }

    /// Create from day SixtyCycle
    /// - Parameter daySixtyCycle: Day SixtyCycle
    /// - Returns: YangNobleGod instance
    public static func fromDaySixtyCycle(_ daySixtyCycle: SixtyCycle) -> YangNobleGod {
        return YangNobleGod(heavenStemIndex: daySixtyCycle.getHeavenStem().getIndex())
    }
}
