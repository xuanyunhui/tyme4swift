import Foundation

public final class EarthBranch: LoopTyme {
    public static let NAMES = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]

    public convenience init(index: Int) {
        self.init(names: EarthBranch.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: EarthBranch.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> EarthBranch {
        EarthBranch(index: index)
    }

    public static func fromName(_ name: String) throws -> EarthBranch {
        try EarthBranch(name: name)
    }

    public override func next(_ n: Int) -> EarthBranch {
        EarthBranch.fromIndex(nextIndex(n))
    }

    /// 阴阳
    public var yinYang: YinYang { index % 2 == 0 ? .yang : .yin }

    /// 五行
    public var element: Element { Element.fromIndex([4, 2, 0, 0, 2, 1, 1, 2, 3, 3, 2, 4][index]) }

    /// 生肖
    public var zodiac: Zodiac { Zodiac.fromIndex(index) }

    /// 方位
    public var direction: Direction { Direction.fromIndex([0, 4, 2, 2, 4, 8, 8, 4, 6, 6, 4, 0][index]) }

    /// 煞
    public var ominous: Direction { Direction.fromIndex([8, 2, 0, 6][index % 4]) }

    /// 地支彭祖百忌
    public var pengZuEarthBranch: PengZuEarthBranch { PengZuEarthBranch.fromIndex(index) }

    /// 六冲
    public var opposite: EarthBranch { next(6) }

    /// 六合
    public func getCombine() -> EarthBranch { EarthBranch.fromIndex(1 - index) }

    /// 六害
    public var harm: EarthBranch { EarthBranch.fromIndex(19 - index) }

    /// 合化（无法合化返回 nil）
    public func combine(_ target: EarthBranch) -> Element? {
        getCombine() == target ? Element.fromIndex([2, 2, 0, 1, 3, 4, 2, 2, 4, 3, 1, 0][index]) : nil
    }

    /// 藏干本气
    public var hideHeavenStemMain: HeavenStem {
        HeavenStem.fromIndex([9, 5, 0, 1, 4, 2, 3, 5, 6, 7, 4, 8][index])
    }

    /// 藏干中气
    public var hideHeavenStemMiddle: HeavenStem? {
        let n = [-1, 9, 2, -1, 1, 6, 5, 3, 8, -1, 7, 0][index]
        return n == -1 ? nil : HeavenStem.fromIndex(n)
    }

    /// 藏干余气
    public var hideHeavenStemResidual: HeavenStem? {
        let n = [-1, 7, 4, -1, 9, 4, -1, 1, 4, -1, 3, -1][index]
        return n == -1 ? nil : HeavenStem.fromIndex(n)
    }

    /// 藏干列表
    public var hideHeavenStems: [HideHeavenStem] {
        var result: [HideHeavenStem] = []
        result.append(HideHeavenStem(heavenStem: hideHeavenStemMain, type: .main))
        if let middle = hideHeavenStemMiddle {
            result.append(HideHeavenStem(heavenStem: middle, type: .middle))
        }
        if let residual = hideHeavenStemResidual {
            result.append(HideHeavenStem(heavenStem: residual, type: .residual))
        }
        return result
    }

}
