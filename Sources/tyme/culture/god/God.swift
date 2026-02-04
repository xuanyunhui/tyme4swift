import Foundation

/// 神煞 (God/Deity)
/// Represents various deities and spirits in Chinese calendar
/// Used for determining auspicious and inauspicious activities
public final class God: AbstractCulture {
    private let godType: GodType
    private let luck: Luck
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

    /// Get god type
    /// - Returns: GodType instance
    public func getGodType() -> GodType {
        return godType
    }

    /// Get luck
    /// - Returns: Luck instance
    public func getLuck() -> Luck {
        return luck
    }

    /// Check if auspicious
    /// - Returns: true if 吉
    public func isAuspicious() -> Bool {
        return luck.isAuspicious()
    }

    /// Check if inauspicious
    /// - Returns: true if 凶
    public func isInauspicious() -> Bool {
        return luck.isInauspicious()
    }
}
