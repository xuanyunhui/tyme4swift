import Foundation

public final class Element: LoopTyme {
    public static let NAMES = ["木","火","土","金","水"]

    public convenience init(index: Int) {
        self.init(names: Element.NAMES, index: index)
    }

    public convenience init(name: String) throws {
        try self.init(names: Element.NAMES, name: name)
    }

    public required init(names: [String], index: Int) {
        super.init(names: names, index: index)
    }

    public static func fromIndex(_ index: Int) -> Element {
        Element(index: index)
    }

    public static func fromName(_ name: String) throws -> Element {
        try Element(name: name)
    }

    public override func next(_ n: Int) -> Element {
        Element.fromIndex(nextIndex(n))
    }

    /// 我生者
    public var reinforce: Element { next(1) }

    /// 我克者
    public var restrain: Element { next(2) }

    /// 生我者
    public var reinforced: Element { next(-1) }

    /// 克我者
    public var restrained: Element { next(-2) }

    /// 方位
    public var direction: Direction { Direction.fromIndex([2, 8, 4, 6, 0][index]) }
}
