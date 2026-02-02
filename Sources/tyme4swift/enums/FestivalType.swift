import Foundation

/// 节日类型 (FestivalType)
/// Types of festivals
public enum FestivalType: Int, CaseIterable, CustomStringConvertible {
    case day = 0    // 日期型
    case term = 1   // 节气型
    case eve = 2    // 除夕型

    /// Names for FestivalType
    public static let NAMES = ["日期", "节气", "除夕"]

    /// Get name
    public var name: String {
        return FestivalType.NAMES[rawValue]
    }

    /// CustomStringConvertible
    public var description: String {
        return name
    }

    /// Get FestivalType from index
    /// - Parameter index: Index (0=日期, 1=节气, 2=除夕)
    /// - Returns: FestivalType
    public static func fromIndex(_ index: Int) -> FestivalType {
        let i = index % 3
        switch i {
        case 0: return .day
        case 1: return .term
        default: return .eve
        }
    }

    /// Get FestivalType from name
    /// - Parameter name: Name ("日期", "节气", or "除夕")
    /// - Returns: FestivalType
    public static func fromName(_ name: String) -> FestivalType {
        switch name {
        case "节气": return .term
        case "除夕": return .eve
        default: return .day
        }
    }
}
