import Foundation

public final class Direction: LoopTyme {
    public static let NAMES = ["北","东北","东","东南","南","西南","西","西北"]

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
    
    public var angle: Int { index * 45 }

    @available(*, deprecated, renamed: "angle")
    public func getAngle() -> Int { angle }
}
