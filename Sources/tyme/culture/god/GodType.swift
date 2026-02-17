import Foundation

/// 神煞类型 (God Type)
/// 年神、月神、日神、时神 - Types of deities in Chinese calendar
public final class GodType: LoopTyme {
    /// GodType names (神煞类型名称)
    public static let NAMES = ["年", "月", "日", "时"]

    /// Initialize with index
    /// - Parameter index: GodType index (0-3)
    public convenience init(index: Int) {
        self.init(names: GodType.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: GodType name (e.g., "年", "月", "日", "时")
    public convenience init(name: String) throws {
        try self.init(names: GodType.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get GodType from index
    /// - Parameter index: GodType index (0-3)
    /// - Returns: GodType instance
    public static func fromIndex(_ index: Int) -> GodType {
        return GodType(index: index)
    }

    /// Get GodType from name
    /// - Parameter name: GodType name (e.g., "年", "月", "日", "时")
    /// - Returns: GodType instance
    public static func fromName(_ name: String) throws -> GodType {
        return try GodType(name: name)
    }

    /// Get next god type
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next GodType instance
    public override func next(_ n: Int) -> GodType {
        return GodType.fromIndex(nextIndex(n))
    }
}
