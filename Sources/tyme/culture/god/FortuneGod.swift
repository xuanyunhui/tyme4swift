import Foundation

/// 福神方位 (Fortune God Direction)
/// The direction of the Fortune God based on the day stem
public final class FortuneGod: AbstractCulture {
    /// Fortune god directions for each heaven stem
    private static let DIRECTIONS = ["东南", "东北", "正北", "西北", "西南", "西南", "西北", "正北", "东北", "东南"]

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
        return FortuneGod.DIRECTIONS[heavenStemIndex]
    }

    /// Get direction
    /// - Returns: Direction instance
    public func getDirection() -> Direction {
        return try! Direction.fromName(getName())
    }

    /// Create from heaven stem
    /// - Parameter heavenStem: Heaven stem
    /// - Returns: FortuneGod instance
    public static func fromHeavenStem(_ heavenStem: HeavenStem) -> FortuneGod {
        return FortuneGod(heavenStemIndex: heavenStem.getIndex())
    }

    /// Create from day SixtyCycle
    /// - Parameter daySixtyCycle: Day SixtyCycle
    /// - Returns: FortuneGod instance
    public static func fromDaySixtyCycle(_ daySixtyCycle: SixtyCycle) -> FortuneGod {
        return FortuneGod(heavenStemIndex: daySixtyCycle.getHeavenStem().getIndex())
    }
}
