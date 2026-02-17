import Foundation

/// 年神 (Year God)
/// Deities associated with the year
public final class YearGod: AbstractCulture {
    /// Year god names
    public static let NAMES = [
        "太岁", "太阳", "丧门", "太阴", "官符",
        "死符", "岁破", "龙德", "白虎", "福德",
        "吊客", "病符"
    ]

    public let index: Int

    /// Initialize with index
    /// - Parameter index: Year god index (0-11)
    public init(index: Int) {
        var i = index % 12
        if i < 0 { i += 12 }
        self.index = i
        super.init()
    }

    /// Get name
    /// - Returns: Year god name
    public override func getName() -> String {
        return YearGod.NAMES[index]
    }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    /// Create from index
    /// - Parameter index: Year god index
    /// - Returns: YearGod instance
    public static func fromIndex(_ index: Int) -> YearGod {
        return YearGod(index: index)
    }

    /// Create from earth branch
    /// - Parameter earthBranch: Earth branch
    /// - Returns: Array of YearGod instances
    public static func fromEarthBranch(_ earthBranch: EarthBranch) -> [YearGod] {
        var gods: [YearGod] = []
        for i in 0..<12 {
            gods.append(YearGod(index: (earthBranch.index + i) % 12))
        }
        return gods
    }
}
