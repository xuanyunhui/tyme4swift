import Foundation

/// 喜神方位 (Joy God Direction)
/// The direction of the Joy God based on the day stem
public final class JoyGod: AbstractCulture {
    /// Joy god directions for each heaven stem
    /// 甲己在艮, 乙庚在乾, 丙辛在坤, 丁壬在离, 戊癸在巽
    private static let DIRECTIONS = ["东北", "西北", "西南", "南", "东南"]

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
        return JoyGod.DIRECTIONS[heavenStemIndex % 5]
    }

    public var direction: Direction {
        guard let d = try? Direction.fromName(getName()) else {
            preconditionFailure("JoyGod: invalid direction lookup")
        }
        return d
    }

    @available(*, deprecated, renamed: "direction")
    public func getDirection() -> Direction { direction }

    /// Create from heaven stem
    /// - Parameter heavenStem: Heaven stem
    /// - Returns: JoyGod instance
    public static func fromHeavenStem(_ heavenStem: HeavenStem) -> JoyGod {
        return JoyGod(heavenStemIndex: heavenStem.index)
    }

    /// Create from day SixtyCycle
    /// - Parameter daySixtyCycle: Day SixtyCycle
    /// - Returns: JoyGod instance
    public static func fromDaySixtyCycle(_ daySixtyCycle: SixtyCycle) -> JoyGod {
        return JoyGod(heavenStemIndex: daySixtyCycle.heavenStem.index)
    }
}
