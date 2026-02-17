import Foundation

/// 六十甲子 (Sixty Cycle)
/// Extended attributes for the 60 SixtyCycle combinations
public final class Sixty: LoopTyme {
    /// Sixty names (六十甲子名称) - same as SixtyCycle
    public static let NAMES = SixtyCycle.NAMES

    /// Initialize with index
    /// - Parameter index: Sixty index (0-59)
    public convenience init(index: Int) {
        self.init(names: Sixty.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Sixty name (e.g., "甲子", "乙丑", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Sixty.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Sixty from index
    /// - Parameter index: Sixty index (0-59)
    /// - Returns: Sixty instance
    public static func fromIndex(_ index: Int) -> Sixty {
        return Sixty(index: index)
    }

    /// Get Sixty from name
    /// - Parameter name: Sixty name (e.g., "甲子", "乙丑", etc.)
    /// - Returns: Sixty instance
    public static func fromName(_ name: String) throws -> Sixty {
        return try Sixty(name: name)
    }

    /// Get next sixty
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Sixty instance
    public override func next(_ n: Int) -> Sixty {
        return Sixty.fromIndex(nextIndex(n))
    }

    public var sixtyCycle: SixtyCycle { SixtyCycle.fromIndex(index) }
    public var naYin: NaYin { NaYin.fromSixtyCycle(index) }
    public var heavenStem: HeavenStem { HeavenStem.fromIndex(index % 10) }
    public var earthBranch: EarthBranch { EarthBranch.fromIndex(index % 12) }

    @available(*, deprecated, renamed: "sixtyCycle")
    public func getSixtyCycle() -> SixtyCycle { sixtyCycle }

    @available(*, deprecated, renamed: "naYin")
    public func getNaYin() -> NaYin { naYin }

    @available(*, deprecated, renamed: "heavenStem")
    public func getHeavenStem() -> HeavenStem { heavenStem }

    @available(*, deprecated, renamed: "earthBranch")
    public func getEarthBranch() -> EarthBranch { earthBranch }
}
