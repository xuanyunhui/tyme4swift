import Foundation

/// 胎元 (ChildLimit) - Fetal Limit
/// 根据八字计算的胎元信息
public final class ChildLimit {
    public let stem: HeavenStem
    public let branch: EarthBranch
    
    /// 初始化胎元
    /// - Parameters:
    ///   - monthStem: 月干
    ///   - monthBranch: 月支
    public init(monthStem: HeavenStem, monthBranch: EarthBranch) {
        // 胎元 = 月干顺推3个月，月支顺推3个月
        self.stem = monthStem.next(3)
        self.branch = monthBranch.next(3)
    }
    
    public func getStemName() -> String {
        stem.getName()
    }
    
    public func getBranchName() -> String {
        branch.getName()
    }
    
    public func getChildLimitString() -> String {
        return "\(getStemName())\(getBranchName())"
    }
    
    /// Get age at which child limit takes effect
    public func getAge() -> Int {
        // 胎元到出生 = 10 个月
        return 0
    }
}
