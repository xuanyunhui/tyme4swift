import Foundation

/// 阴贵神方位 (Yin Noble God Direction)
/// The direction of the Yin Noble God based on the day stem
public final class YinNobleGod: AbstractCulture {
    /// Yin noble god directions for each heaven stem
    private static let DIRECTIONS = ["东北", "西南", "西北", "正西", "正北", "东北", "正东", "西南", "东南", "正南"]

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
        return YinNobleGod.DIRECTIONS[heavenStemIndex]
    }

    /// Get direction
    /// - Returns: Direction instance
    public func getDirection() -> Direction {
        return Direction.fromName(getName())
    }

    /// Create from heaven stem
    /// - Parameter heavenStem: Heaven stem
    /// - Returns: YinNobleGod instance
    public static func fromHeavenStem(_ heavenStem: HeavenStem) -> YinNobleGod {
        return YinNobleGod(heavenStemIndex: heavenStem.getIndex())
    }

    /// Create from day SixtyCycle
    /// - Parameter daySixtyCycle: Day SixtyCycle
    /// - Returns: YinNobleGod instance
    public static func fromDaySixtyCycle(_ daySixtyCycle: SixtyCycle) -> YinNobleGod {
        return YinNobleGod(heavenStemIndex: daySixtyCycle.getHeavenStem().getIndex())
    }
}
