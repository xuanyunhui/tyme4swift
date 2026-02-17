import Foundation

/// 黄道黑道十二神 (Twelve Stars of Yellow/Black Road)
/// 青龙、明堂、天刑、朱雀、金匮、天德、白虎、玉堂、天牢、玄武、司命、勾陈
/// Used to determine auspicious/inauspicious days
public final class TwelveStar: LoopTyme {
    /// Star names (十二神名称)
    public static let NAMES = ["青龙", "明堂", "天刑", "朱雀", "金匮", "天德", "白虎", "玉堂", "天牢", "玄武", "司命", "勾陈"]

    /// Ecliptic mapping (黄道黑道对应)
    /// 0=黄道(吉), 1=黑道(凶)
    private static let ECLIPTIC_INDICES = [0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1]

    /// Initialize with index
    /// - Parameter index: Star index (0-11)
    public convenience init(index: Int) {
        self.init(names: TwelveStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "青龙", "明堂", etc.)
    public convenience init(name: String) throws {
        try self.init(names: TwelveStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get TwelveStar from index
    /// - Parameter index: Star index (0-11)
    /// - Returns: TwelveStar instance
    public static func fromIndex(_ index: Int) -> TwelveStar {
        return TwelveStar(index: index)
    }

    /// Get TwelveStar from name
    /// - Parameter name: Star name (e.g., "青龙", "明堂", etc.)
    /// - Returns: TwelveStar instance
    public static func fromName(_ name: String) throws -> TwelveStar {
        return try TwelveStar(name: name)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next TwelveStar instance
    public override func next(_ n: Int) -> TwelveStar {
        return TwelveStar.fromIndex(nextIndex(n))
    }

    public var ecliptic: Ecliptic { Ecliptic.fromIndex(TwelveStar.ECLIPTIC_INDICES[index]) }

    /// Check if auspicious (黄道)
    public func isAuspicious() -> Bool { TwelveStar.ECLIPTIC_INDICES[index] == 0 }

    /// Check if inauspicious (黑道)
    public func isInauspicious() -> Bool { TwelveStar.ECLIPTIC_INDICES[index] == 1 }

    @available(*, deprecated, renamed: "ecliptic")
    public func getEcliptic() -> Ecliptic { ecliptic }
}
