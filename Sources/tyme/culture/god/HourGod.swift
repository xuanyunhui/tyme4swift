import Foundation

/// 时神 (Hour God)
/// Deities associated with the hour
public final class HourGod: AbstractCulture {
    /// Hour god names
    public static let NAMES = [
        "日禄", "喜神", "财神", "阳贵", "阴贵",
        "天乙", "天官", "福星", "天德", "月德"
    ]

    public let index: Int

    /// Initialize with index
    /// - Parameter index: Hour god index (0-9)
    public init(index: Int) {
        var i = index % 10
        if i < 0 { i += 10 }
        self.index = i
        super.init()
    }

    /// Get name
    /// - Returns: Hour god name
    public override func getName() -> String {
        return HourGod.NAMES[index]
    }

    @available(*, deprecated, renamed: "index")
    public func getIndex() -> Int { index }

    /// Create from index
    /// - Parameter index: Hour god index
    /// - Returns: HourGod instance
    public static func fromIndex(_ index: Int) -> HourGod {
        return HourGod(index: index)
    }
}
