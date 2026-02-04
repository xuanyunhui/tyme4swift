import Foundation

/// 财神方位 (Wealth God Direction)
/// The direction of the Wealth God based on the day stem
public final class WealthGod: AbstractCulture {
    /// Wealth god directions for each heaven stem
    /// 甲乙在东南, 丙丁在正东, 戊己在正北, 庚辛在正南, 壬癸在正西
    private static let DIRECTIONS = ["东南", "东南", "东", "东", "北", "北", "南", "南", "西", "西"]

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
        return WealthGod.DIRECTIONS[heavenStemIndex]
    }

    /// Get direction
    /// - Returns: Direction instance
    public func getDirection() -> Direction {
        return Direction.fromName(getName())
    }

    /// Create from heaven stem
    /// - Parameter heavenStem: Heaven stem
    /// - Returns: WealthGod instance
    public static func fromHeavenStem(_ heavenStem: HeavenStem) -> WealthGod {
        return WealthGod(heavenStemIndex: heavenStem.getIndex())
    }

    /// Create from day SixtyCycle
    /// - Parameter daySixtyCycle: Day SixtyCycle
    /// - Returns: WealthGod instance
    public static func fromDaySixtyCycle(_ daySixtyCycle: SixtyCycle) -> WealthGod {
        return WealthGod(heavenStemIndex: daySixtyCycle.getHeavenStem().getIndex())
    }
}
