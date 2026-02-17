import Foundation

/// 北斗七星 (Big Dipper / Seven Stars of the Northern Dipper)
/// 北斗七星是北半球天空中最显著的星座之一
/// Stars: 天枢, 天璇, 天玑, 天权, 玉衡, 开阳, 摇光
public final class Dipper: LoopTyme {
    /// Star names (北斗七星名称)
    public static let NAMES = ["天枢", "天璇", "天玑", "天权", "玉衡", "开阳", "摇光"]

    /// Alternative names (别名)
    public static let ALTERNATIVE_NAMES = ["贪狼", "巨门", "禄存", "文曲", "廉贞", "武曲", "破军"]

    /// Western names (西方名称)
    public static let WESTERN_NAMES = ["Dubhe", "Merak", "Phecda", "Megrez", "Alioth", "Mizar", "Alkaid"]

    /// Position descriptions (位置描述)
    /// 斗魁: 天枢、天璇、天玑、天权 (勺部)
    /// 斗柄: 玉衡、开阳、摇光 (柄部)
    private static let POSITIONS = ["斗魁", "斗魁", "斗魁", "斗魁", "斗柄", "斗柄", "斗柄"]

    /// Brightness ranking (亮度排名, 1=最亮)
    private static let BRIGHTNESS_RANK = [4, 5, 6, 7, 1, 2, 3]

    /// Initialize with index
    /// - Parameter index: Star index (0-6)
    public convenience init(index: Int) {
        self.init(names: Dipper.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "天枢", "天璇", etc.)
    public convenience init(name: String) throws {
        try self.init(names: Dipper.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        try super.init(names: names, index: index)
    }

    /// Get Dipper star from index
    /// - Parameter index: Star index (0-6)
    /// - Returns: Dipper instance
    public static func fromIndex(_ index: Int) -> Dipper {
        return Dipper(index: index)
    }

    /// Get Dipper star from name
    /// - Parameter name: Star name (e.g., "天枢", "天璇", etc.)
    /// - Returns: Dipper instance
    public static func fromName(_ name: String) throws -> Dipper {
        return try Dipper(name: name)
    }

    /// Get Dipper star from alternative name
    /// - Parameter alternativeName: Alternative name (e.g., "贪狼", "巨门", etc.)
    /// - Returns: Dipper instance
    public static func fromAlternativeName(_ alternativeName: String) throws -> Dipper {
        guard let idx = Dipper.ALTERNATIVE_NAMES.firstIndex(of: alternativeName) else {
            throw TymeError.invalidName(alternativeName)
        }
        return Dipper(index: idx)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next Dipper instance
    public override func next(_ n: Int) -> Dipper {
        return Dipper.fromIndex(nextIndex(n))
    }

    /// Get steps to target index
    /// - Parameter targetIndex: Target index
    /// - Returns: Number of steps
    public func stepsTo(_ targetIndex: Int) -> Int {
        let c = Dipper.NAMES.count
        var i = (targetIndex - index) % c
        if i < 0 { i += c }
        return i
    }

    // MARK: - Properties

    /// Get alternative name
    /// - Returns: Alternative name (e.g., "贪狼")
    public func getAlternativeName() -> String {
        return Dipper.ALTERNATIVE_NAMES[index]
    }

    /// Get western name
    /// - Returns: Western name (e.g., "Dubhe")
    public func getWesternName() -> String {
        return Dipper.WESTERN_NAMES[index]
    }

    /// Get position (斗魁 or 斗柄)
    /// - Returns: Position description
    public func getPosition() -> String {
        return Dipper.POSITIONS[index]
    }

    /// Check if this star is part of the bowl (斗魁)
    /// - Returns: true if part of bowl
    public func isBowl() -> Bool {
        return Dipper.POSITIONS[index] == "斗魁"
    }

    /// Check if this star is part of the handle (斗柄)
    /// - Returns: true if part of handle
    public func isHandle() -> Bool {
        return Dipper.POSITIONS[index] == "斗柄"
    }

    /// Get brightness ranking (1 = brightest)
    /// - Returns: Brightness rank
    public func getBrightnessRank() -> Int {
        return Dipper.BRIGHTNESS_RANK[index]
    }

    /// Get star number (序号)
    /// - Returns: Star number (1-7)
    public func getNumber() -> Int {
        return index + 1
    }
}
