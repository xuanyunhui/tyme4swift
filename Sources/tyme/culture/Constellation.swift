import Foundation

/// 星座 (Constellation - Western Zodiac)
/// 白羊、金牛、双子、巨蟹、狮子、处女、天秤、天蝎、射手、摩羯、水瓶、双鱼
public final class Constellation: LoopTyme {
    /// Constellation names (星座名称)
    public static let NAMES = ["白羊", "金牛", "双子", "巨蟹", "狮子", "处女", "天秤", "天蝎", "射手", "摩羯", "水瓶", "双鱼"]

    /// Initialize with index
    /// - Parameter index: Constellation index (0-11)
    public convenience init(index: Int) {
        self.init(names: Constellation.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Constellation name (e.g., "白羊", "金牛", etc.)
    public convenience init(name: String) {
        self.init(names: Constellation.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get Constellation from index
    /// - Parameter index: Constellation index (0-11)
    /// - Returns: Constellation instance
    public static func fromIndex(_ index: Int) -> Constellation {
        return Constellation(index: index)
    }

    /// Get Constellation from name
    /// - Parameter name: Constellation name (e.g., "白羊", "金牛", etc.)
    /// - Returns: Constellation instance
    public static func fromName(_ name: String) -> Constellation {
        return Constellation(name: name)
    }

    /// Get next constellation
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Constellation instance
    public override func next(_ n: Int) -> Constellation {
        return Constellation.fromIndex(nextIndex(n))
    }
}
