import Foundation

public final class Direction: LoopTyme {
    /// 依据后天八卦排序（0坎北, 1坤西南, 2震东, 3巽东南, 4中, 5乾西北, 6兑西, 7艮东北, 8离南）
    public static let NAMES = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]

    public convenience init(index: Int) {
        self.init(names: Direction.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: Direction.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> Direction {
        Direction(index: index)
    }

    public static func fromName(_ name: String) throws -> Direction {
        try Direction(name: name)
    }

    public override func next(_ n: Int) -> Direction {
        Direction.fromIndex(nextIndex(n))
    }

    /// 九野
    public var land: Land { Land.fromIndex(index) }

    /// 五行
    public var element: Element { Element.fromIndex([4, 2, 0, 0, 2, 3, 3, 2, 1][index]) }
}
