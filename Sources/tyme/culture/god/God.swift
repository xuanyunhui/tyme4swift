import Foundation

/// 神煞 (God/Deity)
/// Represents various deities and spirits in Chinese calendar
/// Used for determining auspicious and inauspicious activities
public final class God: AbstractCulture {
    public let godType: GodType
    public let luck: Luck
    private let godName: String

    /// Initialize with type, luck, and name
    /// - Parameters:
    ///   - type: GodType (年, 月, 日, 时)
    ///   - luck: Luck (吉, 凶)
    ///   - name: God name
    public init(type: GodType, luck: Luck, name: String) {
        self.godType = type
        self.luck = luck
        self.godName = name
        super.init()
    }

    /// Get god name
    /// - Returns: God name
    public override func getName() -> String {
        return godName
    }

    public var auspicious: Bool { luck.auspicious }
    public var inauspicious: Bool { luck.inauspicious }

    @available(*, deprecated, renamed: "godType")
    public func getGodType() -> GodType { godType }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> Luck { luck }

    @available(*, deprecated, renamed: "auspicious")
    public func isAuspicious() -> Bool { auspicious }

    @available(*, deprecated, renamed: "inauspicious")
    public func isInauspicious() -> Bool { inauspicious }
}
