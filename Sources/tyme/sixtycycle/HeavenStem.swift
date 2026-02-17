import Foundation

public final class HeavenStem: LoopTyme {
    public static let NAMES = ["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"]

    public convenience init(index: Int) {
        self.init(names: HeavenStem.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: HeavenStem.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> HeavenStem {
        HeavenStem(index: index)
    }

    public static func fromName(_ name: String) throws -> HeavenStem {
        try HeavenStem(name: name)
    }

    public override func next(_ n: Int) -> HeavenStem {
        HeavenStem.fromIndex(nextIndex(n))
    }

    /// 阴阳
    public var yinYang: YinYang { index % 2 == 0 ? .yang : .yin }

    /// 五行
    public var element: Element { Element.fromIndex(index / 2) }

    /// 方位
    public var direction: Direction { element.direction }

    /// 喜神方位
    public var joyDirection: Direction { Direction.fromIndex([7, 5, 1, 8, 3][index % 5]) }

    /// 阳贵神方位
    public var yangDirection: Direction { Direction.fromIndex([1, 1, 6, 5, 7, 0, 8, 7, 2, 3][index]) }

    /// 阴贵神方位
    public var yinDirection: Direction { Direction.fromIndex([7, 0, 5, 6, 1, 1, 7, 8, 3, 2][index]) }

    /// 财神方位
    public var wealthDirection: Direction { Direction.fromIndex([7, 1, 0, 2, 8][index / 2]) }

    /// 福神方位
    public var mascotDirection: Direction { Direction.fromIndex([3, 3, 2, 2, 0, 8, 1, 1, 5, 6][index]) }

    /// 天干彭祖百忌
    public var pengZuHeavenStem: PengZuHeavenStem { PengZuHeavenStem.fromIndex(index) }

    /// 十神
    public func getTenStar(_ target: HeavenStem) -> TenStar {
        let targetIndex = target.index
        var offset = targetIndex - index
        if index % 2 != 0 && targetIndex % 2 == 0 {
            offset += 2
        }
        return TenStar.fromIndex(offset)
    }

    /// 地势（长生十二宫）
    public func getTerrain(_ earthBranch: EarthBranch) -> Terrain {
        let earthBranchIndex = earthBranch.index
        return Terrain.fromIndex([1, 6, 10, 9, 10, 9, 7, 0, 4, 3][index] + (yinYang == .yang ? earthBranchIndex : -earthBranchIndex))
    }

    /// 五合
    public func getCombine() -> HeavenStem { next(5) }

    /// 合化（无法合化返回 nil）
    public func combine(_ target: HeavenStem) -> Element? {
        getCombine() == target ? Element.fromIndex(index + 2) : nil
    }

}
