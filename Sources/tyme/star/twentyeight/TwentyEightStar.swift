import Foundation

/// 二十八宿 (Twenty-Eight Lunar Mansions)
/// The 28 constellations along the celestial equator in Chinese astronomy
/// Divided into 4 groups of 7, each associated with a direction and divine beast
public final class TwentyEightStar: LoopTyme {
    /// Star names (二十八宿名称)
    public static let NAMES = ["角", "亢", "氐", "房", "心", "尾", "箕", "斗", "牛", "女", "虚", "危", "室", "壁", "奎", "娄", "胃", "昴", "毕", "觜", "参", "井", "鬼", "柳", "星", "张", "翼", "轸"]

    /// Land (九野) mapping for each star
    private static let LAND_INDICES = [4, 4, 4, 2, 2, 2, 7, 7, 7, 0, 0, 0, 0, 5, 5, 5, 6, 6, 6, 1, 1, 1, 8, 8, 8, 3, 3, 3]

    /// Luck (吉凶) mapping for each star
    /// 0=吉, 1=凶
    private static let LUCK_INDICES = [0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0]

    /// Initialize with index
    /// - Parameter index: Star index (0-27)
    public convenience init(index: Int) {
        self.init(names: TwentyEightStar.NAMES, index: index)
    }

    /// Initialize with name
    /// - Parameter name: Star name (e.g., "角", "亢", etc.)
    public convenience init(name: String) throws {
        try self.init(names: TwentyEightStar.NAMES, name: name)
    }

    /// Required initializer from LoopTyme
    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    /// Get TwentyEightStar from index
    /// - Parameter index: Star index (0-27)
    /// - Returns: TwentyEightStar instance
    public static func fromIndex(_ index: Int) -> TwentyEightStar {
        return TwentyEightStar(index: index)
    }

    /// Get TwentyEightStar from name
    /// - Parameter name: Star name (e.g., "角", "亢", etc.)
    /// - Returns: TwentyEightStar instance
    public static func fromName(_ name: String) throws -> TwentyEightStar {
        return try TwentyEightStar(name: name)
    }

    /// Get next star
    /// - Parameter n: Number of steps to advance
    /// - Returns: Next TwentyEightStar instance
    public override func next(_ n: Int) -> TwentyEightStar {
        return TwentyEightStar.fromIndex(nextIndex(n))
    }

    public var sevenStar: SevenStar { SevenStar.fromIndex(index % 7 + 4) }
    public var land: Land { Land.fromIndex(TwentyEightStar.LAND_INDICES[index]) }
    public var zone: Zone { Zone.fromIndex(index / 7) }
    public var animal: Animal { Animal.fromIndex(index) }
    public var luck: Luck { Luck.fromIndex(TwentyEightStar.LUCK_INDICES[index]) }

    /// Check if auspicious
    public func isAuspicious() -> Bool { TwentyEightStar.LUCK_INDICES[index] == 0 }

    /// Check if inauspicious
    public func isInauspicious() -> Bool { TwentyEightStar.LUCK_INDICES[index] == 1 }

    @available(*, deprecated, renamed: "sevenStar")
    public func getSevenStar() -> SevenStar { sevenStar }

    @available(*, deprecated, renamed: "land")
    public func getLand() -> Land { land }

    @available(*, deprecated, renamed: "zone")
    public func getZone() -> Zone { zone }

    @available(*, deprecated, renamed: "animal")
    public func getAnimal() -> Animal { animal }

    @available(*, deprecated, renamed: "luck")
    public func getLuck() -> Luck { luck }
}
