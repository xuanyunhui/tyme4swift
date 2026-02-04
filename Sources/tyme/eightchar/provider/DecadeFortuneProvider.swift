import Foundation

/// 大运计算提供者协议 (DecadeFortune Provider Protocol)
/// Protocol for different DecadeFortune calculation methods
public protocol DecadeFortuneProvider {
    /// Get decade fortunes
    /// - Parameters:
    ///   - gender: Gender (male/female)
    ///   - year: Birth year
    ///   - month: Birth month
    ///   - day: Birth day
    ///   - hour: Birth hour
    ///   - count: Number of decade fortunes to calculate
    /// - Returns: Array of DecadeFortuneInfo
    func getDecadeFortunes(gender: Gender, year: Int, month: Int, day: Int, hour: Int, count: Int) -> [DecadeFortuneInfo]
}

/// 大运信息 (DecadeFortune Info)
/// Contains information about a decade fortune period
public struct DecadeFortuneInfo {
    public let index: Int
    public let sixtyCycle: SixtyCycle
    public let startAge: Int
    public let endAge: Int

    public init(index: Int, sixtyCycle: SixtyCycle, startAge: Int, endAge: Int) {
        self.index = index
        self.sixtyCycle = sixtyCycle
        self.startAge = startAge
        self.endAge = endAge
    }

    /// Get name
    public func getName() -> String {
        return sixtyCycle.getName()
    }

    /// Get heaven stem
    public func getHeavenStem() -> HeavenStem {
        return sixtyCycle.getHeavenStem()
    }

    /// Get earth branch
    public func getEarthBranch() -> EarthBranch {
        return sixtyCycle.getEarthBranch()
    }
}
