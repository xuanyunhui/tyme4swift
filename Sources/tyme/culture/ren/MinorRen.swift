import Foundation

/// 小六壬
public final class MinorRen: LoopTyme {

    public static let NAMES = ["大安", "留连", "速喜", "赤口", "小吉", "空亡"]

    public convenience init(index: Int) {
        self.init(names: MinorRen.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: MinorRen.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> MinorRen {
        MinorRen(index: index)
    }

    public static func fromName(_ name: String) throws -> MinorRen {
        try MinorRen(name: name)
    }

    public override func next(_ n: Int) -> MinorRen {
        MinorRen.fromIndex(nextIndex(n))
    }

    /// 吉凶
    public func getLuck() -> Luck {
        Luck.fromIndex(index % 2)
    }

    /// 五行
    public func getElement() -> Element {
        Element.fromIndex([0, 4, 1, 3, 0, 2][index])
    }
}
