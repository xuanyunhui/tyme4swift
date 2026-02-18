import Foundation

/// 大运 (Fortune) - 10-year fortune periods
/// 管理人生中的大运周期
public final class Fortune {
    public let index: Int
    public let stem: HeavenStem
    public let branch: EarthBranch
    public let startAge: Int
    public let endAge: Int

    /// 初始化大运
    /// - Parameters:
    ///   - index: 大运序号 (0-9)
    ///   - stem: 天干
    ///   - branch: 地支
    ///   - startAge: 开始年龄
    public init(index: Int, stem: HeavenStem, branch: EarthBranch, startAge: Int) {
        self.index = index
        self.stem = stem
        self.branch = branch
        self.startAge = startAge
        self.endAge = startAge + 9
    }

    public func getStemName() -> String {
        stem.getName()
    }

    public func getBranchName() -> String {
        branch.getName()
    }

    public func getFortuneString() -> String {
        return "\(getStemName())\(getBranchName())"
    }

    public func getYearRange() -> String {
        return "\(startAge)-\(endAge)"
    }

    /// Check if a given age falls within this fortune period
    public func containsAge(_ age: Int) -> Bool {
        return age >= startAge && age <= endAge
    }
}
