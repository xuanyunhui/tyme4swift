import Foundation

/// 性别 (Gender)
/// Male and Female
public enum Gender: Int, CaseIterable, CustomStringConvertible {
    case male = 0    // 男
    case female = 1  // 女

    /// Names for Gender
    public static let NAMES = ["男", "女"]

    /// Get name
    public var name: String {
        return Gender.NAMES[rawValue]
    }

    /// CustomStringConvertible
    public var description: String {
        return name
    }

    /// Get Gender from index
    /// - Parameter index: Index (0=男, 1=女)
    /// - Returns: Gender
    public static func fromIndex(_ index: Int) -> Gender {
        return index % 2 == 0 ? .male : .female
    }

    /// Get Gender from name
    /// - Parameter name: Name ("男" or "女")
    /// - Returns: Gender
    public static func fromName(_ name: String) -> Gender {
        return name == "女" ? .female : .male
    }

    /// Check if male
    public var isMale: Bool {
        return self == .male
    }

    /// Check if female
    public var isFemale: Bool {
        return self == .female
    }
}
