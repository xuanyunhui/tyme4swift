import Foundation

/// 彭祖百忌 (Pengzu Taboos / Pengzu's Hundred Taboos)
///
/// 彭祖百忌是中国传统的择日禁忌系统，相传由彭祖所创。
/// 根据每日的天干地支组合，判断当日的宜忌事项。
/// 每个天干和地支都有对应的禁忌，组合起来形成当日的完整禁忌。
///
/// Pengzu's Hundred Taboos is a traditional Chinese day-selection taboo system,
/// said to have been created by Pengzu (a legendary figure known for longevity).
/// Based on the combination of Heaven Stem and Earth Branch for each day,
/// it determines the taboo activities for that day.
///
/// Example:
/// - 甲子日: "甲不开仓财物耗散 子不问卜自惹祸殃"
/// - 乙丑日: "乙不栽植千株不长 丑不冠带主不还乡"
public final class PengZu: AbstractCulture {
    /// 天干彭祖百忌 (Heaven Stem taboo)
    private let pengZuHeavenStem: PengZuHeavenStem

    /// 地支彭祖百忌 (Earth Branch taboo)
    private let pengZuEarthBranch: PengZuEarthBranch

    /// Initialize from SixtyCycle
    /// - Parameter sixtyCycle: The sixty-cycle (干支) for the day
    public init(_ sixtyCycle: SixtyCycle) {
        self.pengZuHeavenStem = PengZuHeavenStem.fromIndex(sixtyCycle.getHeavenStem().getIndex())
        self.pengZuEarthBranch = PengZuEarthBranch.fromIndex(sixtyCycle.getEarthBranch().getIndex())
        super.init()
    }

    /// Initialize from Heaven Stem and Earth Branch indices
    /// - Parameters:
    ///   - heavenStemIndex: Heaven Stem index (0-9)
    ///   - earthBranchIndex: Earth Branch index (0-11)
    public init(heavenStemIndex: Int, earthBranchIndex: Int) {
        self.pengZuHeavenStem = PengZuHeavenStem.fromIndex(heavenStemIndex)
        self.pengZuEarthBranch = PengZuEarthBranch.fromIndex(earthBranchIndex)
        super.init()
    }

    /// Create from SixtyCycle
    /// - Parameter sixtyCycle: The sixty-cycle (干支) for the day
    /// - Returns: PengZu instance
    public static func fromSixtyCycle(_ sixtyCycle: SixtyCycle) -> PengZu {
        return PengZu(sixtyCycle)
    }

    /// Get the name (combined taboos)
    /// - Returns: Combined Heaven Stem and Earth Branch taboos
    public override func getName() -> String {
        return "\(pengZuHeavenStem) \(pengZuEarthBranch)"
    }

    /// Get the Heaven Stem taboo
    /// - Returns: PengZuHeavenStem instance
    public func getPengZuHeavenStem() -> PengZuHeavenStem {
        return pengZuHeavenStem
    }

    /// Get the Earth Branch taboo
    /// - Returns: PengZuEarthBranch instance
    public func getPengZuEarthBranch() -> PengZuEarthBranch {
        return pengZuEarthBranch
    }

    /// Get the Heaven Stem taboo text
    /// - Returns: Heaven Stem taboo description
    public func getHeavenStemTaboo() -> String {
        return pengZuHeavenStem.getName()
    }

    /// Get the Earth Branch taboo text
    /// - Returns: Earth Branch taboo description
    public func getEarthBranchTaboo() -> String {
        return pengZuEarthBranch.getName()
    }

    /// Get all taboos as an array
    /// - Returns: Array containing both Heaven Stem and Earth Branch taboos
    public func getTaboos() -> [String] {
        return [pengZuHeavenStem.getName(), pengZuEarthBranch.getName()]
    }
}
