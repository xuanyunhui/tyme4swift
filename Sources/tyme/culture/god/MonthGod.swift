import Foundation

/// 月神 (Month God)
/// Deities associated with the month
public final class MonthGod: AbstractCulture {
    /// Month god names
    public static let NAMES = [
        "月德", "月空", "月煞", "月刑", "月害",
        "月厌", "大耗", "小耗", "月建", "月破"
    ]

    public let index: Int

    /// Initialize with index
    /// - Parameter index: Month god index (0-9)
    public init(index: Int) {
        var i = index % 10
        if i < 0 { i += 10 }
        self.index = i
        super.init()
    }

    /// Get name
    /// - Returns: Month god name
    public override func getName() -> String {
        return MonthGod.NAMES[index]
    }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    /// Create from index
    /// - Parameter index: Month god index
    /// - Returns: MonthGod instance
    public static func fromIndex(_ index: Int) -> MonthGod {
        return MonthGod(index: index)
    }
}
