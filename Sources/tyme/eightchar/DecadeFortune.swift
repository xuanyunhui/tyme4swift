import Foundation

/// 旬空 (DecadeFortune) - Decade fortune / Void period details
/// 管理旬空周期和相关属性
public final class DecadeFortune {
    public let stem: HeavenStem
    public let branch: EarthBranch
    public let voidStart: Int
    public let voidEnd: Int

    /// 初始化旬空
    /// - Parameters:
    ///   - stem: 天干
    ///   - branch: 地支
    ///   - voidStart: 旬空开始位置
    ///   - voidEnd: 旬空结束位置
    public init(stem: HeavenStem, branch: EarthBranch, voidStart: Int = 0, voidEnd: Int = 0) {
        self.stem = stem
        self.branch = branch
        self.voidStart = voidStart
        self.voidEnd = voidEnd
    }

    public func getStemName() -> String {
        stem.getName()
    }

    public func getBranchName() -> String {
        branch.getName()
    }

    public func getDecadeString() -> String {
        return "\(getStemName())\(getBranchName())"
    }

    public func getVoidRange() -> String {
        return "\(voidStart)-\(voidEnd)"
    }

    /// Check if a position is within void period
    public func isVoid(_ position: Int) -> Bool {
        return position >= voidStart && position <= voidEnd
    }
}
